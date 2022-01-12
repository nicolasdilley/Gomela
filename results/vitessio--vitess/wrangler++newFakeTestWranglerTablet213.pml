// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/wrangler/wrangler_env_test.go#L213
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newFakeTestWranglerTablet2130 = [1] of {int};
	run newFakeTestWranglerTablet213(child_newFakeTestWranglerTablet2130);
	run receiver(child_newFakeTestWranglerTablet2130)
stop_process:skip
}

proctype newFakeTestWranglerTablet213(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newTestWranglerTablet2740 = [1] of {int};
	Mutexdef tablet_PrimaryTermStartTime_state_atomicMessageInfo_initMu;
	Mutexdef tablet_KeyRange_state_atomicMessageInfo_initMu;
	Mutexdef tablet_Alias_state_atomicMessageInfo_initMu;
	Mutexdef tablet_state_atomicMessageInfo_initMu;
	run mutexMonitor(tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(tablet_Alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(tablet_KeyRange_state_atomicMessageInfo_initMu);
	run mutexMonitor(tablet_PrimaryTermStartTime_state_atomicMessageInfo_initMu);
	run newTestWranglerTablet274(tablet_Alias_state_atomicMessageInfo_initMu,tablet_KeyRange_state_atomicMessageInfo_initMu,tablet_PrimaryTermStartTime_state_atomicMessageInfo_initMu,tablet_state_atomicMessageInfo_initMu,child_newTestWranglerTablet2740);
	child_newTestWranglerTablet2740?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newTestWranglerTablet274(Mutexdef tablet_Alias_state_atomicMessageInfo_initMu;Mutexdef tablet_KeyRange_state_atomicMessageInfo_initMu;Mutexdef tablet_PrimaryTermStartTime_state_atomicMessageInfo_initMu;Mutexdef tablet_state_atomicMessageInfo_initMu;chan child) {
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

