#define RunBench_benchN  ??
#define RunBench_benchC  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example881113462/bench.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
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
	chan child_mainprintReport0 = [0] of {int};
	int benchC = RunBench_benchC;
	bool state = false;
	
	if
	:: benchN > 0 -> 
		results.size = benchN;
		run AsyncChan(results)
	:: else -> 
		run sync_monitor(results)
	fi;
	run wgMonitor(wg);
	wg.Add!benchN;
	
	if
	:: benchN > 0 -> 
		jobs.size = benchN;
		run AsyncChan(jobs)
	:: else -> 
		run sync_monitor(jobs)
	fi;
for10_exit:	
	if
	:: 0 != -2 && benchN-1 != -3 -> 
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
	run mainprintReport(results,child_mainprintReport0);
	child_mainprintReport0?0;
	results.closing!true
stop_process:}

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
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
		  :: ch.sending!false;  // sending channel is open
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}

