// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//x-pack/elastic-agent/pkg/agent/application/filelock/locker_test.go#L18
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAppLocker180 = [1] of {int};
	run TestAppLocker18(child_TestAppLocker180);
	run receiver(child_TestAppLocker180)
stop_process:skip
}

proctype TestAppLocker18(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Unlock465 = [1] of {int};
	chan child_TryLock344 = [1] of {int};
	chan child_TryLock343 = [1] of {int};
	chan child_Unlock462 = [1] of {int};
	chan child_TryLock341 = [1] of {int};
	chan child_TryLock340 = [1] of {int};
	Mutexdef locker2_lock_m;
	Mutexdef locker1_lock_m;
	run mutexMonitor(locker1_lock_m);
	run mutexMonitor(locker2_lock_m);
	run TryLock34(locker1_lock_m,child_TryLock340);
	child_TryLock340?0;
	run TryLock34(locker2_lock_m,child_TryLock341);
	child_TryLock341?0;
	run Unlock46(locker1_lock_m,child_Unlock462);
	child_Unlock462?0;
	run TryLock34(locker2_lock_m,child_TryLock343);
	child_TryLock343?0;
	run TryLock34(locker1_lock_m,child_TryLock344);
	child_TryLock344?0;
	run Unlock46(locker2_lock_m,child_Unlock465);
	child_Unlock465?0;
	stop_process: skip;
	child!0
}
proctype TryLock34(Mutexdef a_lock_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Unlock46(Mutexdef a_lock_m;chan child) {
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

proctype receiver(chan c) {
c?0
}

