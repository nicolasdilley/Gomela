
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example076315280/components/engine/builder/dockerfile/containerbackend.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
}



init { 
	Chandef finished;
	Chandef attached;
	int i;
	Chandef errCh;
	Chandef cancelErrCh;
	bool state = false;
	run sync_monitor(attached);
	
	if
	:: 1 > 0 -> 
		errCh.size = 1;
		run emptyChan(errCh)
	:: else -> 
		run sync_monitor(errCh)
	fi;
	run Anonymous0(attached,errCh,finished,cancelErrCh);
	do
	:: attached.async_rcv?0 -> 
		break
	:: attached.sync?0 -> 
		break
	od;
	run sync_monitor(finished);
	
	if
	:: 1 > 0 -> 
		cancelErrCh.size = 1;
		run emptyChan(cancelErrCh)
	:: else -> 
		run sync_monitor(cancelErrCh)
	fi;
	run Anonymous1(attached,errCh,finished,cancelErrCh);
	
	if
	:: true -> 
		finished.closing!true;
		chan child_dockerfilelogCancellationError0 = [0] of {int};
		run dockerfilelogCancellationError(cancelErrCh,child_dockerfilelogCancellationError0);
		child_dockerfilelogCancellationError0?0;
		goto stop_process
	:: true;
	fi;
	
	if
	:: errCh.async_rcv?0;
	:: errCh.sync?0;
	fi;
	
	if
	:: true -> 
		finished.closing!true;
		chan child_dockerfilelogCancellationError1 = [0] of {int};
		run dockerfilelogCancellationError(cancelErrCh,child_dockerfilelogCancellationError1);
		child_dockerfilelogCancellationError1?0;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		finished.closing!true;
		chan child_dockerfilelogCancellationError2 = [0] of {int};
		run dockerfilelogCancellationError(cancelErrCh,child_dockerfilelogCancellationError2);
		child_dockerfilelogCancellationError2?0;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		finished.closing!true;
		chan child_dockerfilelogCancellationError3 = [0] of {int};
		run dockerfilelogCancellationError(cancelErrCh,child_dockerfilelogCancellationError3);
		child_dockerfilelogCancellationError3?0;
		goto stop_process
	:: true;
	fi;
	finished.closing!true;
	
	if
	:: cancelErrCh.async_rcv?0;
	:: cancelErrCh.sync?0;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef attached;Chandef errCh;Chandef finished;Chandef cancelErrCh) {
	bool closed; 
	int i;
	
	if
	:: errCh.async_send!0;
	:: errCh.sync!0 -> 
		errCh.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef attached;Chandef errCh;Chandef finished;Chandef cancelErrCh) {
	bool closed; 
	int i;
	do
	:: true -> 
		
		if
		:: cancelErrCh.async_send!0;
		:: cancelErrCh.sync!0 -> 
			cancelErrCh.sending?0
		fi
	:: finished.async_rcv?0 -> 
		
		if
		:: cancelErrCh.async_send!0;
		:: cancelErrCh.sync!0 -> 
			cancelErrCh.sending?0
		fi;
		break
	:: finished.sync?0 -> 
		
		if
		:: cancelErrCh.async_send!0;
		:: cancelErrCh.sync!0 -> 
			cancelErrCh.sending?0
		fi;
		break
	od;
stop_process:
}
proctype dockerfilelogCancellationError(Chandef cancelErrCh;chan child) {
	bool closed; 
	int i;
	
	if
	:: cancelErrCh.async_rcv?0;
	:: cancelErrCh.sync?0;
	fi;
	child!0;
stop_process:
}
proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
stop_process:
}

proctype emptyChan(Chandef ch) {
end: if
	 :: ch.async_send?0 -> // a message has been received
    ch.num_msgs = ch.num_msgs + 1
    if
    :: ch.num_msgs == ch.size ->
      run fullChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
    run closedChan(ch)
  :: ch.is_closed!false ->
    run emptyChan(ch) // sending channel is open 
  :: ch.sending!false ->
    run emptyChan(ch) // sending channel is open 
fi;
}

proctype fullChan(Chandef ch) {
end: if
  :: ch.async_rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending channel is open 
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
fi;
}

proctype neitherChan(Chandef ch) {
end: if
  :: ch.async_send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.async_rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending channel is open
     run neitherChan(ch)
  :: ch.sending!false ->  // sending channel is open
     run neitherChan(ch)
fi;
}

proctype closedChan(Chandef ch) {
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true -> // sending state of channel (closed)
    run closedChan(ch)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0 -> // can always receive on a closed chan
    run closedChan(ch)
  fi;
}

