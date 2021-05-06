
// https://github.com/hashicorp/vault/blob/master/vault/ui_test.go#L14
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_Enabled140 = [1] of {int};
	run TestConfig_Enabled14(child_TestConfig_Enabled140)
stop_process:skip
}

proctype TestConfig_Enabled14(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Enabled473 = [1] of {int};
	chan child_NewUIConfig332 = [1] of {int};
	chan child_Enabled471 = [1] of {int};
	chan child_NewUIConfig330 = [1] of {int};
	Mutexdef config_l;
	Mutexdef logl_once_m;
	run mutexMonitor(logl_once_m);
	run mutexMonitor(config_l);
	run NewUIConfig33(logl_once_m,child_NewUIConfig330);
	child_NewUIConfig330?0;
	run Enabled47(config_l,child_Enabled471);
	child_Enabled471?0;
	run NewUIConfig33(logl_once_m,child_NewUIConfig332);
	child_NewUIConfig332?0;
	run Enabled47(config_l,child_Enabled473);
	child_Enabled473?0;
	stop_process: skip;
	child!0
}
proctype NewUIConfig33(Mutexdef barrierStorage_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Enabled47(Mutexdef c_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_l.RLock!false;
	goto stop_process;
	stop_process: skip;
		c_l.RUnlock!false;
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

