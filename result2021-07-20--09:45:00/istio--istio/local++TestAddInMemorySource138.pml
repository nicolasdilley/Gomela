// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/galley/pkg/config/analysis/local/analyze_test.go#L138
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAddInMemorySource1380 = [1] of {int};
	run TestAddInMemorySource138(child_TestAddInMemorySource1380);
	run receiver(child_TestAddInMemorySource1380)
stop_process:skip
}

proctype TestAddInMemorySource138(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AddInMemorySource2980 = [1] of {int};
	Mutexdef src_mu;
	run mutexMonitor(src_mu);
	run AddInMemorySource298(src_mu,child_AddInMemorySource2980);
	child_AddInMemorySource2980?0;
	stop_process: skip;
	child!0
}
proctype AddInMemorySource298(Mutexdef src_mu;chan child) {
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

