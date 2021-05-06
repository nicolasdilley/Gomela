
// https://github.com/prometheus/prometheus/blob/master/notifier/notifier_test.go#L72
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHandlerNextBatch720 = [1] of {int};
	run TestHandlerNextBatch72(child_TestHandlerNextBatch720)
stop_process:skip
}

proctype TestHandlerNextBatch72(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_nextBatch2872 = [1] of {int};
	chan child_nextBatch2871 = [1] of {int};
	chan child_nextBatch2870 = [1] of {int};
	Mutexdef h_mtx;
	run mutexMonitor(h_mtx);
	run nextBatch287(h_mtx,child_nextBatch2870);
	child_nextBatch2870?0;
	run nextBatch287(h_mtx,child_nextBatch2871);
	child_nextBatch2871?0;
	run nextBatch287(h_mtx,child_nextBatch2872);
	child_nextBatch2872?0;
	stop_process: skip;
	child!0
}
proctype nextBatch287(Mutexdef n_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	n_mtx.Lock!false;
	goto stop_process;
	stop_process: skip;
		n_mtx.Unlock!false;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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

