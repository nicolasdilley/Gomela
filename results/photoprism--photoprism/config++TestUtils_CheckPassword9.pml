// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/auth_test.go#L9
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUtils_CheckPassword90 = [1] of {int};
	run TestUtils_CheckPassword9(child_TestUtils_CheckPassword90);
	run receiver(child_TestUtils_CheckPassword90)
stop_process:skip
}

proctype TestUtils_CheckPassword9(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CheckPassword193 = [1] of {int};
	chan child_CheckPassword192 = [1] of {int};
	chan child_CheckPassword191 = [1] of {int};
	chan child_CheckPassword190 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run CheckPassword19(c_db_values_mu,c_once_m,child_CheckPassword190);
	child_CheckPassword190?0;
	run CheckPassword19(c_db_values_mu,c_once_m,child_CheckPassword191);
	child_CheckPassword191?0;
	run CheckPassword19(c_db_values_mu,c_once_m,child_CheckPassword192);
	child_CheckPassword192?0;
	run CheckPassword19(c_db_values_mu,c_once_m,child_CheckPassword193);
	child_CheckPassword193?0;
	stop_process: skip;
	child!0
}
proctype CheckPassword19(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AdminPassword4010 = [1] of {int};
	run AdminPassword401(c_db_values_mu,c_once_m,child_AdminPassword4010);
	child_AdminPassword4010?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AdminPassword401(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

