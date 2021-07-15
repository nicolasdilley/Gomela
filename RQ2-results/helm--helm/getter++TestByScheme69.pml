
// https://github.com/helm/helm/blob/master/pkg/getter/getter_test.go#L69
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestByScheme690 = [1] of {int};
	run TestByScheme69(child_TestByScheme690)
stop_process:skip
}

proctype TestByScheme69(chan child) {
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

