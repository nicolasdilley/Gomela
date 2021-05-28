// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/traefik/traefik/blob/080cf98e512f6fcb93838de76a6aa34ff147dee4/pkg/server/service/service_test.go#L82
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
	chan child_TestGetLoadBalancerServiceHandler820 = [1] of {int};
	run TestGetLoadBalancerServiceHandler82(child_TestGetLoadBalancerServiceHandler820);
	run receiver(child_TestGetLoadBalancerServiceHandler820)
stop_process:skip
}

proctype TestGetLoadBalancerServiceHandler82(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef serverPassHostFalse_mu;
	Wgdef serverPassHostFalse_wg;
	Mutexdef serverPassHostFalse_Config_mu;
	Mutexdef serverPassHostFalse_TLS_mutex;
	Mutexdef serverPassHost_mu;
	Wgdef serverPassHost_wg;
	Mutexdef serverPassHost_Config_mu;
	Mutexdef serverPassHost_TLS_mutex;
	Mutexdef server2_mu;
	Wgdef server2_wg;
	Mutexdef server2_Config_mu;
	Mutexdef server2_TLS_mutex;
	Mutexdef server1_mu;
	Wgdef server1_wg;
	Mutexdef server1_Config_mu;
	Mutexdef server1_TLS_mutex;
	Wgdef sm_routinePool_waitGroup;
	int test_expected = -2; // opt test_expected
	int testCases = -2; // opt testCases
	run wgMonitor(sm_routinePool_waitGroup);
	run mutexMonitor(server1_TLS_mutex);
	run mutexMonitor(server1_Config_mu);
	run wgMonitor(server1_wg);
	run mutexMonitor(server1_mu);
	run mutexMonitor(server2_TLS_mutex);
	run mutexMonitor(server2_Config_mu);
	run wgMonitor(server2_wg);
	run mutexMonitor(server2_mu);
	run mutexMonitor(serverPassHost_TLS_mutex);
	run mutexMonitor(serverPassHost_Config_mu);
	run wgMonitor(serverPassHost_wg);
	run mutexMonitor(serverPassHost_mu);
	run mutexMonitor(serverPassHostFalse_TLS_mutex);
	run mutexMonitor(serverPassHostFalse_Config_mu);
	run wgMonitor(serverPassHostFalse_wg);
	run mutexMonitor(serverPassHostFalse_mu);
		stop_process: skip;
		stop_process: skip;
		stop_process: skip;
		stop_process: skip;
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

