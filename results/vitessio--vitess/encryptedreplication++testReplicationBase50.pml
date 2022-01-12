// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/test/endtoend/encryption/encryptedreplication/encrypted_replication_test.go#L50
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testReplicationBase500 = [1] of {int};
	run testReplicationBase50(child_testReplicationBase500);
	run receiver(child_testReplicationBase500)
stop_process:skip
}

proctype testReplicationBase50(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef replicaTablet_VtgrProcess_proc_Process_sigMu;
	Mutexdef replicaTablet_VttabletProcess_proc_Process_sigMu;
	Mutexdef replicaTablet_MysqlctldProcess_process_Process_sigMu;
	Mutexdef primaryTablet_VtgrProcess_proc_Process_sigMu;
	Mutexdef primaryTablet_VttabletProcess_proc_Process_sigMu;
	Mutexdef primaryTablet_MysqlctldProcess_process_Process_sigMu;
	run mutexMonitor(primaryTablet_MysqlctldProcess_process_Process_sigMu);
	run mutexMonitor(primaryTablet_VttabletProcess_proc_Process_sigMu);
	run mutexMonitor(primaryTablet_VtgrProcess_proc_Process_sigMu);
	run mutexMonitor(replicaTablet_MysqlctldProcess_process_Process_sigMu);
	run mutexMonitor(replicaTablet_VttabletProcess_proc_Process_sigMu);
	run mutexMonitor(replicaTablet_VtgrProcess_proc_Process_sigMu);
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

