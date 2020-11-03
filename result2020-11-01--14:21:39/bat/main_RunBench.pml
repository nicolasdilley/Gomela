#define RunBench_benchN 0
#define RunBench_benchC 1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example937800107/bench.go
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
	Chandef results;
	int benchN = RunBench_benchN;
	Chandef jobs;
	int i;
	Wgdef wg;
	chan child_mainprintReport1 = [0] of {int};
	int benchC = RunBench_benchC;
	bool state = false;
	
	if
	:: benchN > 0 -> 
		results.size = benchN;
		run emptyChan(results)
	:: else -> 
		run sync_monitor(results)
	fi;
	run wgMonitor(wg);
	wg.Add!benchN;
	
	if
	:: benchN > 0 -> 
		jobs.size = benchN;
		run emptyChan(jobs)
	:: else -> 
		run sync_monitor(jobs)
	fi;
		for(i : 0.. benchC-1) {
for10:		run Anonymous0(results,jobs,wg)
	};
for10_exit:	
	if
	:: 0 != -1 && benchN-1 != -1 -> 
				for(i : 0.. benchN-1) {
for20:			
			if
			:: jobs.async_send!0;
			:: jobs.sync!0 -> 
				jobs.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: jobs.async_send!0;
			:: jobs.sync!0 -> 
				jobs.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	jobs.closing!true;
	wg.Wait?0;
	run mainprintReport(results,child_mainprintReport1);
	child_mainprintReport1?0;
	results.closing!true
stop_process:}

proctype mainworker(Wgdef wg;Chandef ch;Chandef results;chan child) {
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
			fi;
			wg.Add!-1;
			
			if
			:: results.async_send!0;
			:: results.sync!0 -> 
				results.sending?0
			fi
		fi
	od;
stop_process:	child!0
}
proctype Anonymous0(Chandef results;Chandef jobs;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	chan child_mainworker0 = [0] of {int};
	run mainworker(wg,jobs,results,child_mainworker0);
	child_mainworker0?0;
stop_process:
}
proctype mainprintReport(Chandef results;chan child) {
	bool closed; 
	int i;
	bool state;
stop_process:	child!0
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


