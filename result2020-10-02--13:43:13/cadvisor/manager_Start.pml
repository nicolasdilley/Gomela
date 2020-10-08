#define lb_for1163_0  -1
#define ub_for1163_1  -1
#define lb_for384_2  -1
#define ub_for384_3  -1
#define lb_for356_4  -1
#define ub_for356_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example924497976/manager/manager.go
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
	chan child_mwatchForNewContainers0 = [0] of {int};
	bool state = false;
	Chandef quitUpdateMachineInfo;
	Chandef quitWatcher;
	Chandef quitGlobalHousekeeping;
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
	run sync_monitor(quitWatcher);
	run mwatchForNewContainers(quitWatcher,child_mwatchForNewContainers0);
	child_mwatchForNewContainers0?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(quitGlobalHousekeeping);
	run go_mglobalHousekeeping(quitGlobalHousekeeping);
	run sync_monitor(quitUpdateMachineInfo);
	run go_mupdateMachineInfo(quitUpdateMachineInfo);
	goto stop_process
stop_process:}

proctype mwatchForNewContainers(Chandef quit;chan child) {
	bool closed; 
	int i;
		for(i : 1.. m_containerWatchers) {
for10:		
		if
		:: true -> 
			do
			:: true -> 
for11:
			:: true -> 
				break
			od;
			goto stop_process
		:: true;
		fi
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous1(quit);
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef quit) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		do
		:: quit.async_rcv?0 -> 
			do
			:: true -> 
for21:
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				
				if
				:: quit.async_send!0;
				:: quit.sync!0 -> 
					quit.sending?0
				fi
			:: true -> 
				
				if
				:: quit.async_send!0;
				:: quit.sync!0 -> 
					quit.sending?0
				fi;
				goto stop_process
			:: true -> 
				
				if
				:: quit.async_send!0;
				:: quit.sync!0 -> 
					quit.sending?0
				fi;
				goto stop_process
			fi;
			break
		:: quit.sync?0 -> 
			do
			:: true -> 
for21:
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				
				if
				:: quit.async_send!0;
				:: quit.sync!0 -> 
					quit.sending?0
				fi
			:: true -> 
				
				if
				:: quit.async_send!0;
				:: quit.sync!0 -> 
					quit.sending?0
				fi;
				goto stop_process
			:: true -> 
				
				if
				:: quit.async_send!0;
				:: quit.sync!0 -> 
					quit.sending?0
				fi;
				goto stop_process
			fi;
			break
		od
	od;
for20_exit:stop_process:
}
proctype go_mglobalHousekeeping(Chandef quit) {
	bool closed; 
	int i;
	do
	:: true -> 
for30:		do
		:: quit.async_rcv?0 -> 
			
			if
			:: quit.async_send!0;
			:: quit.sync!0 -> 
				quit.sending?0
			fi;
			goto stop_process
		:: quit.sync?0 -> 
			
			if
			:: quit.async_send!0;
			:: quit.sync!0 -> 
				quit.sending?0
			fi;
			goto stop_process
		od
	od;
for30_exit:stop_process:
}
proctype go_mupdateMachineInfo(Chandef quit) {
	bool closed; 
	int i;
	do
	:: true -> 
for40:		do
		:: true -> 
			
			if
			:: true -> 
				break
			:: true;
			fi
		:: quit.async_rcv?0 -> 
			
			if
			:: quit.async_send!0;
			:: quit.sync!0 -> 
				quit.sending?0
			fi;
			goto stop_process
		:: quit.sync?0 -> 
			
			if
			:: quit.async_send!0;
			:: quit.sync!0 -> 
				quit.sending?0
			fi;
			goto stop_process
		od
	od;
for40_exit:stop_process:
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

