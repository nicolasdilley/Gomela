// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/config_test.go#L203
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_ExamplesPath2030 = [1] of {int};
	run TestConfig_ExamplesPath203(child_TestConfig_ExamplesPath2030);
	run receiver(child_TestConfig_ExamplesPath2030)
stop_process:skip
}

proctype TestConfig_ExamplesPath203(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ExamplesPath3380 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run ExamplesPath338(c_db_values_mu,c_once_m,child_ExamplesPath3380);
	child_ExamplesPath3380?0;
	stop_process: skip;
	child!0
}
proctype ExamplesPath338(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AssetsPath3230 = [1] of {int};
	run AssetsPath323(c_db_values_mu,c_once_m,child_AssetsPath3230);
	child_AssetsPath3230?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AssetsPath323(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
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

