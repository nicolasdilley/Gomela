// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/terraform/node_root_variable_test.go#L10
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNodeRootVariableExecute100 = [1] of {int};
	run TestNodeRootVariableExecute10(child_TestNodeRootVariableExecute100);
	run receiver(child_TestNodeRootVariableExecute100)
stop_process:skip
}

proctype TestNodeRootVariableExecute10(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Execute400 = [1] of {int};
	Mutexdef ctx_InstanceExpanderExpander_mu;
	Mutexdef ctx_RefreshStateState_lock;
	Mutexdef ctx_StateState_lock;
	Mutexdef ctx_ChangesChanges_lock;
	Mutexdef ctx_EvaluationScopeScope_funcsLock;
	run mutexMonitor(ctx_EvaluationScopeScope_funcsLock);
	run mutexMonitor(ctx_ChangesChanges_lock);
	run mutexMonitor(ctx_StateState_lock);
	run mutexMonitor(ctx_RefreshStateState_lock);
	run mutexMonitor(ctx_InstanceExpanderExpander_mu);
	run Execute40(ctx_ChangesChanges_lock,ctx_EvaluationScopeScope_funcsLock,ctx_InstanceExpanderExpander_mu,ctx_RefreshStateState_lock,ctx_StateState_lock,child_Execute400);
	child_Execute400?0;
	stop_process: skip;
	child!0
}
proctype Execute40(Mutexdef ctx_ChangesChanges_lock;Mutexdef ctx_EvaluationScopeScope_funcsLock;Mutexdef ctx_InstanceExpanderExpander_mu;Mutexdef ctx_RefreshStateState_lock;Mutexdef ctx_StateState_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_evalVariableValidations210 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run evalVariableValidations21(ctx_ChangesChanges_lock,ctx_EvaluationScopeScope_funcsLock,ctx_InstanceExpanderExpander_mu,ctx_RefreshStateState_lock,ctx_StateState_lock,child_evalVariableValidations210);
	child_evalVariableValidations210?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype evalVariableValidations21(Mutexdef ctx_ChangesChanges_lock;Mutexdef ctx_EvaluationScopeScope_funcsLock;Mutexdef ctx_InstanceExpanderExpander_mu;Mutexdef ctx_RefreshStateState_lock;Mutexdef ctx_StateState_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_config_Validations = -2; // opt var_config_Validations
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

