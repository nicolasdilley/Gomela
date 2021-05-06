
// https://github.com/k6io/k6/blob/master/api/v1/group_test.go#L31
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNewCheck310 = [1] of {int};
	run TestNewCheck31(child_TestNewCheck310)
stop_process:skip
}

proctype TestNewCheck31(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewCheck391 = [1] of {int};
	chan child_NewCheck2110 = [1] of {int};
	Mutexdef oc_Group_checkMutex;
	Mutexdef oc_Group_groupMutex;
	Mutexdef og_checkMutex;
	Mutexdef og_groupMutex;
	run mutexMonitor(og_groupMutex);
	run mutexMonitor(og_checkMutex);
	run mutexMonitor(oc_Group_groupMutex);
	run mutexMonitor(oc_Group_checkMutex);
	run NewCheck211(og_groupMutex,og_checkMutex,child_NewCheck2110);
	child_NewCheck2110?0;
	run NewCheck39(oc_Group_groupMutex,oc_Group_checkMutex,child_NewCheck391);
	child_NewCheck391?0;
	stop_process: skip;
	child!0
}
proctype NewCheck211(Mutexdef group_groupMutex;Mutexdef group_checkMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

