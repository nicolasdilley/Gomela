// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob//xds/internal/resolver/serviceconfig_test.go#L28
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPruneActiveClusters280 = [1] of {int};
	run TestPruneActiveClusters28(child_TestPruneActiveClusters280);
	run receiver(child_TestPruneActiveClusters280)
stop_process:skip
}

proctype TestPruneActiveClusters28(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_pruneActiveClusters680 = [1] of {int};
	Mutexdef r_closed_o_m;
	run mutexMonitor(r_closed_o_m);
	run pruneActiveClusters68(r_closed_o_m,child_pruneActiveClusters680);
	child_pruneActiveClusters680?0;
	stop_process: skip;
	child!0
}
proctype pruneActiveClusters68(Mutexdef r_closed_o_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_r_activeClusters = -2; // opt var_r_activeClusters
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

