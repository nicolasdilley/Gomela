
// https://github.com/valyala/fasthttp/blob/master/server_test.go#L358
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRequestCtxIsTLS3580 = [1] of {int};
	run TestRequestCtxIsTLS358(child_TestRequestCtxIsTLS3580)
stop_process:skip
}

proctype TestRequestCtxIsTLS358(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsTLS7032 = [1] of {int};
	chan child_IsTLS7031 = [1] of {int};
	chan child_IsTLS7030 = [1] of {int};
	Mutexdef ctx_s_mu;
	Mutexdef ctx_s_perIPConnCounter_lock;
	Mutexdef ctx_s_tlsConfig_mutex;
	run mutexMonitor(ctx_s_tlsConfig_mutex);
	run mutexMonitor(ctx_s_perIPConnCounter_lock);
	run mutexMonitor(ctx_s_mu);
	run IsTLS703(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_IsTLS7030);
	child_IsTLS7030?0;
	run IsTLS703(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_IsTLS7031);
	child_IsTLS7031?0;
	run IsTLS703(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_IsTLS7032);
	child_IsTLS7032?0;
	stop_process: skip;
	child!0
}
proctype IsTLS703(Mutexdef ctx_s_tlsConfig_mutex;Mutexdef ctx_s_perIPConnCounter_lock;Mutexdef ctx_s_mu;chan child) {
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

