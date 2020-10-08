#define lb_for234_0  -1
#define ub_for234_1  -1
#define lb_for281_2  -1
#define ub_for281_3  -1
#define lb_for419_4  -1
#define ub_for419_5  -1
#define lb_for376_6  -1
#define ub_for376_7  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example704493025/pkg/logs/tekton_logging.go
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
	Chandef ch;
	bool state = false;
	run sync_monitor(ch);
	run Anonymous0(ch);
	goto stop_process
stop_process:}

proctype tgetRunningBuildLogs(Chandef out;chan child) {
	bool closed; 
	int i;
	
	if
	:: lb_for234_0 != -1 && ub_for234_1 != -1 -> 
				for(i : lb_for234_0.. ub_for234_1) {
for10:			
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
				fi;
				
				if
				:: lb_for281_2 != -1 && ub_for281_3 != -1 -> 
										for(i : lb_for281_2.. ub_for281_3) {
for11:						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi;
						do
						:: true -> 
for12:							
							if
							:: true -> 
								chan child_tgetContainerLogsFromPod3 = [0] of {int};
								run tgetContainerLogsFromPod(out,child_tgetContainerLogsFromPod0);
								child_tgetContainerLogsFromPod3?0;
								
								if
								:: true -> 
									goto stop_process
								:: true;
								fi
							:: true;
							fi
						:: true -> 
							break
						od;
						
						if
						:: true -> 
							break
						:: true;
						fi
					}
				:: else -> 
					do
					:: true -> 
for11:						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi;
						do
						:: true -> 
for12:							
							if
							:: true -> 
								chan child_tgetContainerLogsFromPod3 = [0] of {int};
								run tgetContainerLogsFromPod(out,child_tgetContainerLogsFromPod0);
								child_tgetContainerLogsFromPod3?0;
								
								if
								:: true -> 
									goto stop_process
								:: true;
								fi
							:: true;
							fi
						:: true -> 
							break
						od;
						
						if
						:: true -> 
							break
						:: true;
						fi
					:: true -> 
						break
					od
				fi;
for11_exit:
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
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
				fi;
				
				if
				:: lb_for281_2 != -1 && ub_for281_3 != -1 -> 
										for(i : lb_for281_2.. ub_for281_3) {
for11:						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi;
						do
						:: true -> 
for12:							
							if
							:: true -> 
								chan child_tgetContainerLogsFromPod3 = [0] of {int};
								run tgetContainerLogsFromPod(out,child_tgetContainerLogsFromPod0);
								child_tgetContainerLogsFromPod3?0;
								
								if
								:: true -> 
									goto stop_process
								:: true;
								fi
							:: true;
							fi
						:: true -> 
							break
						od;
						
						if
						:: true -> 
							break
						:: true;
						fi
					}
				:: else -> 
					do
					:: true -> 
for11:						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi;
						do
						:: true -> 
for12:							
							if
							:: true -> 
								chan child_tgetContainerLogsFromPod3 = [0] of {int};
								run tgetContainerLogsFromPod(out,child_tgetContainerLogsFromPod0);
								child_tgetContainerLogsFromPod3?0;
								
								if
								:: true -> 
									goto stop_process
								:: true;
								fi
							:: true;
							fi
						:: true -> 
							break
						od;
						
						if
						:: true -> 
							break
						:: true;
						fi
					:: true -> 
						break
					od
				fi;
for11_exit:
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype tgetContainerLogsFromPod(Chandef out;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for13:		chan child_twaitForContainerToStart0 = [0] of {int};
		run twaitForContainerToStart(out,child_twaitForContainerToStart0);
		child_twaitForContainerToStart0?0;
		
		if
		:: out.async_send!0;
		:: out.sync!0 -> 
			out.sending?0
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		chan child_tfetchLogsToChannel2 = [0] of {int};
		run tfetchLogsToChannel(out,child_tfetchLogsToChannel1);
		child_tfetchLogsToChannel2?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: out.async_send!0;
			:: out.sync!0 -> 
				out.sending?0
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
			break
		:: true;
		fi
	:: true -> 
		break
	od;
	goto stop_process;
	child!0;
stop_process:
}
proctype twaitForContainerToStart(Chandef out;chan child) {
	bool closed; 
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
	:: out.async_send!0;
	:: out.sync!0 -> 
		out.sending?0
	fi;
	do
	:: true -> 
for14:		
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
	od;
for14_exit:	child!0;
stop_process:
}
proctype tfetchLogsToChannel(Chandef out;chan child) {
	bool closed; 
	int i;
	chan child_logswriteStreamLines1 = [0] of {int};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run logswriteStreamLines(out,child_logswriteStreamLines1);
	child_logswriteStreamLines1?0;
	goto stop_process;
	child!0;
stop_process:
}
proctype logswriteStreamLines(Chandef out;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for15:		
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
		:: out.async_send!0;
		:: out.sync!0 -> 
			out.sending?0
		fi
	od;
for15_exit:	child!0;
stop_process:
}
proctype Anonymous0(Chandef ch) {
	bool closed; 
	int i;
	chan child_tgetRunningBuildLogs4 = [0] of {int};
	run tgetRunningBuildLogs(ch,child_tgetRunningBuildLogs0);
	child_tgetRunningBuildLogs4?0;
	ch.closing!true;
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

