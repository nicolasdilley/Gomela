#define jacobianConcurrent_m 1
#define jacobianConcurrent_n 3
#define jacobianConcurrent_nWorkers 1
#define jacobianConcurrent_formula_Stencil 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example113587139/diff/fd/jacobian.go
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
	int n = jacobianConcurrent_n;
	Chandef jobs;
	int formula_Stencil = jacobianConcurrent_formula_Stencil;
	Wgdef wg;
	int m = jacobianConcurrent_m;
	int nWorkers = jacobianConcurrent_nWorkers;
	int i;
	
	if
	:: 0 != -1 && m-1 != -1 -> 
				for(i : 0.. m-1) {
for10:			
			if
			:: 0 != -1 && n-1 != -1 -> 
								for(i : 0.. n-1) {
for11:
				}
			:: else -> 
				do
				:: true -> 
for11:
				:: true -> 
					break
				od
			fi;
for11_exit:
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: 0 != -1 && n-1 != -1 -> 
								for(i : 0.. n-1) {
for11:
				}
			:: else -> 
				do
				:: true -> 
for11:
				:: true -> 
					break
				od
			fi;
for11_exit:
		:: true -> 
			break
		od
	fi;
for10_exit:	run wgMonitor(wg);
	
	if
	:: nWorkers > 0 -> 
		jobs.size = nWorkers;
		run emptyChan(jobs)
	:: else -> 
		run sync_monitor(jobs)
	fi;
		for(i : 0.. nWorkers-1) {
for20:		wg.Add!1
	};
for20_exit:		for(i : 0.. formula_Stencil-1) {
for30:		
		if
		:: 0 != -1 && n-1 != -1 -> 
						for(i : 0.. n-1) {
for31:				
				if
				:: jobs.async_send!0;
				:: jobs.sync!0 -> 
					jobs.sending?0
				fi
			}
		:: else -> 
			do
			:: true -> 
for31:				
				if
				:: jobs.async_send!0;
				:: jobs.sync!0 -> 
					jobs.sending?0
				fi
			:: true -> 
				break
			od
		fi;
for31_exit:
	};
	jobs.closing!true;
	
	if
	:: true -> 
		wg.Add!1;
		run Anonymous0(jobs,wg)
	:: true;
	fi;
	wg.Wait?0;
	
	if
	:: true -> 
				for(i : 0.. formula_Stencil-1) {
for40:			
			if
			:: 0 != -1 && n-1 != -1 -> 
								for(i : 0.. n-1) {
for41:
				}
			:: else -> 
				do
				:: true -> 
for41:
				:: true -> 
					break
				od
			fi;
for41_exit:
		}
	:: true;
	fi
stop_process:}

proctype Anonymous0(Chandef jobs;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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


