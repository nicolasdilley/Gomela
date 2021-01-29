#define keyringRPCs_dcs  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example385838228/agent/consul/rpc.go
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef respCh;
	Chandef errorCh;
	int num_msgs = 0;
	bool state = false;
	int i;
	int dcs = keyringRPCs_dcs;
	

	if
	:: dcs > 0 -> 
		errorCh.size = dcs;
		run AsyncChan(errorCh)
	:: else -> 
		run sync_monitor(errorCh)
	fi;
	

	if
	:: dcs > 0 -> 
		respCh.size = dcs;
		run AsyncChan(respCh)
	:: else -> 
		run sync_monitor(respCh)
	fi;
		for(i : 0.. dcs-1) {
		for10: skip;
		run go_Anonymous0(errorCh,respCh);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && dcs-1 != -3 -> 
				for(i : 0.. dcs-1) {
			for201258: skip;
			do
			:: errorCh.async_rcv?state,num_msgs -> 
				goto stop_process
			:: errorCh.sync?state,num_msgs -> 
				goto stop_process
			:: respCh.async_rcv?state,num_msgs -> 
				break
			:: respCh.sync?state,num_msgs -> 
				break
			od;
			for20_end1258: skip
		};
		for20_exit1258: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			do
			:: errorCh.async_rcv?state,num_msgs -> 
				goto stop_process
			:: errorCh.sync?state,num_msgs -> 
				goto stop_process
			:: respCh.async_rcv?state,num_msgs -> 
				break
			:: respCh.sync?state,num_msgs -> 
				break
			od;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef errorCh;Chandef respCh) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errorCh.async_send!0;
		:: errorCh.sync!false,0 -> 
			errorCh.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: respCh.async_send!0;
	:: respCh.sync!false,0 -> 
		respCh.sending?state
	fi;
	stop_process: skip
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;  // sending channel is open
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

