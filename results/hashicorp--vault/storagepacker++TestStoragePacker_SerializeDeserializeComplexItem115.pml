
// https://github.com/hashicorp/vault/blob/master/helper/storagepacker/storagepacker_test.go#L115
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStoragePacker_SerializeDeserializeComplexItem1150 = [1] of {int};
	run TestStoragePacker_SerializeDeserializeComplexItem115(child_TestStoragePacker_SerializeDeserializeComplexItem1150)
stop_process:skip
}

proctype TestStoragePacker_SerializeDeserializeComplexItem115(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef itemDecoded_LastUpdateTime_state_atomicMessageInfo_initMu;
	Mutexdef itemDecoded_CreationTime_state_atomicMessageInfo_initMu;
	Mutexdef itemDecoded_state_atomicMessageInfo_initMu;
	Mutexdef itemFetched_Message_state_atomicMessageInfo_initMu;
	Mutexdef itemFetched_state_atomicMessageInfo_initMu;
	Mutexdef marshaledEntity_state_atomicMessageInfo_initMu;
	Mutexdef entity_LastUpdateTime_state_atomicMessageInfo_initMu;
	Mutexdef entity_CreationTime_state_atomicMessageInfo_initMu;
	Mutexdef entity_state_atomicMessageInfo_initMu;
	Mutexdef alias1_LastUpdateTime_state_atomicMessageInfo_initMu;
	Mutexdef alias1_CreationTime_state_atomicMessageInfo_initMu;
	Mutexdef alias1_state_atomicMessageInfo_initMu;
	Mutexdef timeNow_state_atomicMessageInfo_initMu;
	run mutexMonitor(timeNow_state_atomicMessageInfo_initMu);
	run mutexMonitor(alias1_state_atomicMessageInfo_initMu);
	run mutexMonitor(alias1_CreationTime_state_atomicMessageInfo_initMu);
	run mutexMonitor(alias1_LastUpdateTime_state_atomicMessageInfo_initMu);
	run mutexMonitor(entity_state_atomicMessageInfo_initMu);
	run mutexMonitor(entity_CreationTime_state_atomicMessageInfo_initMu);
	run mutexMonitor(entity_LastUpdateTime_state_atomicMessageInfo_initMu);
	run mutexMonitor(marshaledEntity_state_atomicMessageInfo_initMu);
	run mutexMonitor(itemFetched_state_atomicMessageInfo_initMu);
	run mutexMonitor(itemFetched_Message_state_atomicMessageInfo_initMu);
	run mutexMonitor(itemDecoded_state_atomicMessageInfo_initMu);
	run mutexMonitor(itemDecoded_CreationTime_state_atomicMessageInfo_initMu);
	run mutexMonitor(itemDecoded_LastUpdateTime_state_atomicMessageInfo_initMu);
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

