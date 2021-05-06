
// https://github.com/spf13/viper/blob/master/viper_test.go#L584
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSetEnvKeyReplacer5840 = [1] of {int};
	run TestSetEnvKeyReplacer584(child_TestSetEnvKeyReplacer5840)
stop_process:skip
}

proctype TestSetEnvKeyReplacer584(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetEnvKeyReplacer13080 = [1] of {int};
	Mutexdef replacer_once_m;
	run mutexMonitor(replacer_once_m);
	run SetEnvKeyReplacer1308(replacer_once_m,child_SetEnvKeyReplacer13080);
	child_SetEnvKeyReplacer13080?0;
	stop_process: skip;
	child!0
}
proctype SetEnvKeyReplacer1308(Mutexdef r_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetEnvKeyReplacer13100 = [1] of {int};
	run SetEnvKeyReplacer1310(r_once_m,child_SetEnvKeyReplacer13100);
	child_SetEnvKeyReplacer13100?0;
	stop_process: skip;
	child!0
}
proctype SetEnvKeyReplacer1310(Mutexdef r_once_m;chan child) {
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

