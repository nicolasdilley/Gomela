// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/ledger/kvledger/benchmark/chainmgmt/sanity_test.go#L18
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestChainMgmt180 = [1] of {int};
	run TestChainMgmt18(child_TestChainMgmt180);
	run receiver(child_TestChainMgmt180)
stop_process:skip
}

proctype TestChainMgmt18(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Chains400 = [1] of {int};
	Wgdef env_mgr_wg;
	Mutexdef env_mgr_ledgerMgr_lock;
	Mutexdef env_mgr_ledgerMgr_creationLock;
	run mutexMonitor(env_mgr_ledgerMgr_creationLock);
	run mutexMonitor(env_mgr_ledgerMgr_lock);
	run wgMonitor(env_mgr_wg);
	run Chains40(env_mgr_wg,env_mgr_ledgerMgr_creationLock,env_mgr_ledgerMgr_lock,child_Chains400);
	child_Chains400?0;
	stop_process: skip;
	child!0
}
proctype Chains40(Wgdef env_mgr_wg;Mutexdef env_mgr_ledgerMgr_creationLock;Mutexdef env_mgr_ledgerMgr_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_chains930 = [1] of {int};
	run chains93(env_mgr_wg,env_mgr_ledgerMgr_creationLock,env_mgr_ledgerMgr_lock,child_chains930);
	child_chains930?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype chains93(Wgdef m_wg;Mutexdef m_ledgerMgr_creationLock;Mutexdef m_ledgerMgr_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_m_chainsMap = -2; // opt var_m_chainsMap
	goto stop_process;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

