// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob//physical/raft/fsm_test.go#L132
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFSM_List1320 = [1] of {int};
	run TestFSM_List132(child_TestFSM_List1320);
	run receiver(child_TestFSM_List1320)
stop_process:skip
}

proctype TestFSM_List132(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_List4844 = [1] of {int};
	chan child_Put4711 = [1] of {int};
	chan child_Put4710 = [1] of {int};
	chan child_Put4713 = [1] of {int};
	chan child_Put4712 = [1] of {int};
	Mutexdef fsm_db_statlock;
	Mutexdef fsm_db_mmaplock;
	Mutexdef fsm_db_metalock;
	Mutexdef fsm_db_rwlock;
	Mutexdef fsm_db_batch_start_m;
	Mutexdef fsm_db_batchMu;
	Mutexdef fsm_db_freelistLoad_m;
	Mutexdef fsm_l;
	int var_keys = -2; // opt var_keys
	run mutexMonitor(fsm_l);
	run mutexMonitor(fsm_db_freelistLoad_m);
	run mutexMonitor(fsm_db_batchMu);
	run mutexMonitor(fsm_db_batch_start_m);
	run mutexMonitor(fsm_db_rwlock);
	run mutexMonitor(fsm_db_metalock);
	run mutexMonitor(fsm_db_mmaplock);
	run mutexMonitor(fsm_db_statlock);
	

	if
	:: var_keys-1 != -3 -> 
				for(i : 0.. var_keys-1) {
			for10: skip;
			run Put471(fsm_db_batch_start_m,fsm_db_batchMu,fsm_db_freelistLoad_m,fsm_db_metalock,fsm_db_mmaplock,fsm_db_rwlock,fsm_db_statlock,fsm_l,child_Put4710);
			child_Put4710?0;
			run Put471(fsm_db_batch_start_m,fsm_db_batchMu,fsm_db_freelistLoad_m,fsm_db_metalock,fsm_db_mmaplock,fsm_db_rwlock,fsm_db_statlock,fsm_l,child_Put4711);
			child_Put4711?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run Put471(fsm_db_batch_start_m,fsm_db_batchMu,fsm_db_freelistLoad_m,fsm_db_metalock,fsm_db_mmaplock,fsm_db_rwlock,fsm_db_statlock,fsm_l,child_Put4712);
			child_Put4712?0;
			run Put471(fsm_db_batch_start_m,fsm_db_batchMu,fsm_db_freelistLoad_m,fsm_db_metalock,fsm_db_mmaplock,fsm_db_rwlock,fsm_db_statlock,fsm_l,child_Put4713);
			child_Put4713?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	run List484(fsm_db_batch_start_m,fsm_db_batchMu,fsm_db_freelistLoad_m,fsm_db_metalock,fsm_db_mmaplock,fsm_db_rwlock,fsm_db_statlock,fsm_l,child_List4844);
	child_List4844?0;
	stop_process: skip;
	child!0
}
proctype Put471(Mutexdef f_db_batch_start_m;Mutexdef f_db_batchMu;Mutexdef f_db_freelistLoad_m;Mutexdef f_db_metalock;Mutexdef f_db_mmaplock;Mutexdef f_db_rwlock;Mutexdef f_db_statlock;Mutexdef f_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	f_l.RLock!false;
	goto defer1;
		defer1: skip;
	f_l.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype List484(Mutexdef f_db_batch_start_m;Mutexdef f_db_batchMu;Mutexdef f_db_freelistLoad_m;Mutexdef f_db_metalock;Mutexdef f_db_mmaplock;Mutexdef f_db_rwlock;Mutexdef f_db_statlock;Mutexdef f_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	f_l.RLock!false;
	goto defer1;
		defer1: skip;
	f_l.RUnlock!false;
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

