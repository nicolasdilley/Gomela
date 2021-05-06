
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/dockershim/docker_sandbox_test.go#L279
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSetUpPodFailure2790 = [1] of {int};
	run TestSetUpPodFailure279(child_TestSetUpPodFailure2790)
stop_process:skip
}

proctype TestSetUpPodFailure279(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ListPodSandbox4903 = [1] of {int};
	chan child_PodSandboxStatus4212 = [1] of {int};
	chan child_RunPodSandbox891 = [1] of {int};
	chan child_NewPluginManager3140 = [1] of {int};
	Mutexdef mockPlugin_ctrl_mu;
	Mutexdef ds_cleanupInfosLock;
	Mutexdef ds_networkReadyLock;
	Mutexdef ds_network_podsLock;
	run mutexMonitor(ds_network_podsLock);
	run mutexMonitor(ds_networkReadyLock);
	run mutexMonitor(ds_cleanupInfosLock);
	run mutexMonitor(mockPlugin_ctrl_mu);
	run NewPluginManager314(mockPlugin_ctrl_mu,child_NewPluginManager3140);
	child_NewPluginManager3140?0;
	run RunPodSandbox89(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_RunPodSandbox891);
	child_RunPodSandbox891?0;
	run PodSandboxStatus421(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_PodSandboxStatus4212);
	child_PodSandboxStatus4212?0;
	run ListPodSandbox490(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_ListPodSandbox4903);
	child_ListPodSandbox4903?0;
	stop_process: skip;
	child!0
}
proctype NewPluginManager314(Mutexdef plugin_ctrl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype RunPodSandbox89(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_setNetworkReady723 = [1] of {int};
	chan child_setNetworkReady722 = [1] of {int};
	chan child_makeSandboxDockerConfig6201 = [1] of {int};
	

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
	run makeSandboxDockerConfig620(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_makeSandboxDockerConfig6201);
	child_makeSandboxDockerConfig6201?0;
	

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
	run setNetworkReady72(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_setNetworkReady722);
	child_setNetworkReady722?0;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		

	if
	:: true -> 
		run setNetworkReady72(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_setNetworkReady723);
		child_setNetworkReady723?0
	:: true;
	fi;
	child!0
}
proctype makeSandboxDockerConfig620(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getSandBoxSecurityOpts403 = [1] of {int};
	chan child_applySandboxResources6012 = [1] of {int};
	chan child_applySandboxLinuxOptions5871 = [1] of {int};
	run applySandboxLinuxOptions587(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_applySandboxLinuxOptions5871);
	child_applySandboxLinuxOptions5871?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run applySandboxResources601(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_applySandboxResources6012);
	child_applySandboxResources6012?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getSandBoxSecurityOpts40(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getSandBoxSecurityOpts403);
	child_getSandBoxSecurityOpts403?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype applySandboxLinuxOptions587(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_applySandboxSecurityContext321 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run applySandboxSecurityContext32(ds_network_podsLock,child_applySandboxSecurityContext321);
	child_applySandboxSecurityContext321?0;
	

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
	chan child_modifySandboxNamespaceOptions1501 = [1] of {int};
	

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
	run modifySandboxNamespaceOptions150(network_podsLock,child_modifySandboxNamespaceOptions1501);
	child_modifySandboxNamespaceOptions1501?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype modifySandboxNamespaceOptions150(Mutexdef network_podsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_modifyHostOptionsForSandbox1721 = [1] of {int};
	run modifyHostOptionsForSandbox172(network_podsLock,child_modifyHostOptionsForSandbox1721);
	child_modifyHostOptionsForSandbox1721?0;
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
proctype applySandboxResources601(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GenerateExpectedCgroupParent4682 = [1] of {int};
	

	if
	:: true -> 
		run GenerateExpectedCgroupParent468(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_GenerateExpectedCgroupParent4682);
		child_GenerateExpectedCgroupParent4682?0;
		

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
proctype GenerateExpectedCgroupParent468(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getSandBoxSecurityOpts40(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype setNetworkReady72(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ds_networkReadyLock.Lock!false;
	stop_process: skip;
		ds_networkReadyLock.Unlock!false;
	child!0
}
proctype PodSandboxStatus421(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getIPs3644 = [1] of {int};
	chan child_determinePodIPBySandboxID543 = [1] of {int};
	chan child_getPodSandboxDetails4062 = [1] of {int};
	run getPodSandboxDetails406(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getPodSandboxDetails4062);
	child_getPodSandboxDetails4062?0;
	

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
	run determinePodIPBySandboxID54(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_determinePodIPBySandboxID543);
	child_determinePodIPBySandboxID543?0;
	

	if
	:: true -> 
		run getIPs364(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getIPs3644);
		child_getIPs3644?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getPodSandboxDetails406(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
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
proctype determinePodIPBySandboxID54(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getIPs364(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getIPsFromPlugin3355 = [1] of {int};
	chan child_getNetworkReady654 = [1] of {int};
	

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
	run getNetworkReady65(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getNetworkReady654);
	child_getNetworkReady654?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getIPsFromPlugin335(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getIPsFromPlugin3355);
	child_getIPsFromPlugin3355?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getNetworkReady65(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ds_networkReadyLock.Lock!false;
	goto stop_process;
	stop_process: skip;
		ds_networkReadyLock.Unlock!false;
	child!0
}
proctype getIPsFromPlugin335(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
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
proctype ListPodSandbox490(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
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

