// num_comm_params=3
// num_mand_comm_params=0
// num_opt_comm_params=3

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/planner/core/logical_plans.go#L657
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_deriveCommonHandleTablePathStats6570 = [1] of {int};
	run deriveCommonHandleTablePathStats657(child_deriveCommonHandleTablePathStats6570);
	run receiver(child_deriveCommonHandleTablePathStats6570)
stop_process:skip
}

proctype deriveCommonHandleTablePathStats657(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef sc_RuntimeStatsColl_mu;
	Mutexdef sc_mu;
	int path_Index_Columns = -2; // opt path_Index_Columns
	int path_Ranges = -2; // opt path_Ranges
	int accesses = -2; // opt accesses
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(sc_mu);
	run mutexMonitor(sc_RuntimeStatsColl_mu);
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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

