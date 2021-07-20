// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/go-gorm/gorm/blob/70e93e73d8c739a81e27b0cb73aa5513cafb63e0/clause/clause_test.go#L17
#define var_clauses  -2 // opt clauses line 17
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_checkBuildClauses170 = [1] of {int};
	run checkBuildClauses17(var_clauses,child_checkBuildClauses170);
	run receiver(child_checkBuildClauses170)
stop_process:skip
}

proctype checkBuildClauses17(int clauses;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef stmt_Settings_mu;
	Mutexdef user_cacheStore_mu;
	run mutexMonitor(user_cacheStore_mu);
	run mutexMonitor(stmt_Settings_mu);
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

