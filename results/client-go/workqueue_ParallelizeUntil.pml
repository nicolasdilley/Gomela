#define chunks  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example379071371/util/workqueue/parallelizer.go
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
	bool state = false;
	int toProcess = 5;
	Wgdef wg;
	int start = 5;
	Chandef toProcess;
	int chunks = 5;
	int end = 5;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:
	:: true -> 
		break
	od;
	
	if
	:: chunks > 0 -> 
		toProcess.size = chunks;
		run emptyChan(toProcess)
	:: else -> 
		run sync_monitor(toProcess)
	fi;
	
	if
	:: 0 != -1 && chunks-1 != -1 -> 
				for(i : 0.. chunks-1) {
for20:			
			if
			:: toProcess.async_send!0;
			:: toProcess.sync!0 -> 
				toProcess.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: toProcess.async_send!0;
			:: toProcess.sync!0 -> 
				toProcess.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	toProcess.closing!true;
	run wgMonitor(wg);
	wg.Add!workers;
		for(i : 0.. workers-1) {
for30:		run Anonymous0(toProcess)
	};
for30_exit:	wg.Wait?0
stop_process:}

proctype Anonymous0(Chandef toProcess) {
	bool closed; 
	int i;
	do
	:: toProcess.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			toProcess.in?0;
			
			if
			:: start != -1 && end-1 != -1 -> 
								for(i : start.. end-1) {
for32:					do
					:: true -> 
						goto stop_process
					:: true -> 
						break
					od
				}
			:: else -> 
				do
				:: true -> 
for32:					do
					:: true -> 
						goto stop_process
					:: true -> 
						break
					od
				:: true -> 
					break
				od
			fi;
for32_exit:
		fi
	od;
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

