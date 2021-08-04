// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/backend/remote-state/etcdv3/backend_test.go#L28
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
	run cleanupEtcdv328(child_cleanupEtcdv3280);
	run receiver(child_cleanupEtcdv3280)
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
	Mutexdef client_balancer_mu;
	Mutexdef client_balancer_unhealthyMu;
	Mutexdef client_conn_mu;
	run mutexMonitor(client_conn_mu);
	run mutexMonitor(client_balancer_unhealthyMu);
	run mutexMonitor(client_balancer_mu);
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

proctype receiver(chan c) {
c?0
}

