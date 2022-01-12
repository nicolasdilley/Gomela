// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gravitational/teleport/blob//lib/backend/etcdbk/etcd_test.go#L88
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPrefix880 = [1] of {int};
	run TestPrefix88(child_TestPrefix880);
	run receiver(child_TestPrefix880)
stop_process:skip
}

proctype TestPrefix88(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close2950 = [1] of {int};
	chan child_Close2951 = [1] of {int};
	chan child_Get6937 = [1] of {int};
	chan child_requireKV1486 = [1] of {int};
	chan child_Put6435 = [1] of {int};
	chan child_Get6934 = [1] of {int};
	chan child_requireKV1483 = [1] of {int};
	chan child_Put6432 = [1] of {int};
	Mutexdef prefixedUut_client_mu;
	Mutexdef prefixedUut_client_resolverGroup_mu;
	Mutexdef prefixedUut_client_cfg_TLS_mutex;
	Mutexdef prefixedUut_client_conn_balancerWrapper_mu;
	Mutexdef prefixedUut_client_conn_balancerWrapper_balancerMu;
	Mutexdef prefixedUut_client_conn_resolverWrapper_pollingMu;
	Mutexdef prefixedUut_client_conn_resolverWrapper_resolverMu;
	Mutexdef prefixedUut_client_conn_mu;
	Mutexdef prefixedUut_client_conn_blockingpicker_mu;
	Mutexdef prefixedUut_client_conn_csMgr_mu;
	Mutexdef unprefixedUut_client_mu;
	Mutexdef unprefixedUut_client_resolverGroup_mu;
	Mutexdef unprefixedUut_client_cfg_TLS_mutex;
	Mutexdef unprefixedUut_client_conn_balancerWrapper_mu;
	Mutexdef unprefixedUut_client_conn_balancerWrapper_balancerMu;
	Mutexdef unprefixedUut_client_conn_resolverWrapper_pollingMu;
	Mutexdef unprefixedUut_client_conn_resolverWrapper_resolverMu;
	Mutexdef unprefixedUut_client_conn_mu;
	Mutexdef unprefixedUut_client_conn_blockingpicker_mu;
	Mutexdef unprefixedUut_client_conn_csMgr_mu;
	int var_commonEtcdParams = -2; // opt var_commonEtcdParams
	run mutexMonitor(unprefixedUut_client_conn_csMgr_mu);
	run mutexMonitor(unprefixedUut_client_conn_blockingpicker_mu);
	run mutexMonitor(unprefixedUut_client_conn_mu);
	run mutexMonitor(unprefixedUut_client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(unprefixedUut_client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(unprefixedUut_client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(unprefixedUut_client_conn_balancerWrapper_mu);
	run mutexMonitor(unprefixedUut_client_cfg_TLS_mutex);
	run mutexMonitor(unprefixedUut_client_resolverGroup_mu);
	run mutexMonitor(unprefixedUut_client_mu);
	run mutexMonitor(prefixedUut_client_conn_csMgr_mu);
	run mutexMonitor(prefixedUut_client_conn_blockingpicker_mu);
	run mutexMonitor(prefixedUut_client_conn_mu);
	run mutexMonitor(prefixedUut_client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(prefixedUut_client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(prefixedUut_client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(prefixedUut_client_conn_balancerWrapper_mu);
	run mutexMonitor(prefixedUut_client_cfg_TLS_mutex);
	run mutexMonitor(prefixedUut_client_resolverGroup_mu);
	run mutexMonitor(prefixedUut_client_mu);
	run Put643(prefixedUut_client_cfg_TLS_mutex,prefixedUut_client_conn_balancerWrapper_balancerMu,prefixedUut_client_conn_balancerWrapper_mu,prefixedUut_client_conn_blockingpicker_mu,prefixedUut_client_conn_csMgr_mu,prefixedUut_client_conn_mu,prefixedUut_client_conn_resolverWrapper_pollingMu,prefixedUut_client_conn_resolverWrapper_resolverMu,prefixedUut_client_mu,prefixedUut_client_resolverGroup_mu,child_Put6432);
	child_Put6432?0;
	run requireKV148(unprefixedUut_client_cfg_TLS_mutex,unprefixedUut_client_conn_balancerWrapper_balancerMu,unprefixedUut_client_conn_balancerWrapper_mu,unprefixedUut_client_conn_blockingpicker_mu,unprefixedUut_client_conn_csMgr_mu,unprefixedUut_client_conn_mu,unprefixedUut_client_conn_resolverWrapper_pollingMu,unprefixedUut_client_conn_resolverWrapper_resolverMu,unprefixedUut_client_mu,unprefixedUut_client_resolverGroup_mu,child_requireKV1483);
	child_requireKV1483?0;
	run Get693(prefixedUut_client_cfg_TLS_mutex,prefixedUut_client_conn_balancerWrapper_balancerMu,prefixedUut_client_conn_balancerWrapper_mu,prefixedUut_client_conn_blockingpicker_mu,prefixedUut_client_conn_csMgr_mu,prefixedUut_client_conn_mu,prefixedUut_client_conn_resolverWrapper_pollingMu,prefixedUut_client_conn_resolverWrapper_resolverMu,prefixedUut_client_mu,prefixedUut_client_resolverGroup_mu,child_Get6934);
	child_Get6934?0;
	run Put643(prefixedUut_client_cfg_TLS_mutex,prefixedUut_client_conn_balancerWrapper_balancerMu,prefixedUut_client_conn_balancerWrapper_mu,prefixedUut_client_conn_blockingpicker_mu,prefixedUut_client_conn_csMgr_mu,prefixedUut_client_conn_mu,prefixedUut_client_conn_resolverWrapper_pollingMu,prefixedUut_client_conn_resolverWrapper_resolverMu,prefixedUut_client_mu,prefixedUut_client_resolverGroup_mu,child_Put6435);
	child_Put6435?0;
	run requireKV148(unprefixedUut_client_cfg_TLS_mutex,unprefixedUut_client_conn_balancerWrapper_balancerMu,unprefixedUut_client_conn_balancerWrapper_mu,unprefixedUut_client_conn_blockingpicker_mu,unprefixedUut_client_conn_csMgr_mu,unprefixedUut_client_conn_mu,unprefixedUut_client_conn_resolverWrapper_pollingMu,unprefixedUut_client_conn_resolverWrapper_resolverMu,unprefixedUut_client_mu,unprefixedUut_client_resolverGroup_mu,child_requireKV1486);
	child_requireKV1486?0;
	run Get693(prefixedUut_client_cfg_TLS_mutex,prefixedUut_client_conn_balancerWrapper_balancerMu,prefixedUut_client_conn_balancerWrapper_mu,prefixedUut_client_conn_blockingpicker_mu,prefixedUut_client_conn_csMgr_mu,prefixedUut_client_conn_mu,prefixedUut_client_conn_resolverWrapper_pollingMu,prefixedUut_client_conn_resolverWrapper_resolverMu,prefixedUut_client_mu,prefixedUut_client_resolverGroup_mu,child_Get6937);
	child_Get6937?0;
		defer2: skip;
	run Close295(prefixedUut_client_cfg_TLS_mutex,prefixedUut_client_conn_balancerWrapper_balancerMu,prefixedUut_client_conn_balancerWrapper_mu,prefixedUut_client_conn_blockingpicker_mu,prefixedUut_client_conn_csMgr_mu,prefixedUut_client_conn_mu,prefixedUut_client_conn_resolverWrapper_pollingMu,prefixedUut_client_conn_resolverWrapper_resolverMu,prefixedUut_client_mu,prefixedUut_client_resolverGroup_mu,child_Close2951);
	child_Close2951?0;
		defer1: skip;
	run Close295(unprefixedUut_client_cfg_TLS_mutex,unprefixedUut_client_conn_balancerWrapper_balancerMu,unprefixedUut_client_conn_balancerWrapper_mu,unprefixedUut_client_conn_blockingpicker_mu,unprefixedUut_client_conn_csMgr_mu,unprefixedUut_client_conn_mu,unprefixedUut_client_conn_resolverWrapper_pollingMu,unprefixedUut_client_conn_resolverWrapper_resolverMu,unprefixedUut_client_mu,unprefixedUut_client_resolverGroup_mu,child_Close2950);
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
proctype Put643(Mutexdef b_client_cfg_TLS_mutex;Mutexdef b_client_conn_balancerWrapper_balancerMu;Mutexdef b_client_conn_balancerWrapper_mu;Mutexdef b_client_conn_blockingpicker_mu;Mutexdef b_client_conn_csMgr_mu;Mutexdef b_client_conn_mu;Mutexdef b_client_conn_resolverWrapper_pollingMu;Mutexdef b_client_conn_resolverWrapper_resolverMu;Mutexdef b_client_mu;Mutexdef b_client_resolverGroup_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_prependPrefix8493 = [1] of {int};
	chan child_setupLease7442 = [1] of {int};
	

	if
	:: true -> 
		run setupLease744(b_client_cfg_TLS_mutex,b_client_conn_balancerWrapper_balancerMu,b_client_conn_balancerWrapper_mu,b_client_conn_blockingpicker_mu,b_client_conn_csMgr_mu,b_client_conn_mu,b_client_conn_resolverWrapper_pollingMu,b_client_conn_resolverWrapper_resolverMu,b_client_mu,b_client_resolverGroup_mu,child_setupLease7442);
		child_setupLease7442?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run prependPrefix849(b_client_cfg_TLS_mutex,b_client_conn_balancerWrapper_balancerMu,b_client_conn_balancerWrapper_mu,b_client_conn_blockingpicker_mu,b_client_conn_csMgr_mu,b_client_conn_mu,b_client_conn_resolverWrapper_pollingMu,b_client_conn_resolverWrapper_resolverMu,b_client_mu,b_client_resolverGroup_mu,child_prependPrefix8493);
	child_prependPrefix8493?0;
	

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
	chan child_ttl7562 = [1] of {int};
	run ttl756(b_client_cfg_TLS_mutex,b_client_conn_balancerWrapper_balancerMu,b_client_conn_balancerWrapper_mu,b_client_conn_blockingpicker_mu,b_client_conn_csMgr_mu,b_client_conn_mu,b_client_conn_resolverWrapper_pollingMu,b_client_conn_resolverWrapper_resolverMu,b_client_mu,b_client_resolverGroup_mu,child_ttl7562);
	child_ttl7562?0;
	

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
proctype prependPrefix849(Mutexdef b_client_cfg_TLS_mutex;Mutexdef b_client_conn_balancerWrapper_balancerMu;Mutexdef b_client_conn_balancerWrapper_mu;Mutexdef b_client_conn_blockingpicker_mu;Mutexdef b_client_conn_csMgr_mu;Mutexdef b_client_conn_mu;Mutexdef b_client_conn_resolverWrapper_pollingMu;Mutexdef b_client_conn_resolverWrapper_resolverMu;Mutexdef b_client_mu;Mutexdef b_client_resolverGroup_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype requireKV148(Mutexdef bk_client_cfg_TLS_mutex;Mutexdef bk_client_conn_balancerWrapper_balancerMu;Mutexdef bk_client_conn_balancerWrapper_mu;Mutexdef bk_client_conn_blockingpicker_mu;Mutexdef bk_client_conn_csMgr_mu;Mutexdef bk_client_conn_mu;Mutexdef bk_client_conn_resolverWrapper_pollingMu;Mutexdef bk_client_conn_resolverWrapper_resolverMu;Mutexdef bk_client_mu;Mutexdef bk_client_resolverGroup_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Get693(Mutexdef b_client_cfg_TLS_mutex;Mutexdef b_client_conn_balancerWrapper_balancerMu;Mutexdef b_client_conn_balancerWrapper_mu;Mutexdef b_client_conn_blockingpicker_mu;Mutexdef b_client_conn_csMgr_mu;Mutexdef b_client_conn_mu;Mutexdef b_client_conn_resolverWrapper_pollingMu;Mutexdef b_client_conn_resolverWrapper_resolverMu;Mutexdef b_client_mu;Mutexdef b_client_resolverGroup_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_prependPrefix8494 = [1] of {int};
	run prependPrefix849(b_client_cfg_TLS_mutex,b_client_conn_balancerWrapper_balancerMu,b_client_conn_balancerWrapper_mu,b_client_conn_blockingpicker_mu,b_client_conn_csMgr_mu,b_client_conn_mu,b_client_conn_resolverWrapper_pollingMu,b_client_conn_resolverWrapper_resolverMu,b_client_mu,b_client_resolverGroup_mu,child_prependPrefix8494);
	child_prependPrefix8494?0;
	

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

