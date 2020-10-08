
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example417746801/weed/command/filer_copy.go
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
	int fileOrDirs = 5;
	Chandef fileCopyTaskChan;
	bool state = false;
	int copy_concurrenctFiles = 5;
	int i;
	
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
	fi;
	
	if
	:: copy_concurrenctFiles > 0 -> 
		fileCopyTaskChan.size = copy_concurrenctFiles;
		run emptyChan(fileCopyTaskChan)
	:: else -> 
		run sync_monitor(fileCopyTaskChan)
	fi;
	run Anonymous0(fileCopyTaskChan);
		for(i : 0.. copy_concurrenctFiles-1) {
for20:		run Anonymous2(fileCopyTaskChan)
	};
for20_exit:	goto stop_process
stop_process:}

proctype commandgenFileCopyTask(Chandef fileCopyTaskChan;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: true -> 
for11:			chan child_commandgenFileCopyTask0 = [0] of {int};
			run commandgenFileCopyTask(fileCopyTaskChan,child_commandgenFileCopyTask0);
			child_commandgenFileCopyTask0?0;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od;
		goto stop_process
	:: true;
	fi;
	
	if
	:: fileCopyTaskChan.async_send!0;
	:: fileCopyTaskChan.sync!0 -> 
		fileCopyTaskChan.sending?0
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef fileCopyTaskChan) {
	bool closed; 
	int i;
		for(i : 1.. fileOrDirs) {
for10:		chan child_commandgenFileCopyTask1 = [0] of {int};
		run commandgenFileCopyTask(fileCopyTaskChan,child_commandgenFileCopyTask0);
		child_commandgenFileCopyTask1?0;
		
		if
		:: true -> 
			break
		:: true;
		fi
	};
	fileCopyTaskChan.closing!true;
stop_process:
}
proctype workercopyFiles(Chandef fileCopyTaskChan;chan child) {
	bool closed; 
	int i;
	do
	:: fileCopyTaskChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: fileCopyTaskChan.async_rcv?0;
			:: fileCopyTaskChan.sync?0;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	od;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous2(Chandef fileCopyTaskChan) {
	bool closed; 
	int i;
	chan child_workercopyFiles2 = [0] of {int};
	run workercopyFiles(fileCopyTaskChan,child_workercopyFiles2);
	child_workercopyFiles2?0;
	
	if
	:: true -> 
		goto stop_process
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

