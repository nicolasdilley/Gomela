
// https://github.com/hashicorp/terraform/blob/master/backend/remote-state/etcdv3/backend_test.go#L28
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_cleanupEtcdv3280 = [1] of {int};
	run cleanupEtcdv328(child_cleanupEtcdv3280)
stop_process:skip
}

proctype cleanupEtcdv328(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef client_tokenCred_tokenMu;
	Mutexdef client_mu;
	Wgdef client_balancer_wg;
	Mutexdef client_balancer_stopOnce_m;
	Mutexdef client_balancer_mu;
	Mutexdef client_balancer_unhealthyMu;
	Mutexdef client_balancer_readyOnce_m;
	Mutexdef client_cfg_TLS_mutex;
	Mutexdef client_conn_firstResolveEvent_o_m;
	Mutexdef client_conn_balancerWrapper_mu;
	Mutexdef client_conn_balancerWrapper_done_o_m;
	Mutexdef client_conn_balancerWrapper_scBuffer_mu;
	Mutexdef client_conn_balancerWrapper_balancerMu;
	Mutexdef client_conn_resolverWrapper_pollingMu;
	Mutexdef client_conn_resolverWrapper_done_o_m;
	Mutexdef client_conn_resolverWrapper_resolverMu;
	Mutexdef client_conn_mu;
	Mutexdef client_conn_blockingpicker_mu;
	Mutexdef client_conn_csMgr_mu;
	run mutexMonitor(client_conn_csMgr_mu);
	run mutexMonitor(client_conn_blockingpicker_mu);
	run mutexMonitor(client_conn_mu);
	run mutexMonitor(client_conn_resolverWrapper_resolverMu);
	run mutexMonitor(client_conn_resolverWrapper_done_o_m);
	run mutexMonitor(client_conn_resolverWrapper_pollingMu);
	run mutexMonitor(client_conn_balancerWrapper_balancerMu);
	run mutexMonitor(client_conn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(client_conn_balancerWrapper_done_o_m);
	run mutexMonitor(client_conn_balancerWrapper_mu);
	run mutexMonitor(client_conn_firstResolveEvent_o_m);
	run mutexMonitor(client_cfg_TLS_mutex);
	run mutexMonitor(client_balancer_readyOnce_m);
	run mutexMonitor(client_balancer_unhealthyMu);
	run mutexMonitor(client_balancer_mu);
	run mutexMonitor(client_balancer_stopOnce_m);
	run wgMonitor(client_balancer_wg);
	run mutexMonitor(client_mu);
	run mutexMonitor(client_tokenCred_tokenMu);
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

