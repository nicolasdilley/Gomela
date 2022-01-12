// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/vitessio/vitess/blob//go/test/endtoend/sharding/verticalsplit/vertical_split_test.go#L700
#define def_var_cellsArr  -2 // opt cellsArr line 700
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_validateKeyspaceJSON7000 = [1] of {int};
	run validateKeyspaceJSON700(def_var_cellsArr,child_validateKeyspaceJSON7000);
	run receiver(child_validateKeyspaceJSON7000)
stop_process:skip
}

proctype validateKeyspaceJSON700(int var_cellsArr;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef keyspace_SnapshotTime_state_atomicMessageInfo_initMu;
	Mutexdef keyspace_state_atomicMessageInfo_initMu;
	int var_keyspace_GetServedFroms = -2; // opt var_keyspace_GetServedFroms
	run mutexMonitor(keyspace_state_atomicMessageInfo_initMu);
	run mutexMonitor(keyspace_SnapshotTime_state_atomicMessageInfo_initMu);
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

