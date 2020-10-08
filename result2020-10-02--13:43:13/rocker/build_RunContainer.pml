
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example423866052/src/build/client.go
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
	int i;
	Chandef errch;
	Chandef success;
	Chandef sigch;
	Chandef attacherr;
	bool state = false;
	run sync_monitor(success);
	
	if
	:: 1 > 0 -> 
		finished.size = 1;
		run emptyChan(finished)
	:: else -> 
		run sync_monitor(finished)
	fi;
	
	if
	:: 1 > 0 -> 
		sigch.size = 1;
		run emptyChan(sigch)
	:: else -> 
		run sync_monitor(sigch)
	fi;
	
	if
	:: 1 > 0 -> 
		errch.size = 1;
		run emptyChan(errch)
	:: else -> 
		run sync_monitor(errch)
	fi;
	
	if
	:: 1 > 0 -> 
		attacherr.size = 1;
		run emptyChan(attacherr)
	:: else -> 
		run sync_monitor(attacherr)
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run Anonymous0(success,finished,sigch,errch,attacherr);
	
	if
	:: success.async_rcv?0;
	:: success.sync?0;
	fi;
	
	if
	:: success.async_send!0;
	:: success.sync!0 -> 
		success.sending?0
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run Anonymous1(success,finished,sigch,errch,attacherr);
	do
	:: sigch.async_rcv?0 -> 
		break
	:: sigch.sync?0 -> 
		break
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef success;Chandef finished;Chandef sigch;Chandef errch;Chandef attacherr) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		do
		:: finished.async_rcv?0 -> 
			goto stop_process
		:: finished.sync?0 -> 
			goto stop_process
		:: true -> 
			
			if
			:: attacherr.async_send!0;
			:: attacherr.sync!0 -> 
				attacherr.sending?0
			fi;
			break
		od
	:: true;
	fi;
stop_process:
}
proctype Anonymous1(Chandef success;Chandef finished;Chandef sigch;Chandef errch;Chandef attacherr) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: errch.async_send!0;
		:: errch.sync!0 -> 
			errch.sending?0
		fi
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: errch.async_send!0;
			:: errch.sync!0 -> 
				errch.sending?0
			fi
		:: true;
		fi
	fi;
	
	if
	:: errch.async_send!0;
	:: errch.sync!0 -> 
		errch.sending?0
	fi;
	goto stop_process;
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

