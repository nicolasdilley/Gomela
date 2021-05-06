
// https://github.com/hashicorp/vault/blob/master/builtin/logical/database/backend_test.go#L95
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBackend_RoleUpgrade950 = [1] of {int};
	run TestBackend_RoleUpgrade95(child_TestBackend_RoleUpgrade950)
stop_process:skip
}

proctype TestBackend_RoleUpgrade95(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Role1673 = [1] of {int};
	chan child_Put9232 = [1] of {int};
	chan child_Role1671 = [1] of {int};
	Mutexdef role_Statements_state_atomicMessageInfo_initMu;
	chan child_Put9230 = [1] of {int};
	Mutexdef roleExpected_Statements_state_atomicMessageInfo_initMu;
	Mutexdef backend_credRotationQueue_lock;
	Mutexdef storage_once_m;
	run mutexMonitor(storage_once_m);
	run mutexMonitor(backend_credRotationQueue_lock);
	run mutexMonitor(roleExpected_Statements_state_atomicMessageInfo_initMu);
	run Put923(storage_once_m,child_Put9230);
	child_Put9230?0;
	run mutexMonitor(role_Statements_state_atomicMessageInfo_initMu);
	run Role167(backend_credRotationQueue_lock,storage_once_m,child_Role1671);
	child_Role1671?0;
	run Put923(storage_once_m,child_Put9232);
	child_Put9232?0;
	run Role167(backend_credRotationQueue_lock,storage_once_m,child_Role1673);
	child_Role1673?0;
	stop_process: skip;
	child!0
}
proctype Put923(Mutexdef f_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Role167(Mutexdef b_credRotationQueue_lock;Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_roleAtPath1751 = [1] of {int};
	run roleAtPath175(b_credRotationQueue_lock,s_once_m,child_roleAtPath1751);
	child_roleAtPath1751?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype roleAtPath175(Mutexdef b_credRotationQueue_lock;Mutexdef s_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef stmts_state_atomicMessageInfo_initMu;
	Mutexdef result_Statements_state_atomicMessageInfo_initMu;
	chan child_Get9311 = [1] of {int};
	run Get931(s_once_m,child_Get9311);
	child_Get9311?0;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(result_Statements_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run mutexMonitor(stmts_state_atomicMessageInfo_initMu)
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Get931(Mutexdef f_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

