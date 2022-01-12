// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/cclifecycle/lifecycle_test.go#L193
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHandleChaincodeDeployFailures1930 = [1] of {int};
	run TestHandleChaincodeDeployFailures193(child_TestHandleChaincodeDeployFailures1930);
	run receiver(child_TestHandleChaincodeDeployFailures1930)
stop_process:skip
}

proctype TestHandleChaincodeDeployFailures193(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_assertLogged4802 = [1] of {int};
	chan child_assertLogged4801 = [1] of {int};
	chan child_assertLogged4800 = [1] of {int};
	Mutexdef recorder_buffer_lock;
	Mutexdef recorder_mutex;
	run mutexMonitor(recorder_mutex);
	run mutexMonitor(recorder_buffer_lock);
	run assertLogged480(recorder_buffer_lock,recorder_mutex,child_assertLogged4800);
	child_assertLogged4800?0;
	run assertLogged480(recorder_buffer_lock,recorder_mutex,child_assertLogged4801);
	child_assertLogged4801?0;
	run assertLogged480(recorder_buffer_lock,recorder_mutex,child_assertLogged4802);
	child_assertLogged4802?0;
	stop_process: skip;
	child!0
}
proctype assertLogged480(Mutexdef r_buffer_lock;Mutexdef r_mutex;chan child) {
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

