
// https://github.com/moby/moby/blob/master/pkg/authorization/middleware_test.go#L13
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMiddleware130 = [1] of {int};
	run TestMiddleware13(child_TestMiddleware130)
stop_process:skip
}

proctype TestMiddleware13(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getAuthzPlugins280 = [1] of {int};
	Mutexdef m_mu;
	run mutexMonitor(m_mu);
	run getAuthzPlugins28(m_mu,child_getAuthzPlugins280);
	child_getAuthzPlugins280?0;
	stop_process: skip;
	child!0
}
proctype getAuthzPlugins28(Mutexdef m_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	m_mu.Lock!false;
	goto stop_process;
	stop_process: skip;
		m_mu.Unlock!false;
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

