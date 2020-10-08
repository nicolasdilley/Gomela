#define lb_for263_0  -1
#define ub_for263_1  -1
#define lb_for287_2  -1
#define ub_for287_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example004441286/manager/orchestrator/update/updater.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	bool state = false;
	int dirtySlots = 5;
	Chandef slotQueue;
	int parallelism = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. slots) {
for10:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(slotQueue);
	run wgMonitor(wg);
	wg.Add!parallelism;
		for(i : 0.. parallelism-1) {
for20:		run Anonymous0(slotQueue)
	};
for20_exit:slotsLoop:			for(i : 1.. dirtySlots) {
for30:retryLoop:				do
		:: true -> 
for31:			do
			:: true -> 
				goto slotsLoop
			:: slotQueue.async_send!0 -> 
				goto retryLoop;
				break
			:: slotQueue.sync!0 -> 
				slotQueue.sending?0;
				goto retryLoop;
				break
			od
		od;
for31_exit:
	};
	slotQueue.closing!true;
	wg.Wait?0;
	
	if
	:: true -> 
monitorLoop:				do
		:: true -> 
for40:			do
			:: true -> 
				goto monitorLoop
			:: true -> 
				goto monitorLoop
			od
		od;
for40_exit:
	:: true;
	fi
stop_process:}

proctype uworker(Chandef queue;chan child) {
	bool closed; 
	int i;
	do
	:: queue.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: queue.async_rcv?0;
			:: queue.sync?0;
			fi;
			do
			:: true -> 
for22:				
				if
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi
				:: true;
				fi
			:: true -> 
				break
			od;
			
			if
			:: true -> 
				do
				:: true;
				:: true -> 
					goto stop_process
				od
			:: true;
			fi
		fi
	od;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef slotQueue) {
	bool closed; 
	int i;
	chan child_uworker0 = [0] of {int};
	run uworker(slotQueue,child_uworker0);
	child_uworker0?0;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
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

