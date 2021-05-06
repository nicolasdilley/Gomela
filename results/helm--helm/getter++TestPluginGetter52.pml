
// https://github.com/helm/helm/blob/master/pkg/getter/plugingetter_test.go#L52
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPluginGetter520 = [1] of {int};
	run TestPluginGetter52(child_TestPluginGetter520)
stop_process:skip
}

proctype TestPluginGetter52(chan child) {
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

