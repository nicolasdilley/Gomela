// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/planner/core/logical_plan_builder.go#L1702
#define not_found_291  -2 // opt not_found_291
#define not_found_372  -2 // opt not_found_372
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_getUintFromNode17020 = [1] of {int};
	run getUintFromNode1702(child_getUintFromNode17020);
	run receiver(child_getUintFromNode17020)
stop_process:skip
}

proctype getUintFromNode1702(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StrToUint2890 = [1] of {int};
	Mutexdef sc_RuntimeStatsColl_mu;
	Mutexdef sc_mu;
	

	if
	:: true;
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
		fi;
		

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
	:: true -> 
		goto stop_process
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		run mutexMonitor(sc_mu);
		run mutexMonitor(sc_RuntimeStatsColl_mu);
		run StrToUint289(sc_mu,sc_RuntimeStatsColl_mu,child_StrToUint2890);
		child_StrToUint2890?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype StrToUint289(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getValidIntPrefix3660 = [1] of {int};
	run getValidIntPrefix366(sc_mu,sc_RuntimeStatsColl_mu,not_found_291,child_getValidIntPrefix3660);
	child_getValidIntPrefix3660?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getValidIntPrefix366(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;int str;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_floatStrToIntStr4351 = [1] of {int};
	chan child_getValidFloatPrefix6650 = [1] of {int};
	

	if
	:: true -> 
		run getValidFloatPrefix665(sc_mu,sc_RuntimeStatsColl_mu,str,child_getValidFloatPrefix6650);
		child_getValidFloatPrefix6650?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run floatStrToIntStr435(sc_mu,sc_RuntimeStatsColl_mu,not_found_372,child_floatStrToIntStr4351);
		child_floatStrToIntStr4351?0;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getValidFloatPrefix665(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;int s;chan child) {
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
proctype floatStrToIntStr435(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;int validFloat;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

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

