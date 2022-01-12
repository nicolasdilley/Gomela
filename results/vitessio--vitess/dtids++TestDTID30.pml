// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/dtids/dtids_test.go#L30
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDTID300 = [1] of {int};
	run TestDTID30(child_TestDTID300);
	run receiver(child_TestDTID300)
stop_process:skip
}

proctype TestDTID30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef out_TabletAlias_state_atomicMessageInfo_initMu;
	Mutexdef out_Target_state_atomicMessageInfo_initMu;
	Mutexdef out_state_atomicMessageInfo_initMu;
	chan child_New340 = [1] of {int};
	Mutexdef in_TabletAlias_state_atomicMessageInfo_initMu;
	Mutexdef in_Target_state_atomicMessageInfo_initMu;
	Mutexdef in_state_atomicMessageInfo_initMu;
	run mutexMonitor(in_state_atomicMessageInfo_initMu);
	run mutexMonitor(in_Target_state_atomicMessageInfo_initMu);
	run mutexMonitor(in_TabletAlias_state_atomicMessageInfo_initMu);
	run New34(in_state_atomicMessageInfo_initMu,in_TabletAlias_state_atomicMessageInfo_initMu,in_Target_state_atomicMessageInfo_initMu,child_New340);
	child_New340?0;
	run mutexMonitor(out_state_atomicMessageInfo_initMu);
	run mutexMonitor(out_Target_state_atomicMessageInfo_initMu);
	run mutexMonitor(out_TabletAlias_state_atomicMessageInfo_initMu);
	stop_process: skip;
	child!0
}
proctype New34(Mutexdef mmShard_state_atomicMessageInfo_initMu;Mutexdef mmShard_TabletAlias_state_atomicMessageInfo_initMu;Mutexdef mmShard_Target_state_atomicMessageInfo_initMu;chan child) {
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

