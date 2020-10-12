
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example315123712/src/jobservice/runtime/bootstrap.go
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
	Chandef rootContext_ErrorChan;
	int i;
	Chandef sig;
	bool state = false;
	
	if
	:: 5 > 0 -> 
		rootContext_ErrorChan.size = 5;
		run emptyChan(rootContext_ErrorChan)
	:: else -> 
		run sync_monitor(rootContext_ErrorChan)
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
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	
	if
	:: 1 > 0 -> 
		sig.size = 1;
		run emptyChan(sig)
	:: else -> 
		run sync_monitor(sig)
	fi;
	run Anonymous0(rootContext_ErrorChan,sig);
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: rootContext_ErrorChan.async_send!0;
			:: rootContext_ErrorChan.sync!0 -> 
				rootContext_ErrorChan.sending?0
			fi
		:: true;
		fi
	:: true -> 
		
		if
		:: sig.async_send!0;
		:: sig.sync!0 -> 
			sig.sending?0
		fi
	:: true -> 
		
		if
		:: sig.async_send!0;
		:: sig.sync!0 -> 
			sig.sending?0
		fi
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef errChan;Chandef sig) {
	bool closed; 
	int i;
	do
	:: sig.async_rcv?0 -> 
		goto stop_process
	:: sig.sync?0 -> 
		goto stop_process
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
