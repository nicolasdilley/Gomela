// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtgate/tx_conn_test.go#L1044
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTxConnResolveRollbackPreparedFail10440 = [1] of {int};
	run TestTxConnResolveRollbackPreparedFail1044(child_TestTxConnResolveRollbackPreparedFail10440);
	run receiver(child_TestTxConnResolveRollbackPreparedFail10440)
stop_process:skip
}

proctype TestTxConnResolveRollbackPreparedFail1044(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef sbc1_execMu;
	Mutexdef sbc1_sExecMu;
	Mutexdef sbc1_mapMu;
	Mutexdef sbc1_tablet_state_atomicMessageInfo_initMu;
	Mutexdef sbc0_execMu;
	Mutexdef sbc0_sExecMu;
	Mutexdef sbc0_mapMu;
	Mutexdef sbc0_tablet_state_atomicMessageInfo_initMu;
	run mutexMonitor(sbc0_tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(sbc0_mapMu);
	run mutexMonitor(sbc0_sExecMu);
	run mutexMonitor(sbc0_execMu);
	run mutexMonitor(sbc1_tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(sbc1_mapMu);
	run mutexMonitor(sbc1_sExecMu);
	run mutexMonitor(sbc1_execMu);
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

