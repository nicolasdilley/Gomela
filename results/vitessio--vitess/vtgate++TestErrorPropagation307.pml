// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vtgate/vtgate_test.go#L307
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestErrorPropagation3070 = [1] of {int};
	run TestErrorPropagation307(child_TestErrorPropagation3070);
	run receiver(child_TestErrorPropagation3070)
stop_process:skip
}

proctype TestErrorPropagation307(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef sbcrdonly_execMu;
	Mutexdef sbcrdonly_sExecMu;
	Mutexdef sbcrdonly_mapMu;
	Mutexdef sbcrdonly_tablet_state_atomicMessageInfo_initMu;
	Mutexdef sbcm_execMu;
	Mutexdef sbcm_sExecMu;
	Mutexdef sbcm_mapMu;
	Mutexdef sbcm_tablet_state_atomicMessageInfo_initMu;
	run mutexMonitor(sbcm_tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(sbcm_mapMu);
	run mutexMonitor(sbcm_sExecMu);
	run mutexMonitor(sbcm_execMu);
	run mutexMonitor(sbcrdonly_tablet_state_atomicMessageInfo_initMu);
	run mutexMonitor(sbcrdonly_mapMu);
	run mutexMonitor(sbcrdonly_sExecMu);
	run mutexMonitor(sbcrdonly_execMu);
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

