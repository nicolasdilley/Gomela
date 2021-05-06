
// https://github.com/dapr/dapr/blob/master/tests/runner/testresource_test.go#L36
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAdd360 = [1] of {int};
	run TestAdd36(child_TestAdd360)
stop_process:skip
}

proctype TestAdd36(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Add301 = [1] of {int};
	chan child_Add300 = [1] of {int};
	Mutexdef resource_activeResourcesLock;
	Mutexdef resource_resourcesLock;
	run mutexMonitor(resource_resourcesLock);
	run mutexMonitor(resource_activeResourcesLock);
	

	if
	:: 0 != -2 && 3-1 != -3 -> 
				for(i : 0.. 3-1) {
			for11: skip;
			run Add30(resource_resourcesLock,resource_activeResourcesLock,child_Add301);
			child_Add301?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Add30(resource_resourcesLock,resource_activeResourcesLock,child_Add300);
			child_Add300?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype Add30(Mutexdef r_resourcesLock;Mutexdef r_activeResourcesLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_resourcesLock.Lock!false;
	stop_process: skip;
		r_resourcesLock.Unlock!false;
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

