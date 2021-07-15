
// https://github.com/valyala/fasthttp/blob/master/server.go#L2434
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_acquireByteReader24340 = [1] of {int};
	run acquireByteReader2434(child_acquireByteReader24340)
stop_process:skip
}

proctype acquireByteReader2434(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_acquireReader18012 = [1] of {int};
	chan child_acquireCtx25031 = [1] of {int};
	chan child_releaseCtx26340 = [1] of {int};
	Mutexdef s_mu;
	Mutexdef s_perIPConnCounter_lock;
	Mutexdef s_tlsConfig_mutex;
	Mutexdef ctx_s_mu;
	Mutexdef ctx_s_perIPConnCounter_lock;
	Mutexdef ctx_s_tlsConfig_mutex;
	run mutexMonitor(ctx_s_tlsConfig_mutex);
	run mutexMonitor(ctx_s_perIPConnCounter_lock);
	run mutexMonitor(ctx_s_mu);
	run mutexMonitor(s_tlsConfig_mutex);
	run mutexMonitor(s_perIPConnCounter_lock);
	run mutexMonitor(s_mu);
	run releaseCtx2634(s_tlsConfig_mutex,s_perIPConnCounter_lock,s_mu,ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_releaseCtx26340);
	child_releaseCtx26340?0;
	run acquireCtx2503(s_tlsConfig_mutex,s_perIPConnCounter_lock,s_mu,child_acquireCtx25031);
	child_acquireCtx25031?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run acquireReader1801(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_acquireReader18012);
	child_acquireReader18012?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype releaseCtx2634(Mutexdef s_tlsConfig_mutex;Mutexdef s_perIPConnCounter_lock;Mutexdef s_mu;Mutexdef ctx_s_tlsConfig_mutex;Mutexdef ctx_s_perIPConnCounter_lock;Mutexdef ctx_s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype acquireCtx2503(Mutexdef s_tlsConfig_mutex;Mutexdef s_perIPConnCounter_lock;Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype acquireReader1801(Mutexdef conn_s_tlsConfig_mutex;Mutexdef conn_s_perIPConnCounter_lock;Mutexdef conn_s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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

