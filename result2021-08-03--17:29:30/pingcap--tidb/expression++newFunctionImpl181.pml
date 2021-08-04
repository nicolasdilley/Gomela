// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/expression/scalar_function.go#L181
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newFunctionImpl1810 = [1] of {int};
	run newFunctionImpl181(child_newFunctionImpl1810);
	run receiver(child_newFunctionImpl1810)
stop_process:skip
}

proctype newFunctionImpl181(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TruncateWarnings3812 = [1] of {int};
	chan child_WarningCount3951 = [1] of {int};
	chan child_WarningCount3950 = [1] of {int};
	Mutexdef sc_RuntimeStatsColl_mu;
	Mutexdef sc_mu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	

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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
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
	:: true -> 
		

		if
		:: true -> 
			run mutexMonitor(sc_mu);
			run mutexMonitor(sc_RuntimeStatsColl_mu);
			run WarningCount395(sc_mu,sc_RuntimeStatsColl_mu,child_WarningCount3950);
			child_WarningCount3950?0;
			run WarningCount395(sc_mu,sc_RuntimeStatsColl_mu,child_WarningCount3951);
			child_WarningCount3951?0;
			

			if
			:: true -> 
				run TruncateWarnings381(sc_mu,sc_RuntimeStatsColl_mu,child_TruncateWarnings3812);
				child_TruncateWarnings3812?0;
				goto stop_process
			:: true;
			fi;
			goto stop_process
		:: true;
		fi
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype WarningCount395(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
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
proctype TruncateWarnings381(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
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

proctype receiver(chan c) {
c?0
}

