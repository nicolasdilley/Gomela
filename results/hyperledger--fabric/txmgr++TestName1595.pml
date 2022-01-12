// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/ledger/kvledger/txmgmt/txmgr/txmgr_test.go#L1595
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestName15950 = [1] of {int};
	run TestName1595(child_TestName15950);
	run receiver(child_TestName15950)
stop_process:skip
}

proctype TestName1595(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Name5760 = [1] of {int};
	Mutexdef txMgr_oldBlockCommit;
	Mutexdef txMgr_commitRWLock;
	run mutexMonitor(txMgr_commitRWLock);
	run mutexMonitor(txMgr_oldBlockCommit);
	run Name576(txMgr_commitRWLock,txMgr_oldBlockCommit,child_Name5760);
	child_Name5760?0;
	stop_process: skip;
	child!0
}
proctype Name576(Mutexdef txmgr_commitRWLock;Mutexdef txmgr_oldBlockCommit;chan child) {
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

