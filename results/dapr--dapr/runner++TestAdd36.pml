// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/dapr/dapr/blob//tests/runner/testresource_test.go#L36
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAdd360 = [1] of {int};
	run TestAdd36(child_TestAdd360);
	run receiver(child_TestAdd360)
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
	int var_resource_resources = -2; // opt var_resource_resources
	run mutexMonitor(resource_resourcesLock);
	run mutexMonitor(resource_activeResourcesLock);
	

	if
	:: 0 != -2 && 3-1 != -3 -> 
				for(i : 0.. 3-1) {
			for11: skip;
			run Add30(resource_activeResourcesLock,resource_resourcesLock,child_Add301);
			child_Add301?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Add30(resource_activeResourcesLock,resource_resourcesLock,child_Add300);
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
proctype Add30(Mutexdef r_activeResourcesLock;Mutexdef r_resourcesLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_resourcesLock.Lock!false;
		defer1: skip;
	r_resourcesLock.Unlock!false;
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

proctype receiver(chan c) {
c?0
}

