
// https://github.com/restic/restic/blob/master/internal/backend/utils_test.go#L57
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLoadAllAppend570 = [1] of {int};
	run TestLoadAllAppend57(child_TestLoadAllAppend570)
stop_process:skip
}

proctype TestLoadAllAppend57(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_save471 = [1] of {int};
	chan child_save470 = [1] of {int};
	Mutexdef b_m;
	run mutexMonitor(b_m);
	run save47(b_m,child_save470);
	child_save470?0;
	run save47(b_m,child_save471);
	child_save471?0;
	stop_process: skip;
	child!0
}
proctype save47(Mutexdef be_m;chan child) {
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

