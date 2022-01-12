// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grafana/k6/blob//js/tc39/tc39_test.go#L542
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTC395420 = [1] of {int};
	run TestTC39542(child_TestTC395420);
	run receiver(child_TestTC395420)
stop_process:skip
}

proctype TestTC39542(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_init4070 = [1] of {int};
	Mutexdef ctx_errorsLock;
	Mutexdef ctx_benchLock;
	Mutexdef ctx_prgCacheLock;
	Mutexdef ctx_t_context_mu;
	Mutexdef ctx_t_context_match_mu;
	int var_bench = -2; // opt var_bench
	run mutexMonitor(ctx_t_context_match_mu);
	run mutexMonitor(ctx_t_context_mu);
	run mutexMonitor(ctx_prgCacheLock);
	run mutexMonitor(ctx_benchLock);
	run mutexMonitor(ctx_errorsLock);
	run init407(ctx_benchLock,ctx_errorsLock,ctx_prgCacheLock,ctx_t_context_match_mu,ctx_t_context_mu,child_init4070);
	child_init4070?0;
	stop_process: skip;
	child!0
}
proctype init407(Mutexdef ctx_benchLock;Mutexdef ctx_errorsLock;Mutexdef ctx_prgCacheLock;Mutexdef ctx_t_context_match_mu;Mutexdef ctx_t_context_mu;chan child) {
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

proctype receiver(chan c) {
c?0
}

