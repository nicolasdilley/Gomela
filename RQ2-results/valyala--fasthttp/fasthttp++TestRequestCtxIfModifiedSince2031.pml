
// https://github.com/valyala/fasthttp/blob/master/server_test.go#L2031
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRequestCtxIfModifiedSince20310 = [1] of {int};
	run TestRequestCtxIfModifiedSince2031(child_TestRequestCtxIfModifiedSince20310)
stop_process:skip
}

proctype TestRequestCtxIfModifiedSince2031(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IfModifiedSince12754 = [1] of {int};
	chan child_IfModifiedSince12753 = [1] of {int};
	chan child_IfModifiedSince12752 = [1] of {int};
	chan child_IfModifiedSince12751 = [1] of {int};
	chan child_Init25430 = [1] of {int};
	Mutexdef ctx_s_mu;
	Mutexdef ctx_s_perIPConnCounter_lock;
	Mutexdef ctx_s_tlsConfig_mutex;
	run mutexMonitor(ctx_s_tlsConfig_mutex);
	run mutexMonitor(ctx_s_perIPConnCounter_lock);
	run mutexMonitor(ctx_s_mu);
	run Init2543(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_Init25430);
	child_Init25430?0;
	run IfModifiedSince1275(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_IfModifiedSince12751);
	child_IfModifiedSince12751?0;
	run IfModifiedSince1275(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_IfModifiedSince12752);
	child_IfModifiedSince12752?0;
	run IfModifiedSince1275(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_IfModifiedSince12753);
	child_IfModifiedSince12753?0;
	run IfModifiedSince1275(ctx_s_tlsConfig_mutex,ctx_s_perIPConnCounter_lock,ctx_s_mu,child_IfModifiedSince12754);
	child_IfModifiedSince12754?0;
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
proctype IfModifiedSince1275(Mutexdef ctx_s_tlsConfig_mutex;Mutexdef ctx_s_perIPConnCounter_lock;Mutexdef ctx_s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

