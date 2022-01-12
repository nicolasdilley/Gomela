// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/handlers/validation/builtin/v13/validation_logic.go#L75
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_New750 = [1] of {int};
	run New75(child_New750);
	run receiver(child_New750)
stop_process:skip
}

proctype New75(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewKeyLevelValidator1751 = [1] of {int};
	Mutexdef sbv_blockDep_mutex;
	chan child_NewV13Evaluator200 = [1] of {int};
	Mutexdef vpmgr_validationCtx_mutex;
	run mutexMonitor(vpmgr_validationCtx_mutex);
	run NewV13Evaluator20(vpmgr_validationCtx_mutex,child_NewV13Evaluator200);
	child_NewV13Evaluator200?0;
	run mutexMonitor(sbv_blockDep_mutex);
	run NewKeyLevelValidator175(vpmgr_validationCtx_mutex,child_NewKeyLevelValidator1751);
	child_NewKeyLevelValidator1751?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewV13Evaluator20(Mutexdef vpmgr_validationCtx_mutex;chan child) {
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

