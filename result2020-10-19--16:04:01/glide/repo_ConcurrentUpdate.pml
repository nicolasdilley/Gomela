#define ConcurrentUpdate_concurrentWorkers  5
#define ConcurrentUpdate_deps  5
#define lb_for519_2  -1
#define ub_for519_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example506870542/repo/installer.go
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
	Chandef in;
	int i;
	int concurrentWorkers = ConcurrentUpdate_concurrentWorkers;
	Chandef done;
	Wgdef wg;
	int deps = ConcurrentUpdate_deps;
	bool state = false;
	
	if
	:: concurrentWorkers > 0 -> 
		done.size = concurrentWorkers;
		run emptyChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	
	if
	:: concurrentWorkers > 0 -> 
		in.size = concurrentWorkers;
		run emptyChan(in)
	:: else -> 
		run sync_monitor(in)
	fi;
	run wgMonitor(wg);
		for(i : 0.. concurrentWorkers-1) {
for10:		run Anonymous0(in,done,wg)
	};
for10_exit:		for(i : 1.. deps) {
for20:		
		if
		:: true -> 
			wg.Add!1;
			
			if
			:: in.async_send!0;
			:: in.sync!0 -> 
				in.sending?0
			fi
		:: true;
		fi
	};
	wg.Wait?0;
	
	if
	:: 0 != -1 && concurrentWorkers-1 != -1 -> 
				for(i : 0.. concurrentWorkers-1) {
for30:			
			if
			:: done.async_send!0;
			:: done.sync!0 -> 
				done.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: done.async_send!0;
			:: done.sync!0 -> 
				done.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef ch;Chandef done;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for11:		do
		:: ch.async_rcv?0 -> 
			wg.Add!-1;
			break
		:: ch.sync?0 -> 
			wg.Add!-1;
			break
		:: done.async_rcv?0 -> 
			goto stop_process
		:: done.sync?0 -> 
			goto stop_process
		od
	od;
for11_exit:stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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

