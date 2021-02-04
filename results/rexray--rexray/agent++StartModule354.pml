
// https://github.com/rexray/rexray/blob/362035816046e87f7bc5a6ca745760d09a69a40c/agent/agent.go#L354
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
	Chandef startError;
	Chandef timeout;
	Chandef started;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(started);
	run sync_monitor(timeout);
	run sync_monitor(startError);
	run go_Anonymous0(started,timeout,startError);
	run go_Anonymous1(started,timeout,startError);
	do
	:: started.async_rcv?state,num_msgs -> 
		break
	:: started.sync?state,num_msgs -> 
		break
	:: timeout.async_rcv?state,num_msgs -> 
		goto stop_process
	:: timeout.sync?state,num_msgs -> 
		goto stop_process
	:: startError.async_rcv?state,num_msgs -> 
		goto stop_process
	:: startError.sync?state,num_msgs -> 
		goto stop_process
	od;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef started;Chandef timeout;Chandef startError) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: startError.async_send!0;
		:: startError.sync!false,0 -> 
			startError.sending?state
		fi
	:: true -> 
		

		if
		:: started.async_send!0;
		:: started.sync!false,0 -> 
			started.sending?state
		fi
	fi;
	stop_process: skip
}
proctype go_Anonymous1(Chandef started;Chandef timeout;Chandef startError) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: timeout.async_send!0;
	:: timeout.sync!false,0 -> 
		timeout.sending?state
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

