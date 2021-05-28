// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/helm/helm/blob/43853ea772e779b617b011a8d4e69205636fa4f9/pkg/getter/getter_test.go#L55
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAll550 = [1] of {int};
	run TestAll55(child_TestAll550);
	run receiver(child_TestAll550)
stop_process:skip
}

proctype TestAll55(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_All1720 = [1] of {int};
	Mutexdef env_config_lock;
	run mutexMonitor(env_config_lock);
	run All172(env_config_lock,child_All1720);
	child_All1720?0;
	stop_process: skip;
	child!0
}
proctype All172(Mutexdef settings_config_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_collectPlugins330 = [1] of {int};
	run collectPlugins33(settings_config_lock,child_collectPlugins330);
	child_collectPlugins330?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype collectPlugins33(Mutexdef settings_config_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int plugin_Metadata_Downloaders = -2; // opt plugin_Metadata_Downloaders
	int plugins = -2; // opt plugins
	

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

