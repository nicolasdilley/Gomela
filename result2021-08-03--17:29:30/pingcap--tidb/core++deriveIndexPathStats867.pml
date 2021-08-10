// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/planner/core/logical_plans.go#L867
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_deriveIndexPathStats8670 = [1] of {int};
	run deriveIndexPathStats867(child_deriveIndexPathStats8670);
	run receiver(child_deriveIndexPathStats8670)
stop_process:skip
}

proctype deriveIndexPathStats867(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsPoint550 = [1] of {int};
	chan child_IsPoint551 = [1] of {int};
	Mutexdef sc_RuntimeStatsColl_mu;
	Mutexdef sc_mu;
	int var_path_Index_Columns = -2; // opt var_path_Index_Columns
	int var_path_Ranges = -2; // opt var_path_Ranges
	int var_accesses = -2; // opt var_accesses
	run mutexMonitor(sc_mu);
	run mutexMonitor(sc_RuntimeStatsColl_mu);
	

	if
	:: var_path_Ranges-1 != -3 -> 
				for(i : 0.. var_path_Ranges-1) {
			for20: skip;
			run IsPoint55(sc_mu,sc_RuntimeStatsColl_mu,child_IsPoint550);
			child_IsPoint550?0;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for25: skip;
			run IsPoint55(sc_mu,sc_RuntimeStatsColl_mu,child_IsPoint551);
			child_IsPoint551?0;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for25_end: skip
		:: true -> 
			break
		od;
		for25_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype IsPoint55(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_ran_LowVal = -2; // opt var_ran_LowVal
	

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

