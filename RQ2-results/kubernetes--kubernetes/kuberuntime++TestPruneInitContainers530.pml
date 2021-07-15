#define not_found_555  -2

// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/kuberuntime/kuberuntime_manager_test.go#L530
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPruneInitContainers5300 = [1] of {int};
	run TestPruneInitContainers530(child_TestPruneInitContainers5300)
stop_process:skip
}

proctype TestPruneInitContainers530(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_pruneInitContainersBeforeStart7102 = [1] of {int};
	chan child_GetPodStatus9671 = [1] of {int};
	chan child_makeFakeContainers1840 = [1] of {int};
	Mutexdef m_logReduction_errorMapLock;
	run mutexMonitor(m_logReduction_errorMapLock);
	run makeFakeContainers184(m_logReduction_errorMapLock,not_found_555,child_makeFakeContainers1840);
	child_makeFakeContainers1840?0;
	run GetPodStatus967(m_logReduction_errorMapLock,child_GetPodStatus9671);
	child_GetPodStatus9671?0;
	run pruneInitContainersBeforeStart710(m_logReduction_errorMapLock,child_pruneInitContainersBeforeStart7102);
	child_pruneInitContainersBeforeStart7102?0;
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
	:: templates-1 != -3 -> 
				for(i : 0.. templates-1) {
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
	chan child_generateContainerConfig2421 = [1] of {int};
	chan child_generatePodSandboxConfig760 = [1] of {int};
	run generatePodSandboxConfig76(m_logReduction_errorMapLock,child_generatePodSandboxConfig760);
	child_generatePodSandboxConfig760?0;
	run generateContainerConfig242(m_logReduction_errorMapLock,child_generateContainerConfig2421);
	child_generateContainerConfig2421?0;
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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype generateContainerConfig242(Mutexdef m_logReduction_errorMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_applyPlatformSpecificContainerConfig282 = [1] of {int};
	chan child_getImageUser1221 = [1] of {int};
	

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
proctype GetPodStatus967(Mutexdef m_logReduction_errorMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getPodContainerStatuses4404 = [1] of {int};
	chan child_determinePodSandboxIPs2312 = [1] of {int};
	chan child_determinePodSandboxIPs2313 = [1] of {int};
	chan child_getSandboxIDByPodUID2641 = [1] of {int};
	int podSandboxIDs = -2;
	run getSandboxIDByPodUID264(m_logReduction_errorMapLock,child_getSandboxIDByPodUID2641);
	child_getSandboxIDByPodUID2641?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: podSandboxIDs-1 != -3 -> 
				for(i : 0.. podSandboxIDs-1) {
			for30: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				run determinePodSandboxIPs231(m_logReduction_errorMapLock,child_determinePodSandboxIPs2312);
				child_determinePodSandboxIPs2312?0
			:: true;
			fi;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for33: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				run determinePodSandboxIPs231(m_logReduction_errorMapLock,child_determinePodSandboxIPs2313);
				child_determinePodSandboxIPs2313?0
			:: true;
			fi;
			for33_end: skip
		:: true -> 
			break
		od;
		for33_exit: skip
	fi;
	run getPodContainerStatuses440(m_logReduction_errorMapLock,child_getPodContainerStatuses4404);
	child_getPodContainerStatuses4404?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getSandboxIDByPodUID264(Mutexdef m_logReduction_errorMapLock;chan child) {
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
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype determinePodSandboxIPs231(Mutexdef m_logReduction_errorMapLock;chan child) {
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
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getPodContainerStatuses440(Mutexdef m_logReduction_errorMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_readLastStringFromContainerLogs4304 = [1] of {int};
	chan child_readLastStringFromContainerLogs4305 = [1] of {int};
	int containers = -2;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: containers-1 != -3 -> 
				for(i : 0.. containers-1) {
			for40: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: true -> 
						run readLastStringFromContainerLogs430(m_logReduction_errorMapLock,child_readLastStringFromContainerLogs4304);
						child_readLastStringFromContainerLogs4304?0
					fi
				:: true;
				fi
			:: true;
			fi;
			for40_end: skip
		};
		for40_exit: skip
	:: else -> 
		do
		:: true -> 
			for41: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: true -> 
						run readLastStringFromContainerLogs430(m_logReduction_errorMapLock,child_readLastStringFromContainerLogs4305);
						child_readLastStringFromContainerLogs4305?0
					fi
				:: true;
				fi
			:: true;
			fi;
			for41_end: skip
		:: true -> 
			break
		od;
		for41_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype readLastStringFromContainerLogs430(Mutexdef m_logReduction_errorMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ReadLogs314 = [1] of {int};
	run ReadLogs31(m_logReduction_errorMapLock,child_ReadLogs314);
	child_ReadLogs314?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ReadLogs31(Mutexdef m_logReduction_errorMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype pruneInitContainersBeforeStart710(Mutexdef m_logReduction_errorMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_removeContainer8842 = [1] of {int};
	chan child_removeContainer8843 = [1] of {int};
	chan child_removeContainer8844 = [1] of {int};
	chan child_removeContainer8845 = [1] of {int};
	int initContainerNames = -2;
	int podStatus_ContainerStatuses = -2;
	

	if
	:: initContainerNames-1 != -3 -> 
				for(i : 0.. initContainerNames-1) {
			for60: skip;
			

			if
			:: podStatus_ContainerStatuses-1 != -3 -> 
								for(i : 0.. podStatus_ContainerStatuses-1) {
					for61: skip;
					

					if
					:: true -> 
						goto for61_end
					:: true;
					fi;
					

					if
					:: true -> 
						goto for61_end
					:: true;
					fi;
					run removeContainer884(m_logReduction_errorMapLock,child_removeContainer8842);
					child_removeContainer8842?0;
					

					if
					:: true -> 
						goto for61_end
					:: true;
					fi;
					for61_end: skip
				};
				for61_exit: skip
			:: else -> 
				do
				:: true -> 
					for62: skip;
					

					if
					:: true -> 
						goto for62_end
					:: true;
					fi;
					

					if
					:: true -> 
						goto for62_end
					:: true;
					fi;
					run removeContainer884(m_logReduction_errorMapLock,child_removeContainer8843);
					child_removeContainer8843?0;
					

					if
					:: true -> 
						goto for62_end
					:: true;
					fi;
					for62_end: skip
				:: true -> 
					break
				od;
				for62_exit: skip
			fi;
			for60_end: skip
		};
		for60_exit: skip
	:: else -> 
		do
		:: true -> 
			for63: skip;
			

			if
			:: podStatus_ContainerStatuses-1 != -3 -> 
								for(i : 0.. podStatus_ContainerStatuses-1) {
					for64: skip;
					

					if
					:: true -> 
						goto for64_end
					:: true;
					fi;
					

					if
					:: true -> 
						goto for64_end
					:: true;
					fi;
					run removeContainer884(m_logReduction_errorMapLock,child_removeContainer8844);
					child_removeContainer8844?0;
					

					if
					:: true -> 
						goto for64_end
					:: true;
					fi;
					for64_end: skip
				};
				for64_exit: skip
			:: else -> 
				do
				:: true -> 
					for65: skip;
					

					if
					:: true -> 
						goto for65_end
					:: true;
					fi;
					

					if
					:: true -> 
						goto for65_end
					:: true;
					fi;
					run removeContainer884(m_logReduction_errorMapLock,child_removeContainer8845);
					child_removeContainer8845?0;
					

					if
					:: true -> 
						goto for65_end
					:: true;
					fi;
					for65_end: skip
				:: true -> 
					break
				od;
				for65_exit: skip
			fi;
			for63_end: skip
		:: true -> 
			break
		od;
		for63_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype removeContainer884(Mutexdef m_logReduction_errorMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_removeContainerLog9012 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run removeContainerLog901(m_logReduction_errorMapLock,child_removeContainerLog9012);
	child_removeContainerLog9012?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype removeContainerLog901(Mutexdef m_logReduction_errorMapLock;chan child) {
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

