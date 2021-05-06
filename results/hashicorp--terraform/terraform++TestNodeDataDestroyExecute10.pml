
// https://github.com/hashicorp/terraform/blob/master/terraform/node_data_destroy_test.go#L10
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNodeDataDestroyExecute100 = [1] of {int};
	run TestNodeDataDestroyExecute10(child_TestNodeDataDestroyExecute100)
stop_process:skip
}

proctype TestNodeDataDestroyExecute10(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Execute200 = [1] of {int};
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
	run Execute20(ctx_EvaluationScopeScope_funcsLock,ctx_ChangesChanges_lock,ctx_StateState_lock,ctx_RefreshStateState_lock,ctx_InstanceExpanderExpander_mu,child_Execute200);
	child_Execute200?0;
	stop_process: skip;
	child!0
}
proctype Execute20(Mutexdef ctx_EvaluationScopeScope_funcsLock;Mutexdef ctx_ChangesChanges_lock;Mutexdef ctx_StateState_lock;Mutexdef ctx_RefreshStateState_lock;Mutexdef ctx_InstanceExpanderExpander_mu;chan child) {
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

