// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//common/ledger/blockledger/fileledger/factory_test.go#L192
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRemove1920 = [1] of {int};
	run TestRemove192(child_TestRemove1920);
	run receiver(child_TestRemove1920)
stop_process:skip
}

proctype TestRemove192(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close970 = [1] of {int};
	Mutexdef f_removeFileRepo_mu;
	Mutexdef f_mutex;
	Mutexdef fileRepo_mu;
	Mutexdef mockBlockStore_invocationsMutex;
	Mutexdef mockBlockStore_openMutex;
	Mutexdef mockBlockStore_listMutex;
	Mutexdef mockBlockStore_dropMutex;
	Mutexdef mockBlockStore_closeMutex;
	run mutexMonitor(mockBlockStore_closeMutex);
	run mutexMonitor(mockBlockStore_dropMutex);
	run mutexMonitor(mockBlockStore_listMutex);
	run mutexMonitor(mockBlockStore_openMutex);
	run mutexMonitor(mockBlockStore_invocationsMutex);
	run mutexMonitor(fileRepo_mu);
	run mutexMonitor(f_mutex);
	run mutexMonitor(f_removeFileRepo_mu);
		defer1: skip;
	run Close97(f_mutex,f_removeFileRepo_mu,child_Close970);
	child_Close970?0;
	stop_process: skip;
	child!0
}
proctype Close97(Mutexdef f_mutex;Mutexdef f_removeFileRepo_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

