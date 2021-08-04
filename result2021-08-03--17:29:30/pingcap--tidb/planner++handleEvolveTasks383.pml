// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/planner/optimize.go#L383
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_handleEvolveTasks3830 = [1] of {int};
	run handleEvolveTasks383(child_handleEvolveTasks3830);
	run receiver(child_handleEvolveTasks3830)
stop_process:skip
}

proctype handleEvolveTasks383(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AddEvolvePlanTask7430 = [1] of {int};
	Mutexdef globalHandle_bindInfo;
	Mutexdef globalHandle_sctx;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(globalHandle_sctx);
	run mutexMonitor(globalHandle_bindInfo);
	run AddEvolvePlanTask743(globalHandle_bindInfo,globalHandle_sctx,child_AddEvolvePlanTask7430);
	child_AddEvolvePlanTask7430?0;
	stop_process: skip;
	child!0
}
proctype AddEvolvePlanTask743(Mutexdef h_bindInfo;Mutexdef h_sctx;chan child) {
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

proctype receiver(chan c) {
c?0
}

