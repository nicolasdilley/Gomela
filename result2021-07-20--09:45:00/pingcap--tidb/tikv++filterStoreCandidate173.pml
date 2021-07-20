// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/store/tikv/region_cache.go#L173
#define not_found_176  -2 // opt labels line 1874
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_filterStoreCandidate1730 = [1] of {int};
	run filterStoreCandidate173(child_filterStoreCandidate1730);
	run receiver(child_filterStoreCandidate1730)
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
	int var_s_labelss_labels = -2; // opt var_s_labelss_labels
	

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

proctype receiver(chan c) {
c?0
}

