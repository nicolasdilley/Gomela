// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/ledger/kvledger/tests/v1x_test.go#L277
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInitLedgerPanicWithV11Data2770 = [1] of {int};
	run TestInitLedgerPanicWithV11Data277(child_TestInitLedgerPanicWithV11Data2770);
	run receiver(child_TestInitLedgerPanicWithV11Data2770)
stop_process:skip
}

proctype TestInitLedgerPanicWithV11Data277(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_cleanup620 = [1] of {int};
	chan child_testInitLedgerPanic3061 = [1] of {int};
	Mutexdef env_ledgerMgr_lock;
	Mutexdef env_ledgerMgr_creationLock;
	Mutexdef env_t_context_mu;
	Mutexdef env_t_context_match_mu;
	run mutexMonitor(env_t_context_match_mu);
	run mutexMonitor(env_t_context_mu);
	run mutexMonitor(env_ledgerMgr_creationLock);
	run mutexMonitor(env_ledgerMgr_lock);
	run testInitLedgerPanic306(env_ledgerMgr_creationLock,env_ledgerMgr_lock,env_t_context_match_mu,env_t_context_mu,child_testInitLedgerPanic3061);
	child_testInitLedgerPanic3061?0;
		defer1: skip;
	run cleanup62(env_ledgerMgr_creationLock,env_ledgerMgr_lock,env_t_context_match_mu,env_t_context_mu,child_cleanup620);
	child_cleanup620?0;
	stop_process: skip;
	child!0
}
proctype cleanup62(Mutexdef e_ledgerMgr_creationLock;Mutexdef e_ledgerMgr_lock;Mutexdef e_t_context_match_mu;Mutexdef e_t_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype testInitLedgerPanic306(Mutexdef env_ledgerMgr_creationLock;Mutexdef env_ledgerMgr_lock;Mutexdef env_t_context_match_mu;Mutexdef env_t_context_mu;chan child) {
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

