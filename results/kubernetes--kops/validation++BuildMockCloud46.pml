
// https://github.com/kubernetes/kops/blob/master/pkg/validation/validate_cluster_test.go#L46
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_BuildMockCloud460 = [1] of {int};
	run BuildMockCloud46(child_BuildMockCloud460)
stop_process:skip
}

proctype BuildMockCloud46(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef m_t_context_mu;
	Mutexdef m_t_context_match_mu;
	run mutexMonitor(m_t_context_match_mu);
	run mutexMonitor(m_t_context_mu);
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

