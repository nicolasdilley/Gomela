
// https://github.com/hashicorp/vault/blob/master/command/agent/cache/cacheboltdb/bolt_test.go#L83
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBoltClear830 = [1] of {int};
	run TestBoltClear83(child_TestBoltClear830)
stop_process:skip
}

proctype TestBoltClear83(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetByType1909 = [1] of {int};
	chan child_GetByType1908 = [1] of {int};
	chan child_GetByType1907 = [1] of {int};
	chan child_Clear2796 = [1] of {int};
	chan child_GetByType1905 = [1] of {int};
	chan child_Set1244 = [1] of {int};
	chan child_GetByType1903 = [1] of {int};
	chan child_Set1242 = [1] of {int};
	chan child_GetByType1901 = [1] of {int};
	chan child_Set1240 = [1] of {int};
	Mutexdef b_db_statlock;
	Mutexdef b_db_mmaplock;
	Mutexdef b_db_metalock;
	Mutexdef b_db_rwlock;
	Mutexdef b_db_batch_start_m;
	Mutexdef b_db_batchMu;
	Mutexdef b_db_freelistLoad_m;
	run mutexMonitor(b_db_freelistLoad_m);
	run mutexMonitor(b_db_batchMu);
	run mutexMonitor(b_db_batch_start_m);
	run mutexMonitor(b_db_rwlock);
	run mutexMonitor(b_db_metalock);
	run mutexMonitor(b_db_mmaplock);
	run mutexMonitor(b_db_statlock);
	run Set124(b_db_freelistLoad_m,b_db_batchMu,b_db_batch_start_m,b_db_rwlock,b_db_metalock,b_db_mmaplock,b_db_statlock,child_Set1240);
	child_Set1240?0;
	run GetByType190(b_db_freelistLoad_m,b_db_batchMu,b_db_batch_start_m,b_db_rwlock,b_db_metalock,b_db_mmaplock,b_db_statlock,child_GetByType1901);
	child_GetByType1901?0;
	run Set124(b_db_freelistLoad_m,b_db_batchMu,b_db_batch_start_m,b_db_rwlock,b_db_metalock,b_db_mmaplock,b_db_statlock,child_Set1242);
	child_Set1242?0;
	run GetByType190(b_db_freelistLoad_m,b_db_batchMu,b_db_batch_start_m,b_db_rwlock,b_db_metalock,b_db_mmaplock,b_db_statlock,child_GetByType1903);
	child_GetByType1903?0;
	run Set124(b_db_freelistLoad_m,b_db_batchMu,b_db_batch_start_m,b_db_rwlock,b_db_metalock,b_db_mmaplock,b_db_statlock,child_Set1244);
	child_Set1244?0;
	run GetByType190(b_db_freelistLoad_m,b_db_batchMu,b_db_batch_start_m,b_db_rwlock,b_db_metalock,b_db_mmaplock,b_db_statlock,child_GetByType1905);
	child_GetByType1905?0;
	run Clear279(b_db_freelistLoad_m,b_db_batchMu,b_db_batch_start_m,b_db_rwlock,b_db_metalock,b_db_mmaplock,b_db_statlock,child_Clear2796);
	child_Clear2796?0;
	run GetByType190(b_db_freelistLoad_m,b_db_batchMu,b_db_batch_start_m,b_db_rwlock,b_db_metalock,b_db_mmaplock,b_db_statlock,child_GetByType1907);
	child_GetByType1907?0;
	run GetByType190(b_db_freelistLoad_m,b_db_batchMu,b_db_batch_start_m,b_db_rwlock,b_db_metalock,b_db_mmaplock,b_db_statlock,child_GetByType1908);
	child_GetByType1908?0;
	run GetByType190(b_db_freelistLoad_m,b_db_batchMu,b_db_batch_start_m,b_db_rwlock,b_db_metalock,b_db_mmaplock,b_db_statlock,child_GetByType1909);
	child_GetByType1909?0;
	stop_process: skip;
	child!0
}
proctype Set124(Mutexdef b_db_freelistLoad_m;Mutexdef b_db_batchMu;Mutexdef b_db_batch_start_m;Mutexdef b_db_rwlock;Mutexdef b_db_metalock;Mutexdef b_db_mmaplock;Mutexdef b_db_statlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef blob_KeyInfo_state_atomicMessageInfo_initMu;
	Mutexdef blob_state_atomicMessageInfo_initMu;
	run mutexMonitor(blob_state_atomicMessageInfo_initMu);
	run mutexMonitor(blob_KeyInfo_state_atomicMessageInfo_initMu);
	

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
proctype GetByType190(Mutexdef b_db_freelistLoad_m;Mutexdef b_db_batchMu;Mutexdef b_db_batch_start_m;Mutexdef b_db_rwlock;Mutexdef b_db_metalock;Mutexdef b_db_mmaplock;Mutexdef b_db_statlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Clear279(Mutexdef b_db_freelistLoad_m;Mutexdef b_db_batchMu;Mutexdef b_db_batch_start_m;Mutexdef b_db_rwlock;Mutexdef b_db_metalock;Mutexdef b_db_mmaplock;Mutexdef b_db_statlock;chan child) {
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

