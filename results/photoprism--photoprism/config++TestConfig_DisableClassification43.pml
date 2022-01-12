// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/disable_test.go#L43
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_DisableClassification430 = [1] of {int};
	run TestConfig_DisableClassification43(child_TestConfig_DisableClassification430);
	run receiver(child_TestConfig_DisableClassification430)
stop_process:skip
}

proctype TestConfig_DisableClassification43(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DisableClassification603 = [1] of {int};
	chan child_DisableClassification602 = [1] of {int};
	chan child_DisableClassification601 = [1] of {int};
	chan child_DisableClassification600 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run DisableClassification60(c_db_values_mu,c_once_m,child_DisableClassification600);
	child_DisableClassification600?0;
	run DisableClassification60(c_db_values_mu,c_once_m,child_DisableClassification601);
	child_DisableClassification601?0;
	run DisableClassification60(c_db_values_mu,c_once_m,child_DisableClassification602);
	child_DisableClassification602?0;
	run DisableClassification60(c_db_values_mu,c_once_m,child_DisableClassification603);
	child_DisableClassification603?0;
	stop_process: skip;
	child!0
}
proctype DisableClassification60(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DisableTensorFlow410 = [1] of {int};
	run DisableTensorFlow41(c_db_values_mu,c_once_m,child_DisableTensorFlow410);
	child_DisableTensorFlow410?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DisableTensorFlow41(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
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

