
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example097968694/app.go
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
	int i;
	Chandef endRunning;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		endRunning.size = 1;
		run emptyChan(endRunning)
	:: else -> 
		run sync_monitor(endRunning)
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: 0 != -1 && mws - 1 != -1 -> 
				for(i : 0.. mws - 1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		
		if
		:: true -> 
			run Anonymous0(endRunning)
		:: true;
		fi;
		
		if
		:: true -> 
			run Anonymous1(endRunning)
		:: true;
		fi;
		
		if
		:: endRunning.async_rcv?0;
		:: endRunning.sync?0;
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		run Anonymous2(endRunning)
	:: true;
	fi;
	
	if
	:: true -> 
		run Anonymous3(endRunning)
	:: true;
	fi;
	
	if
	:: endRunning.async_rcv?0;
	:: endRunning.sync?0;
	fi
stop_process:}

proctype Anonymous0(Chandef endRunning) {
	bool closed; 
	int i;
	
	if
	:: endRunning.async_send!0;
	:: endRunning.sync!0 -> 
		endRunning.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef endRunning) {
	bool closed; 
	int i;
	
	if
	:: endRunning.async_send!0;
	:: endRunning.sync!0 -> 
		endRunning.sending?0
	fi;
stop_process:
}
proctype Anonymous2(Chandef endRunning) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	fi;
	
	if
	:: true -> 
		
		if
		:: endRunning.async_send!0;
		:: endRunning.sync!0 -> 
			endRunning.sending?0
		fi
	:: true;
	fi;
stop_process:
}
proctype Anonymous3(Chandef endRunning) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: endRunning.async_send!0;
			:: endRunning.sync!0 -> 
				endRunning.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: endRunning.async_send!0;
			:: endRunning.sync!0 -> 
				endRunning.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: endRunning.async_send!0;
			:: endRunning.sync!0 -> 
				endRunning.sending?0
			fi
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: endRunning.async_send!0;
			:: endRunning.sync!0 -> 
				endRunning.sending?0
			fi
		:: true;
		fi
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

