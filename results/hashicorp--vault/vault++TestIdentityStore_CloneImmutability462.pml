
// https://github.com/hashicorp/vault/blob/master/vault/identity_store_entities_test.go#L462
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestIdentityStore_CloneImmutability4620 = [1] of {int};
	run TestIdentityStore_CloneImmutability462(child_TestIdentityStore_CloneImmutability4620)
stop_process:skip
}

proctype TestIdentityStore_CloneImmutability462(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Clone271 = [1] of {int};
	Mutexdef clonedAlias_LastUpdateTime_state_atomicMessageInfo_initMu;
	Mutexdef clonedAlias_CreationTime_state_atomicMessageInfo_initMu;
	Mutexdef clonedAlias_state_atomicMessageInfo_initMu;
	chan child_Clone270 = [1] of {int};
	Mutexdef clonedEntity_LastUpdateTime_state_atomicMessageInfo_initMu;
	Mutexdef clonedEntity_CreationTime_state_atomicMessageInfo_initMu;
	Mutexdef clonedEntity_state_atomicMessageInfo_initMu;
	Mutexdef entity_LastUpdateTime_state_atomicMessageInfo_initMu;
	Mutexdef entity_CreationTime_state_atomicMessageInfo_initMu;
	Mutexdef entity_state_atomicMessageInfo_initMu;
	Mutexdef alias_LastUpdateTime_state_atomicMessageInfo_initMu;
	Mutexdef alias_CreationTime_state_atomicMessageInfo_initMu;
	Mutexdef alias_state_atomicMessageInfo_initMu;
	run mutexMonitor(alias_state_atomicMessageInfo_initMu);
	run mutexMonitor(alias_CreationTime_state_atomicMessageInfo_initMu);
	run mutexMonitor(alias_LastUpdateTime_state_atomicMessageInfo_initMu);
	run mutexMonitor(entity_state_atomicMessageInfo_initMu);
	run mutexMonitor(entity_CreationTime_state_atomicMessageInfo_initMu);
	run mutexMonitor(entity_LastUpdateTime_state_atomicMessageInfo_initMu);
	run mutexMonitor(clonedEntity_state_atomicMessageInfo_initMu);
	run mutexMonitor(clonedEntity_CreationTime_state_atomicMessageInfo_initMu);
	run mutexMonitor(clonedEntity_LastUpdateTime_state_atomicMessageInfo_initMu);
	run Clone27(entity_state_atomicMessageInfo_initMu,entity_CreationTime_state_atomicMessageInfo_initMu,entity_LastUpdateTime_state_atomicMessageInfo_initMu,child_Clone270);
	child_Clone270?0;
	run mutexMonitor(clonedAlias_state_atomicMessageInfo_initMu);
	run mutexMonitor(clonedAlias_CreationTime_state_atomicMessageInfo_initMu);
	run mutexMonitor(clonedAlias_LastUpdateTime_state_atomicMessageInfo_initMu);
	run Clone27(alias_state_atomicMessageInfo_initMu,alias_CreationTime_state_atomicMessageInfo_initMu,alias_LastUpdateTime_state_atomicMessageInfo_initMu,child_Clone271);
	child_Clone271?0;
	stop_process: skip;
	child!0
}
proctype Clone27(Mutexdef e_state_atomicMessageInfo_initMu;Mutexdef e_CreationTime_state_atomicMessageInfo_initMu;Mutexdef e_LastUpdateTime_state_atomicMessageInfo_initMu;chan child) {
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

