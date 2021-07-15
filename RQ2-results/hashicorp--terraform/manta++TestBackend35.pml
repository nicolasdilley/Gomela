
// https://github.com/hashicorp/terraform/blob/master/backend/remote-state/manta/backend_test.go#L35
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBackend350 = [1] of {int};
	run TestBackend35(child_TestBackend350)
stop_process:skip
}

proctype TestBackend35(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TestBackendStates740 = [1] of {int};
	Mutexdef b_data_once_m;
	Mutexdef b_data_newState_mu;
	Mutexdef b_data_setWriter_lock;
	Mutexdef b_data_diff_mu;
	Mutexdef b_data_state_mu;
	run mutexMonitor(b_data_state_mu);
	run mutexMonitor(b_data_diff_mu);
	run mutexMonitor(b_data_setWriter_lock);
	run mutexMonitor(b_data_newState_mu);
	run mutexMonitor(b_data_once_m);
	run TestBackendStates74(b_data_state_mu,b_data_diff_mu,b_data_setWriter_lock,b_data_newState_mu,b_data_once_m,child_TestBackendStates740);
	child_TestBackendStates740?0;
	stop_process: skip;
	child!0
}
proctype TestBackendStates74(Mutexdef b_data_state_mu;Mutexdef b_data_diff_mu;Mutexdef b_data_setWriter_lock;Mutexdef b_data_newState_mu;Mutexdef b_data_once_m;chan child) {
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
		fi
	:: true;
	fi;
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

