#define Fixed_n 3
#define Fixed_xs 1
#define Fixed_concurrent 0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example113587139/integrate/quad/quad.go
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
	Chandef tasks;
	int concurrent = Fixed_concurrent;
	int n = Fixed_n;
	bool state = false;
	Wgdef wg;
	int xs = Fixed_xs;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		

		if
		:: true;
		:: true;
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: 0 != -1 && n-1 != -1 -> 
								for(i : 0.. n-1) {
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
for10_exit:			goto stop_process
		:: true;
		fi;
				for(i : 0.. xs-1) {
for20:
		};
		goto stop_process
	:: true;
	fi;
	run sync_monitor(tasks);
	run Anonymous0(tasks,wg);
	run wgMonitor(wg);
	wg.Add!concurrent;
		for(i : 0.. concurrent-1) {
for40:		run Anonymous1(tasks,wg)
	};
for40_exit:	wg.Wait?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef tasks;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -1 && n-1 != -1 -> 
				for(i : 0.. n-1) {
for30:			
			if
			:: tasks.async_send!0;
			:: tasks.sync!0 -> 
				tasks.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: tasks.async_send!0;
			:: tasks.sync!0 -> 
				tasks.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	tasks.closing!true;
stop_process:
}
proctype Anonymous1(Chandef tasks;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: tasks.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: tasks.async_rcv?0;
			:: tasks.sync?0;
			fi
		fi
	od;
stop_process:	wg.Add!-1
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
	od
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


