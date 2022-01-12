// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/google/cadvisor/blob//manager/container_test.go#L155
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUpdateSpec1550 = [1] of {int};
	run TestUpdateSpec155(child_TestUpdateSpec1550);
	run receiver(child_TestUpdateSpec1550)
stop_process:skip
}

proctype TestUpdateSpec155(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_updateSpec6050 = [1] of {int};
	Mutexdef __lock;
	Mutexdef cd_summaryReader_dataLock;
	Mutexdef cd_lock;
	Mutexdef cd_memoryCache_lock;
	run mutexMonitor(cd_memoryCache_lock);
	run mutexMonitor(cd_lock);
	run mutexMonitor(cd_summaryReader_dataLock);
	run mutexMonitor(__lock);
	run updateSpec605(cd_lock,cd_memoryCache_lock,cd_summaryReader_dataLock,child_updateSpec6050);
	child_updateSpec6050?0;
	stop_process: skip;
	child!0
}
proctype updateSpec605(Mutexdef cd_lock;Mutexdef cd_memoryCache_lock;Mutexdef cd_summaryReader_dataLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	cd_lock.Lock!false;
	goto defer1;
		defer1: skip;
	cd_lock.Unlock!false;
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

