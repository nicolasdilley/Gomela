// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-gorm/gorm/blob//schema/check_test.go#L17
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestParseCheck170 = [1] of {int};
	run TestParseCheck17(child_TestParseCheck170);
	run receiver(child_TestParseCheck170)
stop_process:skip
}

proctype TestParseCheck17(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ParseCheckConstraints200 = [1] of {int};
	Mutexdef user_cacheStore_mu;
	int var_results = -2; // opt var_results
	run mutexMonitor(user_cacheStore_mu);
	run ParseCheckConstraints20(user_cacheStore_mu,child_ParseCheckConstraints200);
	child_ParseCheckConstraints200?0;
	stop_process: skip;
	child!0
}
proctype ParseCheckConstraints20(Mutexdef schema_cacheStore_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_schema_FieldsByDBName = -2; // opt var_schema_FieldsByDBName
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

