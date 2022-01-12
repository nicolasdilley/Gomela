// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/client/config_test.go#L157
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfigContexts1570 = [1] of {int};
	run TestConfigContexts157(child_TestConfigContexts1570);
	run receiver(child_TestConfigContexts1570)
stop_process:skip
}

proctype TestConfigContexts157(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Contexts1050 = [1] of {int};
	Mutexdef cfg_mutex;
	Mutexdef cfg_flags_lock;
	Mutexdef flags_lock;
	run mutexMonitor(flags_lock);
	run mutexMonitor(cfg_flags_lock);
	run mutexMonitor(cfg_mutex);
	run Contexts105(cfg_flags_lock,cfg_mutex,child_Contexts1050);
	child_Contexts1050?0;
	stop_process: skip;
	child!0
}
proctype Contexts105(Mutexdef c_flags_lock;Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RawConfig2860 = [1] of {int};
	run RawConfig286(c_flags_lock,c_mutex,child_RawConfig2860);
	child_RawConfig2860?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype RawConfig286(Mutexdef c_flags_lock;Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ensureConfig3210 = [1] of {int};
	c_mutex.Lock!false;
	

	if
	:: true -> 
		run ensureConfig321(c_flags_lock,c_mutex,child_ensureConfig3210);
		child_ensureConfig3210?0;
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	c_mutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype ensureConfig321(Mutexdef c_flags_lock;Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
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

proctype receiver(chan c) {
c?0
}

