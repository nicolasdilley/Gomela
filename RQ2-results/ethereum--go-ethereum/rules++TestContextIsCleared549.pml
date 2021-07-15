
// https://github.com/ethereum/go-ethereum/blob/master/signer/rules/rules_test.go#L549
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextIsCleared5490 = [1] of {int};
	run TestContextIsCleared549(child_TestContextIsCleared5490)
stop_process:skip
}

proctype TestContextIsCleared549(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewRuleEvaluator560 = [1] of {int};
	Mutexdef ui_t_context_mu;
	Mutexdef ui_t_context_match_mu;
	run mutexMonitor(ui_t_context_match_mu);
	run mutexMonitor(ui_t_context_mu);
	run NewRuleEvaluator56(ui_t_context_match_mu,ui_t_context_mu,child_NewRuleEvaluator560);
	child_NewRuleEvaluator560?0;
	stop_process: skip;
	child!0
}
proctype NewRuleEvaluator56(Mutexdef next_t_context_match_mu;Mutexdef next_t_context_mu;chan child) {
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

