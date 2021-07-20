// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/terraform/evaluate_test.go#L18
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEvaluatorGetTerraformAttr180 = [1] of {int};
	run TestEvaluatorGetTerraformAttr18(child_TestEvaluatorGetTerraformAttr180);
	run receiver(child_TestEvaluatorGetTerraformAttr180)
stop_process:skip
}

proctype TestEvaluatorGetTerraformAttr18(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Scope710 = [1] of {int};
	Mutexdef scope_funcsLock;
	Mutexdef data_Evaluator_VariableValuesLock;
	Mutexdef evaluator_Changes_lock;
	Mutexdef evaluator_State_lock;
	Mutexdef evaluator_VariableValuesLock;
	run mutexMonitor(evaluator_VariableValuesLock);
	run mutexMonitor(evaluator_State_lock);
	run mutexMonitor(evaluator_Changes_lock);
	run mutexMonitor(data_Evaluator_VariableValuesLock);
	run mutexMonitor(scope_funcsLock);
	run Scope71(evaluator_Changes_lock,evaluator_State_lock,evaluator_VariableValuesLock,data_Evaluator_VariableValuesLock,child_Scope710);
	child_Scope710?0;
	stop_process: skip;
	child!0
}
proctype Scope71(Mutexdef e_Changes_lock;Mutexdef e_State_lock;Mutexdef e_VariableValuesLock;Mutexdef data_Evaluator_VariableValuesLock;chan child) {
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

