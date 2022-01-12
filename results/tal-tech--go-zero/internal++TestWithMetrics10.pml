// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//zrpc/internal/rpcserver_test.go#L10
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestWithMetrics100 = [1] of {int};
	run TestWithMetrics10(child_TestWithMetrics100);
	run receiver(child_TestWithMetrics100)
stop_process:skip
}

proctype TestWithMetrics10(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef options_metrics_executor_lock;
	Mutexdef options_metrics_executor_wgBarrier_lock;
	Wgdef options_metrics_executor_waitGroup;
	chan child_WithMetrics850 = [1] of {int};
	Mutexdef metrics_executor_lock;
	Mutexdef metrics_executor_wgBarrier_lock;
	Wgdef metrics_executor_waitGroup;
	run wgMonitor(metrics_executor_waitGroup);
	run mutexMonitor(metrics_executor_wgBarrier_lock);
	run mutexMonitor(metrics_executor_lock);
	run WithMetrics85(metrics_executor_waitGroup,metrics_executor_lock,metrics_executor_wgBarrier_lock,child_WithMetrics850);
	child_WithMetrics850?0;
	run wgMonitor(options_metrics_executor_waitGroup);
	run mutexMonitor(options_metrics_executor_wgBarrier_lock);
	run mutexMonitor(options_metrics_executor_lock);
	stop_process: skip;
	child!0
}
proctype WithMetrics85(Wgdef metrics_executor_waitGroup;Mutexdef metrics_executor_lock;Mutexdef metrics_executor_wgBarrier_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

proctype mutexMonitor(Mutexdef m) {
bool locked = false;
do
:: true ->
	if
	:: m.Counter > 0 ->
		if 
		:: m.RUnlock?false -> 
			m.Counter = m.Counter - 1;
		:: m.RLock?false -> 
			m.Counter = m.Counter + 1;
		fi;
	:: locked ->
		m.Unlock?false;
		locked = false;
	:: else ->	 end:	if
		:: m.Unlock?false ->
			assert(0==32);		:: m.Lock?false ->
			locked =true;
		:: m.RUnlock?false ->
			assert(0==32);		:: m.RLock?false ->
			m.Counter = m.Counter + 1;
		fi;
	fi;
od
}

proctype receiver(chan c) {
c?0
}

