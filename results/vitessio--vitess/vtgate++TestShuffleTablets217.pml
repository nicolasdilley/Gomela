// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtgate/discoverygateway_test.go#L217
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestShuffleTablets2170 = [1] of {int};
	run TestShuffleTablets217(child_TestShuffleTablets2170);
	run receiver(child_TestShuffleTablets2170)
stop_process:skip
}

proctype TestShuffleTablets217(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef ts4_Stats_state_atomicMessageInfo_initMu;
	Mutexdef ts4_Target_state_atomicMessageInfo_initMu;
	Mutexdef ts4_Tablet_state_atomicMessageInfo_initMu;
	Mutexdef ts3_Stats_state_atomicMessageInfo_initMu;
	Mutexdef ts3_Target_state_atomicMessageInfo_initMu;
	Mutexdef ts3_Tablet_state_atomicMessageInfo_initMu;
	Mutexdef ts2_Stats_state_atomicMessageInfo_initMu;
	Mutexdef ts2_Target_state_atomicMessageInfo_initMu;
	Mutexdef ts2_Tablet_state_atomicMessageInfo_initMu;
	Mutexdef ts1_Stats_state_atomicMessageInfo_initMu;
	Mutexdef ts1_Target_state_atomicMessageInfo_initMu;
	Mutexdef ts1_Tablet_state_atomicMessageInfo_initMu;
	run mutexMonitor(ts1_Tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(ts1_Target_state_atomicMessageInfo_initMu);
	run mutexMonitor(ts1_Stats_state_atomicMessageInfo_initMu);
	run mutexMonitor(ts2_Tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(ts2_Target_state_atomicMessageInfo_initMu);
	run mutexMonitor(ts2_Stats_state_atomicMessageInfo_initMu);
	run mutexMonitor(ts3_Tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(ts3_Target_state_atomicMessageInfo_initMu);
	run mutexMonitor(ts3_Stats_state_atomicMessageInfo_initMu);
	run mutexMonitor(ts4_Tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(ts4_Target_state_atomicMessageInfo_initMu);
	run mutexMonitor(ts4_Stats_state_atomicMessageInfo_initMu);
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

