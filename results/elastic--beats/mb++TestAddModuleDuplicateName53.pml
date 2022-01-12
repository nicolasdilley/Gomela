// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//metricbeat/mb/registry_test.go#L53
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAddModuleDuplicateName530 = [1] of {int};
	run TestAddModuleDuplicateName53(child_TestAddModuleDuplicateName530);
	run receiver(child_TestAddModuleDuplicateName530)
stop_process:skip
}

proctype TestAddModuleDuplicateName53(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AddModule1491 = [1] of {int};
	chan child_AddModule1490 = [1] of {int};
	Mutexdef registry_lock;
	run mutexMonitor(registry_lock);
	run AddModule149(registry_lock,child_AddModule1490);
	child_AddModule1490?0;
	run AddModule149(registry_lock,child_AddModule1491);
	child_AddModule1491?0;
	stop_process: skip;
	child!0
}
proctype AddModule149(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_lock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	r_lock.Unlock!false;
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

