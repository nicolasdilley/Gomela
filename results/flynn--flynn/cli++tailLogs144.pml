#define ub_for135_0  -2

// https://github.com/flynn/flynn/blob/eecb13ba8d5f4228c24dce308293f9c65075c949/host/cli/log.go#L144
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
	Chandef gather2;
	Chandef gather1;
	int num_msgs = 0;
	bool state = false;
	int i;
	run sync_monitor(gather1);
	run sync_monitor(gather2);
	run go_scanLogs(gather1);
	run go_scanLogs(gather2);
	do
	:: true -> 
		for20: skip;
		do
		:: gather1.async_rcv?state,num_msgs -> 
			break
		:: gather1.sync?state,num_msgs -> 
			break
		:: gather2.async_rcv?state,num_msgs -> 
			break
		:: gather2.sync?state,num_msgs -> 
			break
		od;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		for20_end: skip
	od;
	for20_exit: skip
stop_process:skip
}

proctype go_scanLogs(Chandef output) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: 0 != -2 && ub_for135_0 != -2 -> 
				for(i : 0.. ub_for135_0) {
			for101133: skip;
			

			if
			:: output.async_send!0;
			:: output.sync!false,0 -> 
				output.sending?state
			fi;
			for10_end1133: skip
		};
		for10_exit1133: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: output.async_send!0;
			:: output.sync!false,0 -> 
				output.sending?state
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	output.closing!true;
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

