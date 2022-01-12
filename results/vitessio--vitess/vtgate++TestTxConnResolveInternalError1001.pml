// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtgate/tx_conn_test.go#L1001
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTxConnResolveInternalError10010 = [1] of {int};
	run TestTxConnResolveInternalError1001(child_TestTxConnResolveInternalError10010);
	run receiver(child_TestTxConnResolveInternalError10010)
stop_process:skip
}

proctype TestTxConnResolveInternalError1001(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef __execMu;
	Mutexdef __sExecMu;
	Mutexdef __mapMu;
	Mutexdef __tablet_state_atomicMessageInfo_initMu;
	Mutexdef sbc0_execMu;
	Mutexdef sbc0_sExecMu;
	Mutexdef sbc0_mapMu;
	Mutexdef sbc0_tablet_state_atomicMessageInfo_initMu;
	run mutexMonitor(sbc0_tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(sbc0_mapMu);
	run mutexMonitor(sbc0_sExecMu);
	run mutexMonitor(sbc0_execMu);
	run mutexMonitor(__tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(__mapMu);
	run mutexMonitor(__sExecMu);
	run mutexMonitor(__execMu);
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

