// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/dapr/dapr/blob/ab83d3535478699a2f2707d9ed9008f78c155d6d/pkg/grpc/grpc_test.go#L70
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSetAuthenticator700 = [1] of {int};
	run TestSetAuthenticator70(child_TestSetAuthenticator700);
	run receiver(child_TestSetAuthenticator700)
stop_process:skip
}

proctype TestSetAuthenticator70(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetAuthenticator510 = [1] of {int};
	Mutexdef m_lock;
	Mutexdef m_AppClient_lceMu;
	Mutexdef m_AppClient_mu;
	run mutexMonitor(m_AppClient_mu);
	run mutexMonitor(m_AppClient_lceMu);
	run mutexMonitor(m_lock);
	run SetAuthenticator51(m_AppClient_lceMu,m_AppClient_mu,m_lock,child_SetAuthenticator510);
	child_SetAuthenticator510?0;
	stop_process: skip;
	child!0
}
proctype SetAuthenticator51(Mutexdef g_AppClient_lceMu;Mutexdef g_AppClient_mu;Mutexdef g_lock;chan child) {
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

