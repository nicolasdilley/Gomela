// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-kit/kit/blob/60e8424101af501c525efaf67c0a2edf08667f80/metrics/timer_test.go#L13
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTimerFast130 = [1] of {int};
	run TestTimerFast13(child_TestTimerFast130);
	run receiver(child_TestTimerFast130)
stop_process:skip
}

proctype TestTimerFast13(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ApproximateMovingAverage2380 = [1] of {int};
	Mutexdef h_mtx;
	run mutexMonitor(h_mtx);
	run ApproximateMovingAverage238(h_mtx,child_ApproximateMovingAverage2380);
	child_ApproximateMovingAverage2380?0;
	stop_process: skip;
	child!0
}
proctype ApproximateMovingAverage238(Mutexdef h_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	h_mtx.RLock!false;
	goto defer1;
		defer1: skip;
	h_mtx.RUnlock!false;
	stop_process: skip;
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

proctype receiver(chan c) {
c?0
}

