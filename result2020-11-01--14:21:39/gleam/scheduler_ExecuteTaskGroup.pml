#define ExecuteTaskGroup_taskGroup_ParentStepGroup_Parents 3
#define ExecuteTaskGroup_tasks[0]_InputShards 1
#define ExecuteTaskGroup_lastTask_OutputShards 1
#define ExecuteTaskGroup_tasks 1
#define ExecuteTaskGroup_relatedFiles 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example117914275/distributed/driver/scheduler/scheduler_execute_task_group.go
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
	int lastTask_OutputShards = ExecuteTaskGroup_lastTask_OutputShards;
	int taskGroup_ParentStepGroup_Parents = ExecuteTaskGroup_taskGroup_ParentStepGroup_Parents;
	int relatedFiles = ExecuteTaskGroup_relatedFiles;
	Chandef pickedServerChan;
	int tasks[0]_InputShards = ExecuteTaskGroup_tasks[0]_InputShards;
	int tasks = ExecuteTaskGroup_tasks;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. taskGroup_ParentStepGroup_Parents-1) {
for10:
		}
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		pickedServerChan.size = 1;
		run emptyChan(pickedServerChan)
	:: else -> 
		run sync_monitor(pickedServerChan)
	fi;
	
	if
	:: pickedServerChan.async_rcv?0;
	:: pickedServerChan.sync?0;
	fi;
	
	if
	:: true -> 
				for(i : 0.. tasks[0]_InputShards-1) {
for20:
		}
	:: true;
	fi;
		for(i : 0.. lastTask_OutputShards-1) {
for30:
	};
		for(i : 0.. tasks-1) {
for40:
	}
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


