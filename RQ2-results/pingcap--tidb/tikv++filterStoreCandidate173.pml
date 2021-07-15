#define not_found_176  -2

// https://github.com/pingcap/tidb/blob/master/store/tikv/region_cache.go#L173
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_filterStoreCandidate1730 = [1] of {int};
	run filterStoreCandidate173(child_filterStoreCandidate1730)
stop_process:skip
}

proctype filterStoreCandidate173(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsLabelsMatch18740 = [1] of {int};
	Mutexdef s_resolveMutex;
	run mutexMonitor(s_resolveMutex);
	run IsLabelsMatch1874(s_resolveMutex,not_found_176,child_IsLabelsMatch18740);
	child_IsLabelsMatch18740?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype IsLabelsMatch1874(Mutexdef s_resolveMutex;int labels;chan child) {
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

