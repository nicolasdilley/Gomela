// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//rest/handler/sheddinghandler_test.go#L40
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
	chan child_TestSheddingHandlerFail400 = [1] of {int};
	run TestSheddingHandlerFail40(child_TestSheddingHandlerFail400);
	run receiver(child_TestSheddingHandlerFail400)
stop_process:skip
}

proctype TestSheddingHandlerFail40(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SheddingHandler220 = [1] of {int};
	Mutexdef metrics_executor_lock;
	Mutexdef metrics_executor_wgBarrier_lock;
	Wgdef metrics_executor_waitGroup;
	run wgMonitor(metrics_executor_waitGroup);
	run mutexMonitor(metrics_executor_wgBarrier_lock);
	run mutexMonitor(metrics_executor_lock);
	run SheddingHandler22(metrics_executor_waitGroup,metrics_executor_lock,metrics_executor_wgBarrier_lock,child_SheddingHandler220);
	child_SheddingHandler220?0;
	stop_process: skip;
	child!0
}
proctype SheddingHandler22(Wgdef metrics_executor_waitGroup;Mutexdef metrics_executor_lock;Mutexdef metrics_executor_wgBarrier_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

