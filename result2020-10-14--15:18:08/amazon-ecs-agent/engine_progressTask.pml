#define progressTask_mtask_Containers  60
#define progressTask_resources  60
#define progressTask_resTransitions  60
#define progressTask_contTransitions  60
#define lb_for812_4  -1
#define ub_for812_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example903376618/agent/engine/docker_task_engine.go
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
	int mtask_Containers = progressTask_mtask_Containers;
	Chandef transitionChangeEntity;
	int resTransitions = progressTask_resTransitions;
	Chandef transitionChange;
	chan child_mtaskwaitForTransition0 = [0] of {int};
	int resources = progressTask_resources;
	int contTransitions = progressTask_contTransitions;
	bool state = false;
	
	if
	:: mtask_Containers + resources > 0 -> 
		transitionChange.size = mtask_Containers + resources;
		run emptyChan(transitionChange)
	:: else -> 
		run sync_monitor(transitionChange)
	fi;
	
	if
	:: mtask_Containers + resources > 0 -> 
		transitionChangeEntity.size = mtask_Containers + resources;
		run emptyChan(transitionChangeEntity)
	:: else -> 
		run sync_monitor(transitionChangeEntity)
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: lb_for812_4 != -1 && ub_for812_5 != -1 -> 
						for(i : lb_for812_4.. ub_for812_5) {
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
for10_exit:		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for20:
	:: true -> 
		break
	od;
	do
	:: true -> 
for30:
	:: true -> 
		break
	od;
	run mtaskwaitForTransition(transitionChange,transitionChangeEntity,child_mtaskwaitForTransition0);
	child_mtaskwaitForTransition0?0
stop_process:}

proctype mtaskwaitForTransition(Chandef transition;Chandef transitionChangeEntity;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: transitionChangeEntity.async_rcv?0;
	:: transitionChangeEntity.sync?0;
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

