// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gravitational/teleport/blob//lib/backend/etcdbk/etcd_test.go#L165
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCompareAndSwapOversizedValue1650 = [1] of {int};
	run TestCompareAndSwapOversizedValue165(child_TestCompareAndSwapOversizedValue1650);
	run receiver(child_TestCompareAndSwapOversizedValue1650)
stop_process:skip
}

proctype TestCompareAndSwapOversizedValue165(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close2950 = [1] of {int};
	chan child_CompareAndSwap6021 = [1] of {int};
	Mutexdef bk_client_mu;
	Mutexdef bk_client_resolverGroup_mu;
	Mutexdef bk_client_cfg_TLS_mutex;
	Mutexdef bk_client_conn_balancerWrapper_mu;
	Mutexdef bk_client_conn_balancerWrapper_balancerMu;
	Mutexdef bk_client_conn_resolverWrapper_pollingMu;
	Mutexdef bk_client_conn_resolverWrapper_resolverMu;
	Mutexdef bk_client_conn_mu;
	Mutexdef bk_client_conn_blockingpicker_mu;
	Mutexdef bk_client_conn_csMgr_mu;
	run mutexMonitor(bk_client_conn_csMgr_mu);
	run mutexMonitor(bk_client_conn_blockingpicker_mu);
	run mutexMonitor(bk_client_conn_mu);
	run mutexMonitor(bk_client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(bk_client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(bk_client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(bk_client_conn_balancerWrapper_mu);
	run mutexMonitor(bk_client_cfg_TLS_mutex);
	run mutexMonitor(bk_client_resolverGroup_mu);
	run mutexMonitor(bk_client_mu);
	run CompareAndSwap602(bk_client_cfg_TLS_mutex,bk_client_conn_balancerWrapper_balancerMu,bk_client_conn_balancerWrapper_mu,bk_client_conn_blockingpicker_mu,bk_client_conn_csMgr_mu,bk_client_conn_mu,bk_client_conn_resolverWrapper_pollingMu,bk_client_conn_resolverWrapper_resolverMu,bk_client_mu,bk_client_resolverGroup_mu,child_CompareAndSwap6021);
	child_CompareAndSwap6021?0;
		defer1: skip;
	run Close295(bk_client_cfg_TLS_mutex,bk_client_conn_balancerWrapper_balancerMu,bk_client_conn_balancerWrapper_mu,bk_client_conn_blockingpicker_mu,bk_client_conn_csMgr_mu,bk_client_conn_mu,bk_client_conn_resolverWrapper_pollingMu,bk_client_conn_resolverWrapper_resolverMu,bk_client_mu,bk_client_resolverGroup_mu,child_Close2950);
	child_Close2950?0;
	stop_process: skip;
	child!0
}
proctype Close295(Mutexdef b_client_cfg_TLS_mutex;Mutexdef b_client_conn_balancerWrapper_balancerMu;Mutexdef b_client_conn_balancerWrapper_mu;Mutexdef b_client_conn_blockingpicker_mu;Mutexdef b_client_conn_csMgr_mu;Mutexdef b_client_conn_mu;Mutexdef b_client_conn_resolverWrapper_pollingMu;Mutexdef b_client_conn_resolverWrapper_resolverMu;Mutexdef b_client_mu;Mutexdef b_client_resolverGroup_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype CompareAndSwap602(Mutexdef b_client_cfg_TLS_mutex;Mutexdef b_client_conn_balancerWrapper_balancerMu;Mutexdef b_client_conn_balancerWrapper_mu;Mutexdef b_client_conn_blockingpicker_mu;Mutexdef b_client_conn_csMgr_mu;Mutexdef b_client_conn_mu;Mutexdef b_client_conn_resolverWrapper_pollingMu;Mutexdef b_client_conn_resolverWrapper_resolverMu;Mutexdef b_client_mu;Mutexdef b_client_resolverGroup_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_setupLease7441 = [1] of {int};
	

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
		run setupLease744(b_client_cfg_TLS_mutex,b_client_conn_balancerWrapper_balancerMu,b_client_conn_balancerWrapper_mu,b_client_conn_blockingpicker_mu,b_client_conn_csMgr_mu,b_client_conn_mu,b_client_conn_resolverWrapper_pollingMu,b_client_conn_resolverWrapper_resolverMu,b_client_mu,b_client_resolverGroup_mu,child_setupLease7441);
		child_setupLease7441?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
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
proctype setupLease744(Mutexdef b_client_cfg_TLS_mutex;Mutexdef b_client_conn_balancerWrapper_balancerMu;Mutexdef b_client_conn_balancerWrapper_mu;Mutexdef b_client_conn_blockingpicker_mu;Mutexdef b_client_conn_csMgr_mu;Mutexdef b_client_conn_mu;Mutexdef b_client_conn_resolverWrapper_pollingMu;Mutexdef b_client_conn_resolverWrapper_resolverMu;Mutexdef b_client_mu;Mutexdef b_client_resolverGroup_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ttl7561 = [1] of {int};
	run ttl756(b_client_cfg_TLS_mutex,b_client_conn_balancerWrapper_balancerMu,b_client_conn_balancerWrapper_mu,b_client_conn_blockingpicker_mu,b_client_conn_csMgr_mu,b_client_conn_mu,b_client_conn_resolverWrapper_pollingMu,b_client_conn_resolverWrapper_resolverMu,b_client_mu,b_client_resolverGroup_mu,child_ttl7561);
	child_ttl7561?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ttl756(Mutexdef b_client_cfg_TLS_mutex;Mutexdef b_client_conn_balancerWrapper_balancerMu;Mutexdef b_client_conn_balancerWrapper_mu;Mutexdef b_client_conn_blockingpicker_mu;Mutexdef b_client_conn_csMgr_mu;Mutexdef b_client_conn_mu;Mutexdef b_client_conn_resolverWrapper_pollingMu;Mutexdef b_client_conn_resolverWrapper_resolverMu;Mutexdef b_client_mu;Mutexdef b_client_resolverGroup_mu;chan child) {
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

