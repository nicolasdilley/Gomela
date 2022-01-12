// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/client/config_test.go#L144
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfigAccess1440 = [1] of {int};
	run TestConfigAccess144(child_TestConfigAccess1440);
	run receiver(child_TestConfigAccess1440)
stop_process:skip
}

proctype TestConfigAccess144(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ConfigAccess2770 = [1] of {int};
	Mutexdef cfg_mutex;
	Mutexdef cfg_flags_lock;
	Mutexdef flags_lock;
	run mutexMonitor(flags_lock);
	run mutexMonitor(cfg_flags_lock);
	run mutexMonitor(cfg_mutex);
	run ConfigAccess277(cfg_flags_lock,cfg_mutex,child_ConfigAccess2770);
	child_ConfigAccess2770?0;
	stop_process: skip;
	child!0
}
proctype ConfigAccess277(Mutexdef c_flags_lock;Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ensureConfig3210 = [1] of {int};
	c_mutex.RLock!false;
	run ensureConfig321(c_flags_lock,c_mutex,child_ensureConfig3210);
	child_ensureConfig3210?0;
	goto defer1;
		defer1: skip;
	c_mutex.RUnlock!false;
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

