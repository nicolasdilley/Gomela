
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example941605589/cmd/control/service/app/app.go
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
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		Chandef signalChan;
		
		if
		:: 1 > 0 -> 
			signalChan.size = 1;
			run emptyChan(signalChan)
		:: else -> 
			run sync_monitor(signalChan)
		fi;
		Chandef cleanupDone;
		run sync_monitor(cleanupDone);
		Chandef errChan;
		run sync_monitor(errChan);
		run Anonymous0(signalChan,cleanupDone,errChan);
		run Anonymous1(signalChan,cleanupDone,errChan);
		
		if
		:: cleanupDone.async_rcv?0;
		:: cleanupDone.sync?0;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef signalChan;Chandef cleanupDone;Chandef errChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: errChan.async_send!0;
	:: errChan.sync!0 -> 
		errChan.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef signalChan;Chandef cleanupDone;Chandef errChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: signalChan.async_rcv?0 -> 
		
		if
		:: cleanupDone.async_send!0;
		:: cleanupDone.sync!0 -> 
			cleanupDone.sending?0
		fi;
		break
	:: signalChan.sync?0 -> 
		
		if
		:: cleanupDone.async_send!0;
		:: cleanupDone.sync!0 -> 
			cleanupDone.sending?0
		fi;
		break
	:: errChan.async_rcv?0 -> 
		
		if
		:: cleanupDone.async_send!0;
		:: cleanupDone.sync!0 -> 
			cleanupDone.sending?0
		fi;
		break
	:: errChan.sync?0 -> 
		
		if
		:: cleanupDone.async_send!0;
		:: cleanupDone.sync!0 -> 
			cleanupDone.sending?0
		fi;
		break
	od;
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

