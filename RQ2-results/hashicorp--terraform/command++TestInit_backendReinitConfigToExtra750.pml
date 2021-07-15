
// https://github.com/hashicorp/terraform/blob/master/command/init_test.go#L750
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInit_backendReinitConfigToExtra7500 = [1] of {int};
	run TestInit_backendReinitConfigToExtra750(child_TestInit_backendReinitConfigToExtra7500)
stop_process:skip
}

proctype TestInit_backendReinitConfigToExtra750(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef state_mu;
	Mutexdef state_Remote_mu;
	Mutexdef ui_once_m;
	run mutexMonitor(ui_once_m);
	run mutexMonitor(state_Remote_mu);
	run mutexMonitor(state_mu);
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

