
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example595304606/tools/portforward/portforward.go
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
	Chandef remoteDone;
	Chandef errorChan;
	bool state = false;
	Chandef localError;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(errorChan);
	run Anonymous0(errorChan,localError,remoteDone);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(localError);
	run sync_monitor(remoteDone);
	run Anonymous1(errorChan,localError,remoteDone);
	run Anonymous2(errorChan,localError,remoteDone);
	do
	:: remoteDone.async_rcv?0 -> 
		break
	:: remoteDone.sync?0 -> 
		break
	:: localError.async_rcv?0 -> 
		break
	:: localError.sync?0 -> 
		break
	od;
	
	if
	:: errorChan.async_rcv?0;
	:: errorChan.sync?0;
	fi
stop_process:}

proctype Anonymous0(Chandef errorChan;Chandef localError;Chandef remoteDone) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		
		if
		:: errorChan.async_send!0;
		:: errorChan.sync!0 -> 
			errorChan.sending?0
		fi
	:: true -> 
		
		if
		:: errorChan.async_send!0;
		:: errorChan.sync!0 -> 
			errorChan.sending?0
		fi
	fi;
	errorChan.closing!true;
stop_process:
}
proctype Anonymous1(Chandef errorChan;Chandef localError;Chandef remoteDone) {
	bool closed; 
	int i;
	bool state;
	remoteDone.closing!true;
stop_process:
}
proctype Anonymous2(Chandef errorChan;Chandef localError;Chandef remoteDone) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		localError.closing!true
	:: true;
	fi;
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

