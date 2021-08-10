// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/syncthing/syncthing/blob/87a0eecc31a0a5eeef1d0da510f4d5832e022e1f/lib/model/model_test.go#L2190
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSharedWithClearedOnDisconnect21900 = [1] of {int};
	run TestSharedWithClearedOnDisconnect2190(child_TestSharedWithClearedOnDisconnect21900);
	run receiver(child_TestSharedWithClearedOnDisconnect21900)
stop_process:skip
}

proctype TestSharedWithClearedOnDisconnect2190(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef conn2_mut;
	Mutexdef conn1_mut;
	int var_fcfg_Devices = -2; // opt var_fcfg_Devices
	run mutexMonitor(conn1_mut);
	run mutexMonitor(conn2_mut);
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

