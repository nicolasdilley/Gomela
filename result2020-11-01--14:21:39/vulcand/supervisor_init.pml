
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example326769424/supervisor/supervisor.go
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
	Chandef s_watcherCancelC;
	Chandef changesC;
	bool state = false;
	Chandef s_watcherErrorC;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 2000 > 0 -> 
		changesC.size = 2000;
		run emptyChan(changesC)
	:: else -> 
		run sync_monitor(changesC)
	fi;
	
	if
	:: 1 > 0 -> 
		s_watcherErrorC.size = 1;
		run emptyChan(s_watcherErrorC)
	:: else -> 
		run sync_monitor(s_watcherErrorC)
	fi;
	run sync_monitor(s_watcherCancelC);
	run Anonymous0(changesC,s_watcherErrorC,s_watcherCancelC);
	
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
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		run Anonymous1(changesC,s_watcherErrorC,s_watcherCancelC)
	:: true;
	fi;
	run Anonymous2(changesC,s_watcherErrorC,s_watcherCancelC);
	goto stop_process;
	
	if
	:: true -> 
		s_watcherCancelC.closing!true
	:: true;
	fi
stop_process:}

proctype Anonymous0(Chandef changesC;Chandef s_watcherErrorC;Chandef s_watcherCancelC) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
stop_process:	changesC.closing!true
}
proctype Anonymous1(Chandef changesC;Chandef s_watcherErrorC;Chandef s_watcherCancelC) {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous2(Chandef changesC;Chandef s_watcherErrorC;Chandef s_watcherCancelC) {
	bool closed; 
	int i;
	bool state;
	do
	:: changesC.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: changesC.async_rcv?0;
			:: changesC.sync?0;
			fi
		fi
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

