
// https://github.com/grpc/grpc-go/blob/master/balancer/rls/internal/picker_test.go#L48
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_initKeyBuilderMap480 = [1] of {int};
	run initKeyBuilderMap48(child_initKeyBuilderMap480)
stop_process:skip
}

proctype initKeyBuilderMap48(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef kb3_ExtraKeys_state_atomicMessageInfo_initMu;
	Mutexdef kb3_state_atomicMessageInfo_initMu;
	Mutexdef kb2_ExtraKeys_state_atomicMessageInfo_initMu;
	Mutexdef kb2_state_atomicMessageInfo_initMu;
	Mutexdef kb1_ExtraKeys_state_atomicMessageInfo_initMu;
	Mutexdef kb1_state_atomicMessageInfo_initMu;
	run mutexMonitor(kb1_state_atomicMessageInfo_initMu);
	run mutexMonitor(kb1_ExtraKeys_state_atomicMessageInfo_initMu);
	run mutexMonitor(kb2_state_atomicMessageInfo_initMu);
	run mutexMonitor(kb2_ExtraKeys_state_atomicMessageInfo_initMu);
	run mutexMonitor(kb3_state_atomicMessageInfo_initMu);
	run mutexMonitor(kb3_ExtraKeys_state_atomicMessageInfo_initMu);
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

