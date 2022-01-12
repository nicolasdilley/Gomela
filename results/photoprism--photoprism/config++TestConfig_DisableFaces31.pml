// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/disable_test.go#L31
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_DisableFaces310 = [1] of {int};
	run TestConfig_DisableFaces31(child_TestConfig_DisableFaces310);
	run receiver(child_TestConfig_DisableFaces310)
stop_process:skip
}

proctype TestConfig_DisableFaces31(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DisableFaces513 = [1] of {int};
	chan child_DisableFaces512 = [1] of {int};
	chan child_DisableFaces511 = [1] of {int};
	chan child_DisableFaces510 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run DisableFaces51(c_db_values_mu,c_once_m,child_DisableFaces510);
	child_DisableFaces510?0;
	run DisableFaces51(c_db_values_mu,c_once_m,child_DisableFaces511);
	child_DisableFaces511?0;
	run DisableFaces51(c_db_values_mu,c_once_m,child_DisableFaces512);
	child_DisableFaces512?0;
	run DisableFaces51(c_db_values_mu,c_once_m,child_DisableFaces513);
	child_DisableFaces513?0;
	stop_process: skip;
	child!0
}
proctype DisableFaces51(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
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

