// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/syncx/resourcemanager_test.go#L62
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestResourceManager_UseAfterClose620 = [1] of {int};
	run TestResourceManager_UseAfterClose62(child_TestResourceManager_UseAfterClose620);
	run receiver(child_TestResourceManager_UseAfterClose620)
stop_process:skip
}

proctype TestResourceManager_UseAfterClose62(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetResource452 = [1] of {int};
	chan child_Close271 = [1] of {int};
	chan child_GetResource450 = [1] of {int};
	Mutexdef manager_lock;
	run mutexMonitor(manager_lock);
	run GetResource45(manager_lock,child_GetResource450);
	child_GetResource450?0;
	run Close27(manager_lock,child_Close271);
	child_Close271?0;
	

	if
	:: true -> 
		run GetResource45(manager_lock,child_GetResource452);
		child_GetResource452?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype GetResource45(Mutexdef manager_lock;chan child) {
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
proctype Close27(Mutexdef manager_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_manager_resources = -2; // opt var_manager_resources
	manager_lock.Lock!false;
	goto defer1;
		defer1: skip;
	manager_lock.Unlock!false;
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

