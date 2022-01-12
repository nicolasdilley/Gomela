// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/syncx/resourcemanager_test.go#L48
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestResourceManager_Close480 = [1] of {int};
	run TestResourceManager_Close48(child_TestResourceManager_Close480);
	run receiver(child_TestResourceManager_Close480)
stop_process:skip
}

proctype TestResourceManager_Close48(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close272 = [1] of {int};
	chan child_GetResource451 = [1] of {int};
	chan child_GetResource450 = [1] of {int};
	Mutexdef manager_lock;
	run mutexMonitor(manager_lock);
	

	if
	:: 0 != -2 && 10-1 != -3 -> 
				for(i : 0.. 10-1) {
			for11: skip;
			run GetResource45(manager_lock,child_GetResource451);
			child_GetResource451?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run GetResource45(manager_lock,child_GetResource450);
			child_GetResource450?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run Close27(manager_lock,child_Close272);
	child_Close272?0;
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

