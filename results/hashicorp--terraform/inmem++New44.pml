
// https://github.com/hashicorp/terraform/blob/master/backend/remote-state/inmem/backend.go#L44
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_New440 = [1] of {int};
	run New44(child_New440)
stop_process:skip
}

proctype New44(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef s_config_once_m;
	Mutexdef s_config_newState_mu;
	Mutexdef s_config_setWriter_lock;
	Mutexdef s_config_diff_mu;
	Mutexdef s_config_state_mu;
	run mutexMonitor(s_config_state_mu);
	run mutexMonitor(s_config_diff_mu);
	run mutexMonitor(s_config_setWriter_lock);
	run mutexMonitor(s_config_newState_mu);
	run mutexMonitor(s_config_once_m);
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

