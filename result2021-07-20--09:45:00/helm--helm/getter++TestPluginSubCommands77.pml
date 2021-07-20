// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/helm/helm/blob/43853ea772e779b617b011a8d4e69205636fa4f9/pkg/getter/plugingetter_test.go#L77
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPluginSubCommands770 = [1] of {int};
	run TestPluginSubCommands77(child_TestPluginSubCommands770);
	run receiver(child_TestPluginSubCommands770)
stop_process:skip
}

proctype TestPluginSubCommands77(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewPluginGetter890 = [1] of {int};
	Mutexdef env_config_lock;
	run mutexMonitor(env_config_lock);
	run NewPluginGetter89(env_config_lock,child_NewPluginGetter890);
	child_NewPluginGetter890?0;
	stop_process: skip;
	child!0
}
proctype NewPluginGetter89(Mutexdef settings_config_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_optionsoptions = -2; // opt var_optionsoptions
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

