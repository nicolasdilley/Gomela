// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/srvtopo/resolver_test.go#L99
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestResolveDestinations990 = [1] of {int};
	run TestResolveDestinations99(child_TestResolveDestinations990);
	run receiver(child_TestResolveDestinations990)
stop_process:skip
}

proctype TestResolveDestinations99(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef kr2830_state_atomicMessageInfo_initMu;
	Mutexdef kr80a0_state_atomicMessageInfo_initMu;
	Mutexdef kr2040_state_atomicMessageInfo_initMu;
	Mutexdef id2_state_atomicMessageInfo_initMu;
	Mutexdef id1_state_atomicMessageInfo_initMu;
	int var_rss = -2; // opt var_rss
	int var_testCases = -2; // opt var_testCases
	run mutexMonitor(id1_state_atomicMessageInfo_initMu);
	run mutexMonitor(id2_state_atomicMessageInfo_initMu);
	run mutexMonitor(kr2040_state_atomicMessageInfo_initMu);
	run mutexMonitor(kr80a0_state_atomicMessageInfo_initMu);
	run mutexMonitor(kr2830_state_atomicMessageInfo_initMu);
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

