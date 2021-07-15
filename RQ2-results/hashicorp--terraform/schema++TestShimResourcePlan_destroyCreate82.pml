
// https://github.com/hashicorp/terraform/blob/master/internal/legacy/helper/schema/shims_test.go#L82
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestShimResourcePlan_destroyCreate820 = [1] of {int};
	run TestShimResourcePlan_destroyCreate82(child_TestShimResourcePlan_destroyCreate820)
stop_process:skip
}

proctype TestShimResourcePlan_destroyCreate82(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_testApplyDiff290 = [1] of {int};
	Mutexdef expected_mu;
	Mutexdef state_mu;
	Mutexdef d_mu;
	run mutexMonitor(d_mu);
	run mutexMonitor(state_mu);
	run mutexMonitor(expected_mu);
	run testApplyDiff29(state_mu,state_mu,expected_mu,child_testApplyDiff290);
	child_testApplyDiff290?0;
	stop_process: skip;
	child!0
}
proctype testApplyDiff29(Mutexdef state_mu;Mutexdef expected_mu;Mutexdef diff_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StateValueFromInstanceState1132 = [1] of {int};
	chan child_ApplyDiff721 = [1] of {int};
	chan child_StateValueFromInstanceState1130 = [1] of {int};
	run StateValueFromInstanceState113(state_mu,child_StateValueFromInstanceState1130);
	child_StateValueFromInstanceState1130?0;
	run ApplyDiff72(diff_mu,child_ApplyDiff721);
	child_ApplyDiff721?0;
	

	if
	:: true;
	:: true;
	fi;
	run StateValueFromInstanceState113(expected_mu,child_StateValueFromInstanceState1132);
	child_StateValueFromInstanceState1132?0;
	stop_process: skip;
	child!0
}
proctype StateValueFromInstanceState113(Mutexdef is_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ApplyDiff72(Mutexdef d_mu;chan child) {
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

