// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/kubelet/kuberuntime/kuberuntime_sandbox_test.go#L101
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCreatePodSandbox_RuntimeClass1010 = [1] of {int};
	run TestCreatePodSandbox_RuntimeClass101(child_TestCreatePodSandbox_RuntimeClass1010);
	run receiver(child_TestCreatePodSandbox_RuntimeClass1010)
stop_process:skip
}

proctype TestCreatePodSandbox_RuntimeClass101(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef m_logReduction_errorMapLock;
	int tests = -2; // opt tests
	run mutexMonitor(m_logReduction_errorMapLock);
		stop_process: skip;
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

