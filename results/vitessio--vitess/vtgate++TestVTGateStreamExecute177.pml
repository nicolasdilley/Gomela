// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtgate/vtgate_test.go#L177
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestVTGateStreamExecute1770 = [1] of {int};
	run TestVTGateStreamExecute177(child_TestVTGateStreamExecute1770);
	run receiver(child_TestVTGateStreamExecute1770)
stop_process:skip
}

proctype TestVTGateStreamExecute177(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef sbc_execMu;
	Mutexdef sbc_sExecMu;
	Mutexdef sbc_mapMu;
	Mutexdef sbc_tablet_state_atomicMessageInfo_initMu;
	run mutexMonitor(sbc_tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(sbc_mapMu);
	run mutexMonitor(sbc_sExecMu);
	run mutexMonitor(sbc_execMu);
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

