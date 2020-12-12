
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example316110044/runner/grpcRunner.go
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
	int i;
	Chandef errChan;
	Chandef resChan;
	chan child_runnersetupTimer0 = [0] of {int};
	bool state = false;
	run sync_monitor(resChan);
	run sync_monitor(errChan);
	run go_invokeRPC(resChan,errChan);
	run runnersetupTimer(errChan,child_runnersetupTimer0);
	child_runnersetupTimer0?0;
	do
	:: resChan.async_rcv?0 -> 
		goto stop_process
	:: resChan.sync?0 -> 
		goto stop_process
	:: errChan.async_rcv?0 -> 
		goto stop_process
	:: errChan.sync?0 -> 
		goto stop_process
	od
stop_process:}

proctype go_invokeRPC(Chandef resChan;Chandef errChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: errChan.async_send!0;
		:: errChan.sync!0 -> 
			errChan.sending?0
		fi
	:: true -> 
		
		if
		:: resChan.async_send!0;
		:: resChan.sync!0 -> 
			resChan.sending?0
		fi
	:: true -> 
		
		if
		:: resChan.async_send!0;
		:: resChan.sync!0 -> 
			resChan.sending?0
		fi
	fi;
stop_process:
}
proctype runnersetupTimer(Chandef errChan;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
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

