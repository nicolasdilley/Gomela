// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/kubelet/kuberuntime/kuberuntime_gc_test.go#L451
#define not_found_458  -2 // opt templates line 184
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUnknownStateContainerGC4510 = [1] of {int};
	run TestUnknownStateContainerGC451(child_TestUnknownStateContainerGC4510);
	run receiver(child_TestUnknownStateContainerGC4510)
stop_process:skip
}

proctype TestUnknownStateContainerGC451(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_makeFakeContainers1840 = [1] of {int};
	Mutexdef m_logReduction_errorMapLock;
	run mutexMonitor(m_logReduction_errorMapLock);
	run makeFakeContainers184(m_logReduction_errorMapLock,not_found_458,child_makeFakeContainers1840);
	child_makeFakeContainers1840?0;
	stop_process: skip;
	child!0
}
proctype makeFakeContainers184(Mutexdef m_logReduction_errorMapLock;int templates;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_makeFakeContainer1560 = [1] of {int};
	chan child_makeFakeContainer1561 = [1] of {int};
	

	if
	:: var_templates-1 != -3 -> 
				for(i : 0.. var_templates-1) {
			for10: skip;
			run makeFakeContainer156(m_logReduction_errorMapLock,child_makeFakeContainer1560);
			child_makeFakeContainer1560?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for113: skip;
			run makeFakeContainer156(m_logReduction_errorMapLock,child_makeFakeContainer1561);
			child_makeFakeContainer1561?0;
			for113_end: skip
		:: true -> 
			break
		od;
		for113_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype makeFakeContainer156(Mutexdef m_logReduction_errorMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_generateContainerConfig2951 = [1] of {int};
	chan child_generatePodSandboxConfig760 = [1] of {int};
	run generatePodSandboxConfig76(m_logReduction_errorMapLock,child_generatePodSandboxConfig760);
	child_generatePodSandboxConfig760?0;
	run generateContainerConfig295(m_logReduction_errorMapLock,child_generateContainerConfig2951);
	child_generateContainerConfig2951?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype generatePodSandboxConfig76(Mutexdef m_logReduction_errorMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_generatePodSandboxLinuxConfig1480 = [1] of {int};
	int var_containerPortMappingscontainerPortMappings = -2; // opt var_containerPortMappingscontainerPortMappings
	int var_pod_Spec_Containerspod_Spec_Containers = -2; // opt var_pod_Spec_Containerspod_Spec_Containers
	

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
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run generatePodSandboxLinuxConfig148(m_logReduction_errorMapLock,child_generatePodSandboxLinuxConfig1480);
	child_generatePodSandboxLinuxConfig1480?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype generatePodSandboxLinuxConfig148(Mutexdef m_logReduction_errorMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_sc_SupplementalGroupssc_SupplementalGroups = -2; // opt var_sc_SupplementalGroupssc_SupplementalGroups
	int var_pod_Spec_SecurityContext_Sysctlspod_Spec_SecurityContext_Sysctls = -2; // opt var_pod_Spec_SecurityContext_Sysctlspod_Spec_SecurityContext_Sysctls
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype generateContainerConfig295(Mutexdef m_logReduction_errorMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_applyPlatformSpecificContainerConfig282 = [1] of {int};
	chan child_getImageUser1221 = [1] of {int};
	int var_opts_Envsopts_Envs = -2; // opt var_opts_Envsopts_Envs
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getImageUser122(m_logReduction_errorMapLock,child_getImageUser1221);
	child_getImageUser1221?0;
	

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
	run applyPlatformSpecificContainerConfig28(m_logReduction_errorMapLock,child_applyPlatformSpecificContainerConfig282);
	child_applyPlatformSpecificContainerConfig282?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getImageUser122(Mutexdef m_logReduction_errorMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype applyPlatformSpecificContainerConfig28(Mutexdef m_logReduction_errorMapLock;chan child) {
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

