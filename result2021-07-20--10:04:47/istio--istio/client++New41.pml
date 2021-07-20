// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pkg/test/echo/client/client.go#L41
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_New410 = [1] of {int};
	run New41(child_New410);
	run receiver(child_New410)
stop_process:skip
}

proctype New41(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewEchoTestServiceClient5030 = [1] of {int};
	Mutexdef conn_lceMu;
	Mutexdef conn_balancerWrapper_mu;
	Mutexdef conn_balancerWrapper_balancerMu;
	Mutexdef conn_resolverWrapper_pollingMu;
	Mutexdef conn_resolverWrapper_resolverMu;
	Mutexdef conn_mu;
	Mutexdef conn_safeConfigSelector_mu;
	Mutexdef conn_blockingpicker_mu;
	Mutexdef conn_csMgr_mu;
	

	if
	:: true -> 
		

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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	fi;
	run mutexMonitor(conn_csMgr_mu);
	run mutexMonitor(conn_blockingpicker_mu);
	run mutexMonitor(conn_safeConfigSelector_mu);
	run mutexMonitor(conn_mu);
	run mutexMonitor(conn_resolverWrapper_resolverMu);
	run mutexMonitor(conn_resolverWrapper_pollingMu);
	run mutexMonitor(conn_balancerWrapper_balancerMu);
	run mutexMonitor(conn_balancerWrapper_mu);
	run mutexMonitor(conn_lceMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run NewEchoTestServiceClient503(conn_balancerWrapper_balancerMu,conn_balancerWrapper_mu,conn_blockingpicker_mu,conn_csMgr_mu,conn_lceMu,conn_mu,conn_resolverWrapper_pollingMu,conn_resolverWrapper_resolverMu,conn_safeConfigSelector_mu,child_NewEchoTestServiceClient5030);
	child_NewEchoTestServiceClient5030?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewEchoTestServiceClient503(Mutexdef cc_balancerWrapper_balancerMu;Mutexdef cc_balancerWrapper_mu;Mutexdef cc_blockingpicker_mu;Mutexdef cc_csMgr_mu;Mutexdef cc_lceMu;Mutexdef cc_mu;Mutexdef cc_resolverWrapper_pollingMu;Mutexdef cc_resolverWrapper_resolverMu;Mutexdef cc_safeConfigSelector_mu;chan child) {
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

