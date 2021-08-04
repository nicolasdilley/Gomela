// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/terraform/transform_import_state_test.go#L14
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGraphNodeImportStateExecute140 = [1] of {int};
	run TestGraphNodeImportStateExecute14(child_TestGraphNodeImportStateExecute140);
	run receiver(child_TestGraphNodeImportStateExecute140)
stop_process:skip
}

proctype TestGraphNodeImportStateExecute14(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Execute1190 = [1] of {int};
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
	run Execute119(ctx_ChangesChanges_lock,ctx_EvaluationScopeScope_funcsLock,ctx_InstanceExpanderExpander_mu,ctx_RefreshStateState_lock,ctx_StateState_lock,child_Execute1190);
	child_Execute1190?0;
	stop_process: skip;
	child!0
}
proctype Execute119(Mutexdef ctx_ChangesChanges_lock;Mutexdef ctx_EvaluationScopeScope_funcsLock;Mutexdef ctx_InstanceExpanderExpander_mu;Mutexdef ctx_RefreshStateState_lock;Mutexdef ctx_StateState_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getProvider490 = [1] of {int};
	int var_imported = -2; // opt var_imported
	run getProvider49(ctx_ChangesChanges_lock,ctx_EvaluationScopeScope_funcsLock,ctx_InstanceExpanderExpander_mu,ctx_RefreshStateState_lock,ctx_StateState_lock,child_getProvider490);
	child_getProvider490?0;
	

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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getProvider49(Mutexdef ctx_ChangesChanges_lock;Mutexdef ctx_EvaluationScopeScope_funcsLock;Mutexdef ctx_InstanceExpanderExpander_mu;Mutexdef ctx_RefreshStateState_lock;Mutexdef ctx_StateState_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

