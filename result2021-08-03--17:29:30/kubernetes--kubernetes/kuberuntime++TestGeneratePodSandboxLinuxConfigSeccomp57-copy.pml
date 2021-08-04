// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/kubelet/kuberuntime/kuberuntime_sandbox_test.go#L57
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGeneratePodSandboxLinuxConfigSeccomp570 = [1] of {int};
	run TestGeneratePodSandboxLinuxConfigSeccomp57(child_TestGeneratePodSandboxLinuxConfigSeccomp570);
	run receiver(child_TestGeneratePodSandboxLinuxConfigSeccomp570)
stop_process:skip
}

proctype TestGeneratePodSandboxLinuxConfigSeccomp57(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_generatePodSandboxLinuxConfig1480 = [1] of {int};
	chan child_generatePodSandboxLinuxConfig1481 = [1] of {int};
	Mutexdef m_logReduction_errorMapLock;
	int var_tests = -2; // opt var_tests
	run mutexMonitor(m_logReduction_errorMapLock);
	

	if
	:: var_tests-1 != -3 -> 
				for(i : 0.. var_tests-1) {
			for10: skip;
			run generatePodSandboxLinuxConfig148(m_logReduction_errorMapLock,child_generatePodSandboxLinuxConfig1480);
			child_generatePodSandboxLinuxConfig1480?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for15: skip;
			run generatePodSandboxLinuxConfig148(m_logReduction_errorMapLock,child_generatePodSandboxLinuxConfig1481);
			child_generatePodSandboxLinuxConfig1481?0;
			for15_end: skip
		:: true -> 
			break
		od;
		for15_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype generatePodSandboxLinuxConfig148(Mutexdef m_logReduction_errorMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_sc_SupplementalGroups = -2; // opt var_sc_SupplementalGroups
	int var_pod_Spec_SecurityContext_Sysctls = -2; // opt var_pod_Spec_SecurityContext_Sysctls
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

