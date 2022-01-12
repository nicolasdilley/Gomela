// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gravitational/teleport/blob//lib/auth/webauthncli/register_test.go#L31
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRegister310 = [1] of {int};
	run TestRegister31(child_TestRegister310);
	run receiver(child_TestRegister310)
stop_process:skip
}

proctype TestRegister31(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef registeredKey_dev_mtx;
	Mutexdef u2fKey_dev_mtx;
	int var_test_devs = -2; // opt var_test_devs
	int var_tests = -2; // opt var_tests
	run mutexMonitor(u2fKey_dev_mtx);
	run mutexMonitor(registeredKey_dev_mtx);
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

