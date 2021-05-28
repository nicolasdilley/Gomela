// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/security/pkg/pki/ra/k8s_ra_test.go#L113
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestK8sSign1130 = [1] of {int};
	run TestK8sSign113(child_TestK8sSign1130);
	run receiver(child_TestK8sSign1130)
stop_process:skip
}

proctype TestK8sSign113(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_kubernetesSign500 = [1] of {int};
	Mutexdef r_keyCertBundle_mutex;
	run mutexMonitor(r_keyCertBundle_mutex);
	run kubernetesSign50(r_keyCertBundle_mutex,child_kubernetesSign500);
	child_kubernetesSign500?0;
	stop_process: skip;
	child!0
}
proctype kubernetesSign50(Mutexdef r_keyCertBundle_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

