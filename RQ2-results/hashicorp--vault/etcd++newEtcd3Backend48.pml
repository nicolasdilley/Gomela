
// https://github.com/hashicorp/vault/blob/master/physical/etcd/etcd3.go#L48
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newEtcd3Backend480 = [1] of {int};
	run newEtcd3Backend48(child_newEtcd3Backend480)
stop_process:skip
}

proctype newEtcd3Backend48(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef etcd_mu;
	Mutexdef etcd_resolverGroup_mu;
	Mutexdef etcd_cfg_TLS_mutex;
	Mutexdef etcd_conn_firstResolveEvent_o_m;
	Mutexdef etcd_conn_balancerWrapper_mu;
	Mutexdef etcd_conn_balancerWrapper_done_o_m;
	Mutexdef etcd_conn_balancerWrapper_scBuffer_mu;
	Mutexdef etcd_conn_balancerWrapper_balancerMu;
	Mutexdef etcd_conn_resolverWrapper_pollingMu;
	Mutexdef etcd_conn_resolverWrapper_done_o_m;
	Mutexdef etcd_conn_resolverWrapper_resolverMu;
	Mutexdef etcd_conn_mu;
	Mutexdef etcd_conn_blockingpicker_mu;
	Mutexdef etcd_conn_csMgr_mu;
	Mutexdef tlscfg_mutex;
	Mutexdef cfg_TLS_mutex;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(cfg_TLS_mutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run mutexMonitor(tlscfg_mutex);
		

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
		fi
	:: true;
	fi;
	run mutexMonitor(etcd_conn_csMgr_mu);
	run mutexMonitor(etcd_conn_blockingpicker_mu);
	run mutexMonitor(etcd_conn_mu);
	run mutexMonitor(etcd_conn_resolverWrapper_resolverMu);
	run mutexMonitor(etcd_conn_resolverWrapper_done_o_m);
	run mutexMonitor(etcd_conn_resolverWrapper_pollingMu);
	run mutexMonitor(etcd_conn_balancerWrapper_balancerMu);
	run mutexMonitor(etcd_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(etcd_conn_balancerWrapper_done_o_m);
	run mutexMonitor(etcd_conn_balancerWrapper_mu);
	run mutexMonitor(etcd_conn_firstResolveEvent_o_m);
	run mutexMonitor(etcd_cfg_TLS_mutex);
	run mutexMonitor(etcd_resolverGroup_mu);
	run mutexMonitor(etcd_mu);
	

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

