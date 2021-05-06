
// https://github.com/hashicorp/terraform/blob/master/terraform/evaluate_test.go#L461
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEvaluatorGetModule4610 = [1] of {int};
	run TestEvaluatorGetModule461(child_TestEvaluatorGetModule4610)
stop_process:skip
}

proctype TestEvaluatorGetModule461(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Scope715 = [1] of {int};
	chan child_evaluatorForModule5344 = [1] of {int};
	chan child_Scope713 = [1] of {int};
	chan child_evaluatorForModule5342 = [1] of {int};
	Mutexdef changesSync_lock;
	chan child_Scope711 = [1] of {int};
	Mutexdef scope_funcsLock;
	Mutexdef data_Evaluator_Changes_lock;
	Mutexdef data_Evaluator_State_lock;
	Mutexdef data_Evaluator_VariableValuesLock;
	chan child_evaluatorForModule5340 = [1] of {int};
	Mutexdef evaluator_Changes_lock;
	Mutexdef evaluator_State_lock;
	Mutexdef evaluator_VariableValuesLock;
	Mutexdef stateSync_lock;
	run mutexMonitor(stateSync_lock);
	run mutexMonitor(evaluator_VariableValuesLock);
	run mutexMonitor(evaluator_State_lock);
	run mutexMonitor(evaluator_Changes_lock);
	run evaluatorForModule534(stateSync_lock,child_evaluatorForModule5340);
	child_evaluatorForModule5340?0;
	run mutexMonitor(data_Evaluator_VariableValuesLock);
	run mutexMonitor(data_Evaluator_State_lock);
	run mutexMonitor(data_Evaluator_Changes_lock);
	run mutexMonitor(scope_funcsLock);
	run Scope71(evaluator_VariableValuesLock,evaluator_State_lock,evaluator_Changes_lock,data_Evaluator_VariableValuesLock,data_Evaluator_State_lock,data_Evaluator_Changes_lock,child_Scope711);
	child_Scope711?0;
	run mutexMonitor(changesSync_lock);
	run evaluatorForModule534(stateSync_lock,changesSync_lock,child_evaluatorForModule5342);
	child_evaluatorForModule5342?0;
	run Scope71(evaluator_VariableValuesLock,evaluator_State_lock,evaluator_Changes_lock,data_Evaluator_VariableValuesLock,data_Evaluator_State_lock,data_Evaluator_Changes_lock,child_Scope713);
	child_Scope713?0;
	run evaluatorForModule534(changesSync_lock,child_evaluatorForModule5344);
	child_evaluatorForModule5344?0;
	run Scope71(evaluator_VariableValuesLock,evaluator_State_lock,evaluator_Changes_lock,data_Evaluator_VariableValuesLock,data_Evaluator_State_lock,data_Evaluator_Changes_lock,child_Scope715);
	child_Scope715?0;
	stop_process: skip;
	child!0
}
proctype evaluatorForModule534(Mutexdef stateSync_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
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

