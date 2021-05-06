
// https://github.com/hashicorp/terraform/blob/master/terraform/eval_context_builtin_test.go#L13
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBuiltinEvalContextProviderInput130 = [1] of {int};
	run TestBuiltinEvalContextProviderInput13(child_TestBuiltinEvalContextProviderInput130)
stop_process:skip
}

proctype TestBuiltinEvalContextProviderInput13(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ProviderInput1995 = [1] of {int};
	chan child_ProviderInput1994 = [1] of {int};
	chan child_SetProviderInput2173 = [1] of {int};
	chan child_SetProviderInput2172 = [1] of {int};
	chan child_WithPath811 = [1] of {int};
	Mutexdef ctx2_InstanceExpanderValue_mu;
	Mutexdef ctx2_RefreshStateValue_lock;
	Mutexdef ctx2_StateValue_lock;
	Mutexdef ctx2_ChangesValue_lock;
	Mutexdef ctx2_ProvisionerLock;
	Mutexdef ctx2_ProviderLock;
	Mutexdef ctx2_VariableValuesLock;
	Mutexdef ctx2_Evaluator_Changes_lock;
	Mutexdef ctx2_Evaluator_State_lock;
	Mutexdef ctx2_Evaluator_VariableValuesLock;
	chan child_WithPath810 = [1] of {int};
	Mutexdef ctx1_InstanceExpanderValue_mu;
	Mutexdef ctx1_RefreshStateValue_lock;
	Mutexdef ctx1_StateValue_lock;
	Mutexdef ctx1_ChangesValue_lock;
	Mutexdef ctx1_ProvisionerLock;
	Mutexdef ctx1_ProviderLock;
	Mutexdef ctx1_VariableValuesLock;
	Mutexdef ctx1_Evaluator_Changes_lock;
	Mutexdef ctx1_Evaluator_State_lock;
	Mutexdef ctx1_Evaluator_VariableValuesLock;
	Mutexdef lock;
	run mutexMonitor(lock);
	run mutexMonitor(ctx1_Evaluator_VariableValuesLock);
	run mutexMonitor(ctx1_Evaluator_State_lock);
	run mutexMonitor(ctx1_Evaluator_Changes_lock);
	run mutexMonitor(ctx1_VariableValuesLock);
	run mutexMonitor(ctx1_ProviderLock);
	run mutexMonitor(ctx1_ProvisionerLock);
	run mutexMonitor(ctx1_ChangesValue_lock);
	run mutexMonitor(ctx1_StateValue_lock);
	run mutexMonitor(ctx1_RefreshStateValue_lock);
	run mutexMonitor(ctx1_InstanceExpanderValue_mu);
	run WithPath81(ctx1_Evaluator_VariableValuesLock,ctx1_Evaluator_State_lock,ctx1_Evaluator_Changes_lock,ctx1_VariableValuesLock,ctx1_ProviderLock,ctx1_ProvisionerLock,ctx1_ChangesValue_lock,ctx1_StateValue_lock,ctx1_RefreshStateValue_lock,ctx1_InstanceExpanderValue_mu,child_WithPath810);
	child_WithPath810?0;
	run mutexMonitor(ctx2_Evaluator_VariableValuesLock);
	run mutexMonitor(ctx2_Evaluator_State_lock);
	run mutexMonitor(ctx2_Evaluator_Changes_lock);
	run mutexMonitor(ctx2_VariableValuesLock);
	run mutexMonitor(ctx2_ProviderLock);
	run mutexMonitor(ctx2_ProvisionerLock);
	run mutexMonitor(ctx2_ChangesValue_lock);
	run mutexMonitor(ctx2_StateValue_lock);
	run mutexMonitor(ctx2_RefreshStateValue_lock);
	run mutexMonitor(ctx2_InstanceExpanderValue_mu);
	run WithPath81(ctx2_Evaluator_VariableValuesLock,ctx2_Evaluator_State_lock,ctx2_Evaluator_Changes_lock,ctx2_VariableValuesLock,ctx2_ProviderLock,ctx2_ProvisionerLock,ctx2_ChangesValue_lock,ctx2_StateValue_lock,ctx2_RefreshStateValue_lock,ctx2_InstanceExpanderValue_mu,child_WithPath811);
	child_WithPath811?0;
	run SetProviderInput217(ctx1_Evaluator_VariableValuesLock,ctx1_Evaluator_State_lock,ctx1_Evaluator_Changes_lock,ctx1_VariableValuesLock,ctx1_ProviderLock,ctx1_ProvisionerLock,ctx1_ChangesValue_lock,ctx1_StateValue_lock,ctx1_RefreshStateValue_lock,ctx1_InstanceExpanderValue_mu,child_SetProviderInput2172);
	child_SetProviderInput2172?0;
	run SetProviderInput217(ctx2_Evaluator_VariableValuesLock,ctx2_Evaluator_State_lock,ctx2_Evaluator_Changes_lock,ctx2_VariableValuesLock,ctx2_ProviderLock,ctx2_ProvisionerLock,ctx2_ChangesValue_lock,ctx2_StateValue_lock,ctx2_RefreshStateValue_lock,ctx2_InstanceExpanderValue_mu,child_SetProviderInput2173);
	child_SetProviderInput2173?0;
	run ProviderInput199(ctx1_Evaluator_VariableValuesLock,ctx1_Evaluator_State_lock,ctx1_Evaluator_Changes_lock,ctx1_VariableValuesLock,ctx1_ProviderLock,ctx1_ProvisionerLock,ctx1_ChangesValue_lock,ctx1_StateValue_lock,ctx1_RefreshStateValue_lock,ctx1_InstanceExpanderValue_mu,child_ProviderInput1994);
	child_ProviderInput1994?0;
	run ProviderInput199(ctx2_Evaluator_VariableValuesLock,ctx2_Evaluator_State_lock,ctx2_Evaluator_Changes_lock,ctx2_VariableValuesLock,ctx2_ProviderLock,ctx2_ProvisionerLock,ctx2_ChangesValue_lock,ctx2_StateValue_lock,ctx2_RefreshStateValue_lock,ctx2_InstanceExpanderValue_mu,child_ProviderInput1995);
	child_ProviderInput1995?0;
	stop_process: skip;
	child!0
}
proctype WithPath81(Mutexdef ctx_Evaluator_VariableValuesLock;Mutexdef ctx_Evaluator_State_lock;Mutexdef ctx_Evaluator_Changes_lock;Mutexdef ctx_VariableValuesLock;Mutexdef ctx_ProviderLock;Mutexdef ctx_ProvisionerLock;Mutexdef ctx_ChangesValue_lock;Mutexdef ctx_StateValue_lock;Mutexdef ctx_RefreshStateValue_lock;Mutexdef ctx_InstanceExpanderValue_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef newCtx_InstanceExpanderValue_mu;
	Mutexdef newCtx_RefreshStateValue_lock;
	Mutexdef newCtx_StateValue_lock;
	Mutexdef newCtx_ChangesValue_lock;
	Mutexdef newCtx_ProvisionerLock;
	Mutexdef newCtx_ProviderLock;
	Mutexdef newCtx_VariableValuesLock;
	Mutexdef newCtx_Evaluator_Changes_lock;
	Mutexdef newCtx_Evaluator_State_lock;
	Mutexdef newCtx_Evaluator_VariableValuesLock;
	run mutexMonitor(newCtx_Evaluator_VariableValuesLock);
	run mutexMonitor(newCtx_Evaluator_State_lock);
	run mutexMonitor(newCtx_Evaluator_Changes_lock);
	run mutexMonitor(newCtx_VariableValuesLock);
	run mutexMonitor(newCtx_ProviderLock);
	run mutexMonitor(newCtx_ProvisionerLock);
	run mutexMonitor(newCtx_ChangesValue_lock);
	run mutexMonitor(newCtx_StateValue_lock);
	run mutexMonitor(newCtx_RefreshStateValue_lock);
	run mutexMonitor(newCtx_InstanceExpanderValue_mu);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SetProviderInput217(Mutexdef ctx_Evaluator_VariableValuesLock;Mutexdef ctx_Evaluator_State_lock;Mutexdef ctx_Evaluator_Changes_lock;Mutexdef ctx_VariableValuesLock;Mutexdef ctx_ProviderLock;Mutexdef ctx_ProvisionerLock;Mutexdef ctx_ChangesValue_lock;Mutexdef ctx_StateValue_lock;Mutexdef ctx_RefreshStateValue_lock;Mutexdef ctx_InstanceExpanderValue_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	ctx_ProviderLock.Lock!false;
	ctx_ProviderLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype ProviderInput199(Mutexdef ctx_Evaluator_VariableValuesLock;Mutexdef ctx_Evaluator_State_lock;Mutexdef ctx_Evaluator_Changes_lock;Mutexdef ctx_VariableValuesLock;Mutexdef ctx_ProviderLock;Mutexdef ctx_ProvisionerLock;Mutexdef ctx_ChangesValue_lock;Mutexdef ctx_StateValue_lock;Mutexdef ctx_RefreshStateValue_lock;Mutexdef ctx_InstanceExpanderValue_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Path3084 = [1] of {int};
	ctx_ProviderLock.Lock!false;
	

	if
	:: true -> 
		run Path308(ctx_Evaluator_VariableValuesLock,ctx_Evaluator_State_lock,ctx_Evaluator_Changes_lock,ctx_VariableValuesLock,ctx_ProviderLock,ctx_ProvisionerLock,ctx_ChangesValue_lock,ctx_StateValue_lock,ctx_RefreshStateValue_lock,ctx_InstanceExpanderValue_mu,child_Path3084);
		child_Path3084?0
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		ctx_ProviderLock.Unlock!false;
	child!0
}
proctype Path308(Mutexdef ctx_Evaluator_VariableValuesLock;Mutexdef ctx_Evaluator_State_lock;Mutexdef ctx_Evaluator_Changes_lock;Mutexdef ctx_VariableValuesLock;Mutexdef ctx_ProviderLock;Mutexdef ctx_ProvisionerLock;Mutexdef ctx_ChangesValue_lock;Mutexdef ctx_StateValue_lock;Mutexdef ctx_RefreshStateValue_lock;Mutexdef ctx_InstanceExpanderValue_mu;chan child) {
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

