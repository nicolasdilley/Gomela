// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gravitational/teleport/blob//lib/reversetunnel/rc_manager_test.go#L30
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRemoteClusterTunnelManagerSync300 = [1] of {int};
	run TestRemoteClusterTunnelManagerSync30(child_TestRemoteClusterTunnelManagerSync300);
	run receiver(child_TestRemoteClusterTunnelManagerSync300)
stop_process:skip
}

proctype TestRemoteClusterTunnelManagerSync30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1190 = [1] of {int};
	Mutexdef w_mu;
	int var_tests = -2; // opt var_tests
	run mutexMonitor(w_mu);
		defer1: skip;
	run Close119(w_mu,child_Close1190);
	child_Close1190?0;
	stop_process: skip;
	child!0
}
proctype Close119(Mutexdef w_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_w_pools = -2; // opt var_w_pools
	w_mu.Lock!false;
	goto defer1;
		defer1: skip;
	w_mu.Unlock!false;
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

