
// https://github.com/valyala/fasthttp/blob/master/server_test.go#L1554
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRequestCtxFormValue15540 = [1] of {int};
	run TestRequestCtxFormValue1554(child_TestRequestCtxFormValue15540)
stop_process:skip
}

proctype TestRequestCtxFormValue1554(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_FormValue10193 = [1] of {int};
	chan child_FormValue10192 = [1] of {int};
	chan child_FormValue10191 = [1] of {int};
	chan child_Init25430 = [1] of {int};
	Mutexdef ctx_s_mu;
	Mutexdef ctx_s_perIPConnCounter_lock;
	Mutexdef ctx_s_tlsConfig_mutex;
	run mutexMonitor(ctx_s_tlsConfig_mutex);
	run mutexMonitor(ctx_s_perIPConnCounter_lock);
	run mutexMonitor(ctx_s_mu);
	run Init2543(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_Init25430);
	child_Init25430?0;
	run FormValue1019(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_FormValue10191);
	child_FormValue10191?0;
	run FormValue1019(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_FormValue10192);
	child_FormValue10192?0;
	run FormValue1019(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_FormValue10193);
	child_FormValue10193?0;
	stop_process: skip;
	child!0
}
proctype Init2543(Mutexdef ctx_s_tlsConfig_mutex;Mutexdef ctx_s_perIPConnCounter_lock;Mutexdef ctx_s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Init225250 = [1] of {int};
	run Init22525(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_Init225250);
	child_Init225250?0;
	stop_process: skip;
	child!0
}
proctype Init22525(Mutexdef ctx_s_tlsConfig_mutex;Mutexdef ctx_s_perIPConnCounter_lock;Mutexdef ctx_s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype FormValue1019(Mutexdef ctx_s_tlsConfig_mutex;Mutexdef ctx_s_perIPConnCounter_lock;Mutexdef ctx_s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MultipartForm9231 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run MultipartForm923(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_MultipartForm9231);
	child_MultipartForm9231?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype MultipartForm923(Mutexdef ctx_s_tlsConfig_mutex;Mutexdef ctx_s_perIPConnCounter_lock;Mutexdef ctx_s_mu;chan child) {
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

