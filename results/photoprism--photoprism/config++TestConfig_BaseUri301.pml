// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/config_test.go#L301
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_BaseUri3010 = [1] of {int};
	run TestConfig_BaseUri301(child_TestConfig_BaseUri3010);
	run receiver(child_TestConfig_BaseUri3010)
stop_process:skip
}

proctype TestConfig_BaseUri301(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_BaseUri2643 = [1] of {int};
	chan child_BaseUri2642 = [1] of {int};
	chan child_BaseUri2641 = [1] of {int};
	chan child_BaseUri2640 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run BaseUri264(c_db_values_mu,c_once_m,child_BaseUri2640);
	child_BaseUri2640?0;
	run BaseUri264(c_db_values_mu,c_once_m,child_BaseUri2641);
	child_BaseUri2641?0;
	run BaseUri264(c_db_values_mu,c_once_m,child_BaseUri2642);
	child_BaseUri2642?0;
	run BaseUri264(c_db_values_mu,c_once_m,child_BaseUri2643);
	child_BaseUri2643?0;
	stop_process: skip;
	child!0
}
proctype BaseUri264(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SiteUrl2991 = [1] of {int};
	chan child_SiteUrl2990 = [1] of {int};
	run SiteUrl299(c_db_values_mu,c_once_m,child_SiteUrl2990);
	child_SiteUrl2990?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run SiteUrl299(c_db_values_mu,c_once_m,child_SiteUrl2991);
	child_SiteUrl2991?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SiteUrl299(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

