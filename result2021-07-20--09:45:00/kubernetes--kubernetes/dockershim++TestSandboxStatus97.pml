// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/kubelet/dockershim/docker_sandbox_test.go#L97
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSandboxStatus970 = [1] of {int};
	run TestSandboxStatus97(child_TestSandboxStatus970);
	run receiver(child_TestSandboxStatus970)
stop_process:skip
}

proctype TestSandboxStatus97(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PodSandboxStatus4215 = [1] of {int};
	chan child_RemovePodSandbox2924 = [1] of {int};
	chan child_PodSandboxStatus4213 = [1] of {int};
	chan child_StopPodSandbox2122 = [1] of {int};
	chan child_PodSandboxStatus4211 = [1] of {int};
	chan child_RunPodSandbox890 = [1] of {int};
	Mutexdef ds_cleanupInfosLock;
	Mutexdef ds_networkReadyLock;
	Mutexdef ds_network_podsLock;
	run mutexMonitor(ds_network_podsLock);
	run mutexMonitor(ds_networkReadyLock);
	run mutexMonitor(ds_cleanupInfosLock);
	run RunPodSandbox89(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_RunPodSandbox890);
	child_RunPodSandbox890?0;
	run PodSandboxStatus421(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_PodSandboxStatus4211);
	child_PodSandboxStatus4211?0;
	run StopPodSandbox212(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_StopPodSandbox2122);
	child_StopPodSandbox2122?0;
	run PodSandboxStatus421(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_PodSandboxStatus4213);
	child_PodSandboxStatus4213?0;
	run RemovePodSandbox292(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_RemovePodSandbox2924);
	child_RemovePodSandbox2924?0;
	run PodSandboxStatus421(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_PodSandboxStatus4215);
	child_PodSandboxStatus4215?0;
	stop_process: skip;
	child!0
}
proctype RunPodSandbox89(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_setNetworkReady722 = [1] of {int};
	chan child_setNetworkReady721 = [1] of {int};
	chan child_makeSandboxDockerConfig6200 = [1] of {int};
	

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
	run makeSandboxDockerConfig620(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_makeSandboxDockerConfig6200);
	child_makeSandboxDockerConfig6200?0;
	

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
	run setNetworkReady72(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_setNetworkReady721);
	child_setNetworkReady721?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi;
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	

	if
	:: true -> 
		run setNetworkReady72(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_setNetworkReady722);
		child_setNetworkReady722?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype makeSandboxDockerConfig620(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getSandBoxSecurityOpts402 = [1] of {int};
	chan child_applySandboxResources6011 = [1] of {int};
	chan child_applySandboxLinuxOptions5870 = [1] of {int};
	run applySandboxLinuxOptions587(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_applySandboxLinuxOptions5870);
	child_applySandboxLinuxOptions5870?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run applySandboxResources601(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_applySandboxResources6011);
	child_applySandboxResources6011?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getSandBoxSecurityOpts40(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_getSandBoxSecurityOpts402);
	child_getSandBoxSecurityOpts402?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype applySandboxLinuxOptions587(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_applySandboxSecurityContext320 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run applySandboxSecurityContext32(ds_network_podsLock,child_applySandboxSecurityContext320);
	child_applySandboxSecurityContext320?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype applySandboxSecurityContext32(Mutexdef network_podsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_modifySandboxNamespaceOptions1500 = [1] of {int};
	

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
	run modifySandboxNamespaceOptions150(network_podsLock,child_modifySandboxNamespaceOptions1500);
	child_modifySandboxNamespaceOptions1500?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype modifySandboxNamespaceOptions150(Mutexdef network_podsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_modifyHostOptionsForSandbox1720 = [1] of {int};
	run modifyHostOptionsForSandbox172(network_podsLock,child_modifyHostOptionsForSandbox1720);
	child_modifyHostOptionsForSandbox1720?0;
	stop_process: skip;
	child!0
}
proctype modifyHostOptionsForSandbox172(Mutexdef network_podsLock;chan child) {
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
	:: true;
	:: true;
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype applySandboxResources601(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GenerateExpectedCgroupParent4681 = [1] of {int};
	

	if
	:: true -> 
		run GenerateExpectedCgroupParent468(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_GenerateExpectedCgroupParent4681);
		child_GenerateExpectedCgroupParent4681?0;
		

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
proctype GenerateExpectedCgroupParent468(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getSandBoxSecurityOpts40(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype setNetworkReady72(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ds_networkReadyLock.Lock!false;
		defer1: skip;
	ds_networkReadyLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype PodSandboxStatus421(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getIPs3643 = [1] of {int};
	chan child_determinePodIPBySandboxID542 = [1] of {int};
	chan child_getPodSandboxDetails4061 = [1] of {int};
	int var_ipsips = -2; // opt var_ipsips
	run getPodSandboxDetails406(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_getPodSandboxDetails4061);
	child_getPodSandboxDetails4061?0;
	

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
	run determinePodIPBySandboxID54(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_determinePodIPBySandboxID542);
	child_determinePodIPBySandboxID542?0;
	

	if
	:: true -> 
		run getIPs364(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_getIPs3643);
		child_getIPs3643?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getPodSandboxDetails406(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
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
proctype determinePodIPBySandboxID54(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getIPs364(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getIPsFromPlugin3354 = [1] of {int};
	chan child_getNetworkReady653 = [1] of {int};
	

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
	run getNetworkReady65(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_getNetworkReady653);
	child_getNetworkReady653?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getIPsFromPlugin335(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_getIPsFromPlugin3354);
	child_getIPsFromPlugin3354?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getNetworkReady65(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ds_networkReadyLock.Lock!false;
	goto defer1;
		defer1: skip;
	ds_networkReadyLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype getIPsFromPlugin335(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_networkStatus_IPsnetworkStatus_IPs = -2; // opt var_networkStatus_IPsnetworkStatus_IPs
	

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
proctype StopPodSandbox212(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_setNetworkReady724 = [1] of {int};
	chan child_getNetworkReady653 = [1] of {int};
	chan child_getPodSandboxDetails4062 = [1] of {int};
	run getPodSandboxDetails406(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_getPodSandboxDetails4062);
	child_getPodSandboxDetails4062?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			fi
		fi
	fi;
	run getNetworkReady65(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_getNetworkReady653);
	child_getNetworkReady653?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run setNetworkReady72(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_setNetworkReady724);
			child_setNetworkReady724?0
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
proctype RemovePodSandbox292(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_clearNetworkReady786 = [1] of {int};
	chan child_RemoveContainer3164 = [1] of {int};
	chan child_RemoveContainer3165 = [1] of {int};
	int var_containerscontainers = -2; // opt var_containerscontainers
	

	if
	:: var_containers-1 != -3 -> 
				for(i : 0.. var_containers-1) {
			for30: skip;
			run RemoveContainer316(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_RemoveContainer3164);
			child_RemoveContainer3164?0;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for33: skip;
			run RemoveContainer316(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_RemoveContainer3165);
			child_RemoveContainer3165?0;
			for33_end: skip
		:: true -> 
			break
		od;
		for33_exit: skip
	fi;
	

	if
	:: true -> 
		run clearNetworkReady78(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_clearNetworkReady786);
		child_clearNetworkReady786?0
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
proctype RemoveContainer316(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_performPlatformSpecificContainerForContainer4845 = [1] of {int};
	chan child_removeContainerLogSymlink2704 = [1] of {int};
	run removeContainerLogSymlink270(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_removeContainerLogSymlink2704);
	child_removeContainerLogSymlink2704?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run performPlatformSpecificContainerForContainer484(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_performPlatformSpecificContainerForContainer4845);
	child_performPlatformSpecificContainerForContainer4845?0;
	

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
proctype removeContainerLogSymlink270(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getContainerLogPath2224 = [1] of {int};
	run getContainerLogPath222(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_getContainerLogPath2224);
	child_getContainerLogPath2224?0;
	

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
proctype getContainerLogPath222(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
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
proctype performPlatformSpecificContainerForContainer484(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_clearContainerCleanupInfo997 = [1] of {int};
	chan child_performPlatformSpecificContainerCleanupAndLogErrors4966 = [1] of {int};
	chan child_getContainerCleanupInfo865 = [1] of {int};
	run getContainerCleanupInfo86(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_getContainerCleanupInfo865);
	child_getContainerCleanupInfo865?0;
	

	if
	:: true -> 
		run performPlatformSpecificContainerCleanupAndLogErrors496(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_performPlatformSpecificContainerCleanupAndLogErrors4966);
		child_performPlatformSpecificContainerCleanupAndLogErrors4966?0;
		

		if
		:: true -> 
			run clearContainerCleanupInfo99(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_clearContainerCleanupInfo997);
			child_clearContainerCleanupInfo997?0
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getContainerCleanupInfo86(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ds_cleanupInfosLock.RLock!false;
	goto defer1;
		defer1: skip;
	ds_cleanupInfosLock.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype performPlatformSpecificContainerCleanupAndLogErrors496(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_performPlatformSpecificContainerCleanup376 = [1] of {int};
	int var_errorserrors = -2; // opt var_errorserrors
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run performPlatformSpecificContainerCleanup37(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_performPlatformSpecificContainerCleanup376);
	child_performPlatformSpecificContainerCleanup376?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype performPlatformSpecificContainerCleanup37(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype clearContainerCleanupInfo99(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ds_cleanupInfosLock.Lock!false;
		defer1: skip;
	ds_cleanupInfosLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype clearNetworkReady78(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ds_networkReadyLock.Lock!false;
		defer1: skip;
	ds_networkReadyLock.Unlock!false;
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

