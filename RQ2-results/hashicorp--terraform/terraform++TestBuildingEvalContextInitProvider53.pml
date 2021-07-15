
// https://github.com/hashicorp/terraform/blob/master/terraform/eval_context_builtin_test.go#L53
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBuildingEvalContextInitProvider530 = [1] of {int};
	run TestBuildingEvalContextInitProvider53(child_TestBuildingEvalContextInitProvider530)
stop_process:skip
}

proctype TestBuildingEvalContextInitProvider53(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_InitProvider1212 = [1] of {int};
	chan child_InitProvider1211 = [1] of {int};
	chan child_WithPath810 = [1] of {int};
	Mutexdef ctx_InstanceExpanderValue_mu;
	Mutexdef ctx_RefreshStateValue_lock;
	Mutexdef ctx_StateValue_lock;
	Mutexdef ctx_ChangesValue_lock;
	Mutexdef ctx_ProvisionerLock;
	Mutexdef ctx_ProviderLock;
	Mutexdef ctx_VariableValuesLock;
	Mutexdef ctx_Evaluator_Changes_lock;
	Mutexdef ctx_Evaluator_State_lock;
	Mutexdef ctx_Evaluator_VariableValuesLock;
	Mutexdef lock;
	run mutexMonitor(lock);
	run mutexMonitor(ctx_Evaluator_VariableValuesLock);
	run mutexMonitor(ctx_Evaluator_State_lock);
	run mutexMonitor(ctx_Evaluator_Changes_lock);
	run mutexMonitor(ctx_VariableValuesLock);
	run mutexMonitor(ctx_ProviderLock);
	run mutexMonitor(ctx_ProvisionerLock);
	run mutexMonitor(ctx_ChangesValue_lock);
	run mutexMonitor(ctx_StateValue_lock);
	run mutexMonitor(ctx_RefreshStateValue_lock);
	run mutexMonitor(ctx_InstanceExpanderValue_mu);
	run WithPath81(ctx_Evaluator_VariableValuesLock,ctx_Evaluator_State_lock,ctx_Evaluator_Changes_lock,ctx_VariableValuesLock,ctx_ProviderLock,ctx_ProvisionerLock,ctx_ChangesValue_lock,ctx_StateValue_lock,ctx_RefreshStateValue_lock,ctx_InstanceExpanderValue_mu,child_WithPath810);
	child_WithPath810?0;
	run InitProvider121(ctx_Evaluator_VariableValuesLock,ctx_Evaluator_State_lock,ctx_Evaluator_Changes_lock,ctx_VariableValuesLock,ctx_ProviderLock,ctx_ProvisionerLock,ctx_ChangesValue_lock,ctx_StateValue_lock,ctx_RefreshStateValue_lock,ctx_InstanceExpanderValue_mu,child_InitProvider1211);
	child_InitProvider1211?0;
	run InitProvider121(ctx_Evaluator_VariableValuesLock,ctx_Evaluator_State_lock,ctx_Evaluator_Changes_lock,ctx_VariableValuesLock,ctx_ProviderLock,ctx_ProvisionerLock,ctx_ChangesValue_lock,ctx_StateValue_lock,ctx_RefreshStateValue_lock,ctx_InstanceExpanderValue_mu,child_InitProvider1212);
	child_InitProvider1212?0;
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
proctype InitProvider121(Mutexdef ctx_Evaluator_VariableValuesLock;Mutexdef ctx_Evaluator_State_lock;Mutexdef ctx_Evaluator_Changes_lock;Mutexdef ctx_VariableValuesLock;Mutexdef ctx_ProviderLock;Mutexdef ctx_ProvisionerLock;Mutexdef ctx_ChangesValue_lock;Mutexdef ctx_StateValue_lock;Mutexdef ctx_RefreshStateValue_lock;Mutexdef ctx_InstanceExpanderValue_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Provider1451 = [1] of {int};
	run Provider145(ctx_Evaluator_VariableValuesLock,ctx_Evaluator_State_lock,ctx_Evaluator_Changes_lock,ctx_VariableValuesLock,ctx_ProviderLock,ctx_ProvisionerLock,ctx_ChangesValue_lock,ctx_StateValue_lock,ctx_RefreshStateValue_lock,ctx_InstanceExpanderValue_mu,child_Provider1451);
	child_Provider1451?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	ctx_ProviderLock.Lock!false;
	

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
proctype Provider145(Mutexdef ctx_Evaluator_VariableValuesLock;Mutexdef ctx_Evaluator_State_lock;Mutexdef ctx_Evaluator_Changes_lock;Mutexdef ctx_VariableValuesLock;Mutexdef ctx_ProviderLock;Mutexdef ctx_ProvisionerLock;Mutexdef ctx_ChangesValue_lock;Mutexdef ctx_StateValue_lock;Mutexdef ctx_RefreshStateValue_lock;Mutexdef ctx_InstanceExpanderValue_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ctx_ProviderLock.Lock!false;
	goto stop_process;
	stop_process: skip;
		ctx_ProviderLock.Unlock!false;
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

