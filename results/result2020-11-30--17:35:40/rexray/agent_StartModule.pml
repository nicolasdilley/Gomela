
// /tmp/clone-example421986276/agent/agent.go
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
	Chandef startError;
	Chandef started;
	bool state = false;
	Chandef timeout;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(started);
	run sync_monitor(timeout);
	run sync_monitor(startError);
	run Anonymous0(started,timeout,startError);
	run Anonymous1(started,timeout,startError);
	do
	:: started.async_rcv?0 -> 
		break
	:: started.sync?0 -> 
		break
	:: timeout.async_rcv?0 -> 
		goto stop_process
	:: timeout.sync?0 -> 
		goto stop_process
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef started;Chandef timeout;Chandef startError) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: startError.async_send!0;
		:: startError.sync!0 -> 
			startError.sending?0
		fi
	:: true -> 
		
		if
		:: started.async_send!0;
		:: started.sync!0 -> 
			started.sending?0
		fi
	:: true -> 
		
		if
		:: started.async_send!0;
		:: started.sync!0 -> 
			started.sending?0
		fi
	fi;
stop_process:
}
proctype Anonymous1(Chandef started;Chandef timeout;Chandef startError) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: timeout.async_send!0;
	:: timeout.sync!0 -> 
		timeout.sending?0
	fi;
stop_process:
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

