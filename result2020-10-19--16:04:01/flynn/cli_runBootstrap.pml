
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example168262774/host/cli/bootstrap.go
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
	Chandef done;
	Chandef ch;
	int i;
	
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
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(ch);
	run sync_monitor(done);
	run Anonymous0(ch,done);
	
	if
	:: true -> 
		chan child_clirunBootstrapBackup8 = [0] of {int};
		run clirunBootstrapBackup(ch,child_clirunBootstrapBackup0);
		child_clirunBootstrapBackup8?0
	:: true -> 
		chan child_bootstrapRun12 = [0] of {int};
		run bootstrapRun(ch,child_bootstrapRun9);
		child_bootstrapRun12?0
	:: true -> 
		chan child_bootstrapRun12 = [0] of {int};
		run bootstrapRun(ch,child_bootstrapRun9);
		child_bootstrapRun12?0
	fi;
	
	if
	:: done.async_rcv?0;
	:: done.sync?0;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef ch;Chandef done) {
	bool closed; 
	int i;
	bool state;
	do
	:: ch.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: ch.async_rcv?0;
			:: ch.sync?0;
			fi
		fi
	od;
	done.closing!true;
stop_process:
}
proctype clirunBootstrapBackup(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_systemStepsRun3 = [0] of {int};
	
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
	:: true -> 
		goto stop_process
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

		if
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		fi
	:: true -> 
		break
	od;
	do
	:: true -> 
for40:		do
		:: true -> 
for41:
		:: true -> 
			break
		od
	:: true -> 
		break
	od;
	run systemStepsRun(ch,child_systemStepsRun0);
	child_systemStepsRun3?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
	
	if
	:: true -> 
		
		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
	
	if
	:: true -> 
		
		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
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
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi;
		
		if
		:: true -> 
			
			if
			:: ch.async_send!0;
			:: ch.sync!0 -> 
				ch.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
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
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi;
		
		if
		:: true -> 
			
			if
			:: ch.async_send!0;
			:: ch.sync!0 -> 
				ch.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
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
		goto stop_process
	:: true;
	fi;
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for70:
	:: true -> 
		break
	od;
	do
	:: true -> 
for80:
	:: true -> 
		break
	od;
	do
	:: true -> 
for90:		do
		:: true -> 
for91:
		:: true -> 
			break
		od
	:: true -> 
		break
	od;
	do
	:: true -> 
for100:		do
		:: true -> 
for101:
		:: true -> 
			break
		od
	:: true -> 
		break
	od;
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
	
	if
	:: true -> 
		
		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for110:		
		if
		:: true -> 
			break
		:: true;
		fi
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: ch.async_send!0;
			:: ch.sync!0 -> 
				ch.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		chan child_stepsRunWithState5 = [0] of {int};
		run stepsRunWithState(ch,child_stepsRunWithState4);
		child_stepsRunWithState5?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		chan child_stepsRunWithState6 = [0] of {int};
		run stepsRunWithState(ch,child_stepsRunWithState6);
		child_stepsRunWithState6?0;
		
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
		do
		:: true -> 
for130:			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true -> 
			break
		od;
		chan child_stepsRunWithState7 = [0] of {int};
		run stepsRunWithState(ch,child_stepsRunWithState7);
		child_stepsRunWithState7?0;
		
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
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi;
		
		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi
	:: true;
	fi;
	goto stop_process;
	ch.closing!true;
	child!0;
stop_process:
}
proctype systemStepsRun(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_mRunWithState2 = [0] of {int};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: true -> 
for50:
		:: true -> 
			break
		od
	:: true;
	fi;
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
	
	if
	:: true -> 
		chan child_bootstrapstepError0 = [0] of {int};
		run bootstrapstepError(ch,child_bootstrapstepError0);
		child_bootstrapstepError0?0;
		goto stop_process
	:: true;
	fi;
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
	run mRunWithState(ch,child_mRunWithState1);
	child_mRunWithState2?0;
	goto stop_process;
	child!0;
stop_process:
}
proctype bootstrapstepError(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
	child!0;
stop_process:
}
proctype mRunWithState(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for60:		
		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi;
		
		if
		:: true -> 
			chan child_bootstrapstepError1 = [0] of {int};
			run bootstrapstepError(ch,child_bootstrapstepError1);
			child_bootstrapstepError1?0;
			goto stop_process
		:: true;
		fi;
		
		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi
	:: true -> 
		break
	od;
	goto stop_process;
	child!0;
stop_process:
}
proctype stepsRunWithState(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for120:		
		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi;
		
		if
		:: true -> 
			chan child_bootstrapstepError4 = [0] of {int};
			run bootstrapstepError(ch,child_bootstrapstepError4);
			child_bootstrapstepError4?0;
			goto stop_process
		:: true;
		fi;
		
		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi
	:: true -> 
		break
	od;
	goto stop_process;
	child!0;
stop_process:
}
proctype bootstrapRun(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_manifestRun11 = [0] of {int};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run manifestRun(ch,child_manifestRun9);
	child_manifestRun11?0;
	goto stop_process;
	ch.closing!true;
	child!0;
stop_process:
}
proctype manifestRun(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_mRunWithState10 = [0] of {int};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: true -> 
for140:
		:: true -> 
			break
		od
	:: true;
	fi;
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
	
	if
	:: true -> 
		chan child_bootstrapstepError9 = [0] of {int};
		run bootstrapstepError(ch,child_bootstrapstepError9);
		child_bootstrapstepError9?0;
		goto stop_process
	:: true;
	fi;
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
	run mRunWithState(ch,child_mRunWithState10);
	child_mRunWithState10?0;
	goto stop_process;
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

