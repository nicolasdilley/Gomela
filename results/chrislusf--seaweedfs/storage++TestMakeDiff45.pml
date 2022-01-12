// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/chrislusf/seaweedfs/blob//weed/storage/volume_vacuum_test.go#L45
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMakeDiff450 = [1] of {int};
	run TestMakeDiff45(child_TestMakeDiff450);
	run receiver(child_TestMakeDiff450)
stop_process:skip
}

proctype TestMakeDiff45(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef v_location_ecVolumesLock;
	Mutexdef v_location_volumesLock;
	Mutexdef v_volumeInfo_state_atomicMessageInfo_initMu;
	Mutexdef v_dataFileAccessLock;
	Mutexdef v_noWriteLock;
	run mutexMonitor(v_noWriteLock);
	run mutexMonitor(v_dataFileAccessLock);
	run mutexMonitor(v_volumeInfo_state_atomicMessageInfo_initMu);
	run mutexMonitor(v_location_volumesLock);
	run mutexMonitor(v_location_ecVolumesLock);
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

