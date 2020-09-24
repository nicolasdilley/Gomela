
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example200123223/resolvers/resolver_state.go
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
	Chandef stateChs_GetStat;
	Chandef stateChs_StopResolver;
	int i;
	Chandef stateChs_UpdateRTT;
	Chandef stateChs_AllStats;
	Chandef stateChs_Done;
	Chandef stateChs_StoppedState;
	Chandef stateChs_AddToStat;
	Chandef stateChs_SetStat;
	Chandef stateChs_ClearStats;
	bool state = false;
	
	if
	:: 2 > 0 -> 
		stateChs_Done.size = 2;
		run emptyChan(stateChs_Done)
	:: else -> 
		run sync_monitor(stateChs_Done)
	fi;
	
	if
	:: 2 > 0 -> 
		stateChs_StopResolver.size = 2;
		run emptyChan(stateChs_StopResolver)
	:: else -> 
		run sync_monitor(stateChs_StopResolver)
	fi;
	
	if
	:: 10 > 0 -> 
		stateChs_StoppedState.size = 10;
		run emptyChan(stateChs_StoppedState)
	:: else -> 
		run sync_monitor(stateChs_StoppedState)
	fi;
	
	if
	:: 10 > 0 -> 
		stateChs_UpdateRTT.size = 10;
		run emptyChan(stateChs_UpdateRTT)
	:: else -> 
		run sync_monitor(stateChs_UpdateRTT)
	fi;
	
	if
	:: 10 > 0 -> 
		stateChs_AddToStat.size = 10;
		run emptyChan(stateChs_AddToStat)
	:: else -> 
		run sync_monitor(stateChs_AddToStat)
	fi;
	
	if
	:: 10 > 0 -> 
		stateChs_GetStat.size = 10;
		run emptyChan(stateChs_GetStat)
	:: else -> 
		run sync_monitor(stateChs_GetStat)
	fi;
	run sync_monitor(stateChs_SetStat);
	
	if
	:: 10 > 0 -> 
		stateChs_AllStats.size = 10;
		run emptyChan(stateChs_AllStats)
	:: else -> 
		run sync_monitor(stateChs_AllStats)
	fi;
	
	if
	:: 10 > 0 -> 
		stateChs_ClearStats.size = 10;
		run emptyChan(stateChs_ClearStats)
	:: else -> 
		run sync_monitor(stateChs_ClearStats)
	fi;
	goto stop_process
stop_process:}

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

