
// https://github.com/prometheus/prometheus/blob/master/tsdb/index/postings_test.go#L28
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMemPostings_addFor280 = [1] of {int};
	run TestMemPostings_addFor28(child_TestMemPostings_addFor280)
stop_process:skip
}

proctype TestMemPostings_addFor28(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_addFor3100 = [1] of {int};
	Mutexdef p_mtx;
	run mutexMonitor(p_mtx);
	run addFor310(p_mtx,child_addFor3100);
	child_addFor3100?0;
	stop_process: skip;
	child!0
}
proctype addFor310(Mutexdef p_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

