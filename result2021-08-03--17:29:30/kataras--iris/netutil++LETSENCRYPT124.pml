// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kataras/iris/blob/fa175eb84754a45baecc4cd0044249fad05dfe1e/core/netutil/tcp.go#L124
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_LETSENCRYPT1240 = [1] of {int};
	run LETSENCRYPT124(child_LETSENCRYPT1240);
	run receiver(child_LETSENCRYPT1240)
stop_process:skip
}

proctype LETSENCRYPT124(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef tlsConfig_mutex;
	Mutexdef m_challengeMu;
	Mutexdef m_renewalMu;
	Mutexdef m_stateMu;
	Mutexdef m_client_noncesMu;
	Mutexdef m_client_cacheMu;
	Mutexdef m_clientMu;
	Mutexdef m_Client_noncesMu;
	Mutexdef m_Client_cacheMu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(m_Client_cacheMu);
	run mutexMonitor(m_Client_noncesMu);
	run mutexMonitor(m_clientMu);
	run mutexMonitor(m_client_cacheMu);
	run mutexMonitor(m_client_noncesMu);
	run mutexMonitor(m_stateMu);
	run mutexMonitor(m_renewalMu);
	run mutexMonitor(m_challengeMu);
	run mutexMonitor(tlsConfig_mutex);
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

