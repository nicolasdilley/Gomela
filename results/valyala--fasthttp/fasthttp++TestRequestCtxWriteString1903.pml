// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/valyala/fasthttp/blob//server_test.go#L1903
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRequestCtxWriteString19030 = [1] of {int};
	run TestRequestCtxWriteString1903(child_TestRequestCtxWriteString19030);
	run receiver(child_TestRequestCtxWriteString19030)
stop_process:skip
}

proctype TestRequestCtxWriteString1903(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WriteString13081 = [1] of {int};
	chan child_WriteString13080 = [1] of {int};
	Mutexdef ctx_s_mu;
	Mutexdef ctx_s_perIPConnCounter_lock;
	Mutexdef ctx_s_tlsConfig_mutex;
	run mutexMonitor(ctx_s_tlsConfig_mutex);
	run mutexMonitor(ctx_s_perIPConnCounter_lock);
	run mutexMonitor(ctx_s_mu);
	run WriteString1308(ctx_s_mu,ctx_s_perIPConnCounter_lock,ctx_s_tlsConfig_mutex,child_WriteString13080);
	child_WriteString13080?0;
	run WriteString1308(ctx_s_mu,ctx_s_perIPConnCounter_lock,ctx_s_tlsConfig_mutex,child_WriteString13081);
	child_WriteString13081?0;
	stop_process: skip;
	child!0
}
proctype WriteString1308(Mutexdef ctx_s_mu;Mutexdef ctx_s_perIPConnCounter_lock;Mutexdef ctx_s_tlsConfig_mutex;chan child) {
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

proctype receiver(chan c) {
c?0
}

