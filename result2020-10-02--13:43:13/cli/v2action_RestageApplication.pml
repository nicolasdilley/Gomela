#define lb_for355_0  -1
#define ub_for355_1  -1
#define lb_for379_2  -1
#define ub_for379_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example437927461/actor/v2action/application.go
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
	Chandef errs;
	Chandef appState;
	int i;
	Chandef allWarnings;
	int warnings = 5;
	bool state = false;
	run sync_monitor(appState);
	run sync_monitor(allWarnings);
	run sync_monitor(errs);
	run Anonymous0(appState,allWarnings,errs);
	goto stop_process
stop_process:}

proctype actorwaitForApplicationStageAndStart(Chandef appState;Chandef allWarnings;Chandef errs;chan child) {
	bool closed; 
	int i;
	chan child_actorpollStaging0 = [0] of {int};
	chan child_actorpollStartup1 = [0] of {int};
	run actorpollStaging(allWarnings,child_actorpollStaging0);
	child_actorpollStaging0?0;
	
	if
	:: true -> 
		
		if
		:: errs.async_send!0;
		:: errs.sync!0 -> 
			errs.sending?0
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
	:: appState.async_send!0;
	:: appState.sync!0 -> 
		appState.sending?0
	fi;
	run actorpollStartup(allWarnings,child_actorpollStartup1);
	child_actorpollStartup1?0;
	
	if
	:: true -> 
		
		if
		:: errs.async_send!0;
		:: errs.sync!0 -> 
			errs.sending?0
		fi
	:: true;
	fi;
	child!0;
stop_process:
}
proctype actorpollStaging(Chandef allWarnings;chan child) {
	bool closed; 
	int i;
	
	if
	:: lb_for355_0 != -1 && ub_for355_1 != -1 -> 
				for(i : lb_for355_0.. ub_for355_1) {
for20:						for(i : 1.. warnings) {
for21:				
				if
				:: allWarnings.async_send!0;
				:: allWarnings.sync!0 -> 
					allWarnings.sending?0
				fi
			};
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				goto stop_process
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:						for(i : 1.. warnings) {
for21:				
				if
				:: allWarnings.async_send!0;
				:: allWarnings.sync!0 -> 
					allWarnings.sending?0
				fi
			};
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				goto stop_process
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process;
	child!0;
stop_process:
}
proctype actorpollStartup(Chandef allWarnings;chan child) {
	bool closed; 
	int i;
	
	if
	:: lb_for379_2 != -1 && ub_for379_3 != -1 -> 
				for(i : lb_for379_2.. ub_for379_3) {
for30:						for(i : 1.. warnings) {
for31:				
				if
				:: allWarnings.async_send!0;
				:: allWarnings.sync!0 -> 
					allWarnings.sending?0
				fi
			};
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
for32:				

				if
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				fi
			:: true -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for30:						for(i : 1.. warnings) {
for31:				
				if
				:: allWarnings.async_send!0;
				:: allWarnings.sync!0 -> 
					allWarnings.sending?0
				fi
			};
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
for32:				

				if
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				:: true -> 
					goto stop_process
				fi
			:: true -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for30_exit:	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef appState;Chandef allWarnings;Chandef errs) {
	bool closed; 
	int i;
	chan child_actorwaitForApplicationStageAndStart2 = [0] of {int};
	
	if
	:: appState.async_send!0;
	:: appState.sync!0 -> 
		appState.sending?0
	fi;
		for(i : 1.. warnings) {
for10:		
		if
		:: allWarnings.async_send!0;
		:: allWarnings.sync!0 -> 
			allWarnings.sending?0
		fi
	};
	
	if
	:: true -> 
		
		if
		:: errs.async_send!0;
		:: errs.sync!0 -> 
			errs.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	run actorwaitForApplicationStageAndStart(appState,allWarnings,errs,child_actorwaitForApplicationStageAndStart0);
	child_actorwaitForApplicationStageAndStart2?0;
	appState.closing!true;
	allWarnings.closing!true;
	errs.closing!true;
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

