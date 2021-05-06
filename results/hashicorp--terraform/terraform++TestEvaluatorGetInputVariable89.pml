
// https://github.com/hashicorp/terraform/blob/master/terraform/evaluate_test.go#L89
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEvaluatorGetInputVariable890 = [1] of {int};
	run TestEvaluatorGetInputVariable89(child_TestEvaluatorGetInputVariable890)
stop_process:skip
}

proctype TestEvaluatorGetInputVariable89(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Scope710 = [1] of {int};
	Mutexdef scope_funcsLock;
	Mutexdef data_Evaluator_Changes_lock;
	Mutexdef data_Evaluator_State_lock;
	Mutexdef data_Evaluator_VariableValuesLock;
	Mutexdef evaluator_Changes_lock;
	Mutexdef evaluator_State_lock;
	Mutexdef evaluator_VariableValuesLock;
	run mutexMonitor(evaluator_VariableValuesLock);
	run mutexMonitor(evaluator_State_lock);
	run mutexMonitor(evaluator_Changes_lock);
	run mutexMonitor(data_Evaluator_VariableValuesLock);
	run mutexMonitor(data_Evaluator_State_lock);
	run mutexMonitor(data_Evaluator_Changes_lock);
	run mutexMonitor(scope_funcsLock);
	run Scope71(evaluator_VariableValuesLock,evaluator_State_lock,evaluator_Changes_lock,data_Evaluator_VariableValuesLock,data_Evaluator_State_lock,data_Evaluator_Changes_lock,child_Scope710);
	child_Scope710?0;
	stop_process: skip;
	child!0
}
proctype Scope71(Mutexdef e_VariableValuesLock;Mutexdef e_State_lock;Mutexdef e_Changes_lock;Mutexdef data_Evaluator_VariableValuesLock;Mutexdef data_Evaluator_State_lock;Mutexdef data_Evaluator_Changes_lock;chan child) {
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

