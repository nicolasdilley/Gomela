
// https://github.com/hashicorp/terraform/blob/master/command/workspace_command_test.go#L114
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestWorkspace_createAndShow1140 = [1] of {int};
	run TestWorkspace_createAndShow114(child_TestWorkspace_createAndShow1140)
stop_process:skip
}

proctype TestWorkspace_createAndShow114(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ui_once_m;
	run mutexMonitor(ui_once_m);
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
