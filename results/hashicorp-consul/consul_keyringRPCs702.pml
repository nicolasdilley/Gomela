#define keyringRPCs_dcs  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example649438409/agent/consul/rpc.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef respCh;
	Chandef errorCh;
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
			for20175: skip;
			do
			:: errorCh.async_rcv?0 -> 
				goto stop_process
			:: errorCh.sync?0 -> 
				goto stop_process
			:: respCh.async_rcv?0 -> 
				break
			:: respCh.sync?0 -> 
				break
			od;
			for20_end175: skip
		};
		for20_exit175: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			do
			:: errorCh.async_rcv?0 -> 
				goto stop_process
			:: errorCh.sync?0 -> 
				goto stop_process
			:: respCh.async_rcv?0 -> 
				break
			:: respCh.sync?0 -> 
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
	

	if
	:: true -> 
		

		if
		:: errorCh.async_send!0;
		:: errorCh.sync!0 -> 
			errorCh.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: respCh.async_send!0;
	:: respCh.sync!0 -> 
		respCh.sending?0
	fi;
	stop_process: skip
}
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
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
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
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}

