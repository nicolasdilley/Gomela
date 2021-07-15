
// https://github.com/prometheus/prometheus/blob/master/web/api/v1/api_test.go#L233
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_RuleGroups2330 = [1] of {int};
	run RuleGroups233(child_RuleGroups2330)
stop_process:skip
}

proctype RuleGroups233(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef group_mtx;
	Mutexdef recordingRule_mtx;
	Mutexdef engine_queryLoggerLock;
	chan child_AlertingRules1970 = [1] of {int};
	Mutexdef ar_testing_context_mu;
	Mutexdef ar_testing_context_match_mu;
	run mutexMonitor(ar_testing_context_match_mu);
	run mutexMonitor(ar_testing_context_mu);
	run AlertingRules197(ar_testing_context_match_mu,ar_testing_context_mu,child_AlertingRules1970);
	child_AlertingRules1970?0;
	run mutexMonitor(engine_queryLoggerLock);
	run mutexMonitor(recordingRule_mtx);
	run mutexMonitor(group_mtx);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AlertingRules197(Mutexdef m_testing_context_match_mu;Mutexdef m_testing_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef rule2_mtx;
	Mutexdef rule1_mtx;
	run mutexMonitor(rule1_mtx);
	run mutexMonitor(rule2_mtx);
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

