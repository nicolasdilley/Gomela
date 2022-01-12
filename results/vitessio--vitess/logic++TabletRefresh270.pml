// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/orchestrator/logic/tablet_discovery.go#L270
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TabletRefresh2700 = [1] of {int};
	run TabletRefresh270(child_TabletRefresh2700);
	run receiver(child_TabletRefresh2700)
stop_process:skip
}

proctype TabletRefresh270(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef tablet_PrimaryTermStartTime_state_atomicMessageInfo_initMu;
	Mutexdef tablet_KeyRange_state_atomicMessageInfo_initMu;
	Mutexdef tablet_Alias_state_atomicMessageInfo_initMu;
	Mutexdef tablet_state_atomicMessageInfo_initMu;
	run mutexMonitor(tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(tablet_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(tablet_KeyRange_state_atomicMessageInfo_initMu);
	run mutexMonitor(tablet_PrimaryTermStartTime_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

