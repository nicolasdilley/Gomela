
// https://github.com/minio/minio/blob/master/pkg/bucket/bandwidth/monitor_test.go#L78
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMonitor_GetReport780 = [1] of {int};
	run TestMonitor_GetReport78(child_TestMonitor_GetReport780)
stop_process:skip
}

proctype TestMonitor_GetReport78(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_incrementBytes461 = [1] of {int};
	Mutexdef m1MiBPS_lock;
	chan child_incrementBytes460 = [1] of {int};
	Mutexdef m0_lock;
	run mutexMonitor(m0_lock);
	run incrementBytes46(m0_lock,child_incrementBytes460);
	child_incrementBytes460?0;
	run mutexMonitor(m1MiBPS_lock);
	run incrementBytes46(m1MiBPS_lock,child_incrementBytes461);
	child_incrementBytes461?0;
	stop_process: skip;
	child!0
}
proctype incrementBytes46(Mutexdef m_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

