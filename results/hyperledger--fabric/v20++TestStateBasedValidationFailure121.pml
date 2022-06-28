// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/handlers/validation/builtin/v20/validation_logic_test.go#L121
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStateBasedValidationFailure1210 = [1] of {int};
	run TestStateBasedValidationFailure121(child_TestStateBasedValidationFailure1210);
	run receiver(child_TestStateBasedValidationFailure1210)
stop_process:skip
}

proctype TestStateBasedValidationFailure121(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_New700 = [1] of {int};
	Mutexdef sf_invocationsMutex;
	Mutexdef sf_fetchStateMutex;
	run mutexMonitor(sf_fetchStateMutex);
	run mutexMonitor(sf_invocationsMutex);
	run New70(sf_fetchStateMutex,sf_invocationsMutex,child_New700);
	child_New700?0;
	stop_process: skip;
	child!0
}
proctype New70(Mutexdef s_fetchStateMutex;Mutexdef s_invocationsMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewKeyLevelValidator1751 = [1] of {int};
	Mutexdef sbv_blockDep_mutex;
	chan child_NewV20Evaluator220 = [1] of {int};
	Mutexdef vpmgr_validationCtx_mutex;
	run mutexMonitor(vpmgr_validationCtx_mutex);
	run NewV20Evaluator22(vpmgr_validationCtx_mutex,s_fetchStateMutex,s_invocationsMutex,child_NewV20Evaluator220);
	child_NewV20Evaluator220?0;
	run mutexMonitor(sbv_blockDep_mutex);
	run NewKeyLevelValidator175(vpmgr_validationCtx_mutex,child_NewKeyLevelValidator1751);
	child_NewKeyLevelValidator1751?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewV20Evaluator22(Mutexdef vpmgr_validationCtx_mutex;Mutexdef StateFetcher_fetchStateMutex;Mutexdef StateFetcher_invocationsMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewKeyLevelValidator175(Mutexdef vpmgr_validationCtx_mutex;chan child) {
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
