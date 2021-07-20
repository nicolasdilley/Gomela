// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/dgraph-io/dgraph/blob/6b188f254202f9c38b16c4769b672dd0e9d596ac/raftwal/storage_test.go#L187
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStorageCreateSnapshot1870 = [1] of {int};
	run TestStorageCreateSnapshot187(child_TestStorageCreateSnapshot1870);
	run receiver(child_TestStorageCreateSnapshot1870)
stop_process:skip
}

proctype TestStorageCreateSnapshot187(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Snapshot2752 = [1] of {int};
	chan child_CreateSnapshot2851 = [1] of {int};
	chan child_reset1340 = [1] of {int};
	chan child_Snapshot2755 = [1] of {int};
	chan child_CreateSnapshot2854 = [1] of {int};
	chan child_reset1343 = [1] of {int};
	Mutexdef ds_lock;
	int var_teststests = -2; // opt var_teststests
	run mutexMonitor(ds_lock);
	

	if
	:: var_tests-1 != -3 -> 
				for(i : 0.. var_tests-1) {
			for10: skip;
			run reset134(ds_lock,child_reset1340);
			child_reset1340?0;
			run CreateSnapshot285(ds_lock,child_CreateSnapshot2851);
			child_CreateSnapshot2851?0;
			run Snapshot275(ds_lock,child_Snapshot2752);
			child_Snapshot2752?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run reset134(ds_lock,child_reset1343);
			child_reset1343?0;
			run CreateSnapshot285(ds_lock,child_CreateSnapshot2854);
			child_CreateSnapshot2854?0;
			run Snapshot275(ds_lock,child_Snapshot2755);
			child_Snapshot2755?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype reset134(Mutexdef w_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_addEntries3380 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run addEntries338(w_lock,child_addEntries3380);
	child_addEntries3380?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype addEntries338(Mutexdef w_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_FirstIndex2640 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run FirstIndex264(w_lock,child_FirstIndex2640);
	child_FirstIndex2640?0;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype FirstIndex264(Mutexdef w_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_firstIndex2560 = [1] of {int};
	w_lock.Lock!false;
	run firstIndex256(w_lock,child_firstIndex2560);
	child_firstIndex2560?0;
	goto defer1;
		defer1: skip;
	w_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype firstIndex256(Mutexdef w_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Uint1310 = [1] of {int};
	run Uint131(w_lock,child_Uint1310);
	child_Uint1310?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Uint131(Mutexdef w_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype CreateSnapshot285(Mutexdef w_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_firstIndex2561 = [1] of {int};
	w_lock.Lock!false;
	run firstIndex256(w_lock,child_firstIndex2561);
	child_firstIndex2561?0;
	

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
	w_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Snapshot275(Mutexdef w_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	w_lock.Lock!false;
	goto defer1;
		defer1: skip;
	w_lock.Unlock!false;
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
