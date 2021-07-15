
// https://github.com/hashicorp/consul/blob/master/command/services/deregister/deregister_test.go#L22
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCommand_Validation220 = [1] of {int};
	run TestCommand_Validation22(child_TestCommand_Validation220)
stop_process:skip
}

proctype TestCommand_Validation22(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_New130 = [1] of {int};
	Mutexdef ui_once_m;
	run mutexMonitor(ui_once_m);
	run New13(ui_once_m,child_New130);
	child_New130?0;
	stop_process: skip;
	child!0
}
proctype New13(Mutexdef ui_once_m;chan child) {
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

