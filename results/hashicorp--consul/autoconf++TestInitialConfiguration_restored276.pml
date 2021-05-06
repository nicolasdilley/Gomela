
// https://github.com/hashicorp/consul/blob/master/agent/auto-config/auto_config_test.go#L276
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInitialConfiguration_restored2760 = [1] of {int};
	run TestInitialConfiguration_restored276(child_TestInitialConfiguration_restored2760)
stop_process:skip
}

proctype TestInitialConfiguration_restored276(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_setupInitialTLS3290 = [1] of {int};
	Mutexdef mcfg_cache_lock;
	run mutexMonitor(mcfg_cache_lock);
	run setupInitialTLS329(mcfg_cache_lock,child_setupInitialTLS3290);
	child_setupInitialTLS3290?0;
	stop_process: skip;
	child!0
}
proctype setupInitialTLS329(Mutexdef m_cache_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_expectInitialTLS2660 = [1] of {int};
	run expectInitialTLS266(m_cache_lock,child_expectInitialTLS2660);
	child_expectInitialTLS2660?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype expectInitialTLS266(Mutexdef m_cache_lock;chan child) {
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

