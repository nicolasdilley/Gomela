
// https://github.com/hashicorp/consul/blob/master/command/intention/check/check_test.go#L21
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestIntentionCheck_Validation210 = [1] of {int};
	run TestIntentionCheck_Validation21(child_TestIntentionCheck_Validation210)
stop_process:skip
}

proctype TestIntentionCheck_Validation21(chan child) {
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

