
// https://github.com/k6io/k6/blob/master/js/tc39/tc39_test.go#L517
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTC395170 = [1] of {int};
	run TestTC39517(child_TestTC395170)
stop_process:skip
}

proctype TestTC39517(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_init4020 = [1] of {int};
	Mutexdef ctx_errorsLock;
	Mutexdef ctx_benchLock;
	Mutexdef ctx_prgCacheLock;
	Mutexdef ctx_t_context_mu;
	Mutexdef ctx_t_context_match_mu;
	run mutexMonitor(ctx_t_context_match_mu);
	run mutexMonitor(ctx_t_context_mu);
	run mutexMonitor(ctx_prgCacheLock);
	run mutexMonitor(ctx_benchLock);
	run mutexMonitor(ctx_errorsLock);
	run init402(ctx_t_context_match_mu,ctx_t_context_mu,ctx_prgCacheLock,ctx_benchLock,ctx_errorsLock,child_init4020);
	child_init4020?0;
	stop_process: skip;
	child!0
}
proctype init402(Mutexdef ctx_t_context_match_mu;Mutexdef ctx_t_context_mu;Mutexdef ctx_prgCacheLock;Mutexdef ctx_benchLock;Mutexdef ctx_errorsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

