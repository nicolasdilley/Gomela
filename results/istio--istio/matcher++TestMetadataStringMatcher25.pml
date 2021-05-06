
// https://github.com/istio/istio/blob/master/pilot/pkg/security/authz/matcher/metadata_test.go#L25
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMetadataStringMatcher250 = [1] of {int};
	run TestMetadataStringMatcher25(child_TestMetadataStringMatcher250)
stop_process:skip
}

proctype TestMetadataStringMatcher25(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef expect_Value_state_atomicMessageInfo_initMu;
	Mutexdef expect_state_atomicMessageInfo_initMu;
	chan child_MetadataStringMatcher230 = [1] of {int};
	Mutexdef actual_Value_state_atomicMessageInfo_initMu;
	Mutexdef actual_state_atomicMessageInfo_initMu;
	Mutexdef matcher_state_atomicMessageInfo_initMu;
	run mutexMonitor(matcher_state_atomicMessageInfo_initMu);
	run mutexMonitor(actual_state_atomicMessageInfo_initMu);
	run mutexMonitor(actual_Value_state_atomicMessageInfo_initMu);
	run MetadataStringMatcher23(matcher_state_atomicMessageInfo_initMu,child_MetadataStringMatcher230);
	child_MetadataStringMatcher230?0;
	run mutexMonitor(expect_state_atomicMessageInfo_initMu);
	run mutexMonitor(expect_Value_state_atomicMessageInfo_initMu);
	stop_process: skip;
	child!0
}
proctype MetadataStringMatcher23(Mutexdef m_state_atomicMessageInfo_initMu;chan child) {
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

