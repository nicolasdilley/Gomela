// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/kubelet/dockershim/docker_sandbox_test.go#L59
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestListSandboxes590 = [1] of {int};
	run TestListSandboxes59(child_TestListSandboxes590);
	run receiver(child_TestListSandboxes590)
stop_process:skip
}

proctype TestListSandboxes59(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ListPodSandbox4902 = [1] of {int};
	chan child_RunPodSandbox890 = [1] of {int};
	chan child_RunPodSandbox891 = [1] of {int};
	Mutexdef ds_cleanupInfosLock;
	Mutexdef ds_networkReadyLock;
	Mutexdef ds_network_podsLock;
	int var_configsconfigs = -2; // opt var_configsconfigs
	run mutexMonitor(ds_network_podsLock);
	run mutexMonitor(ds_networkReadyLock);
	run mutexMonitor(ds_cleanupInfosLock);
	

	if
	:: var_configs-1 != -3 -> 
				for(i : 0.. var_configs-1) {
			for20: skip;
			run RunPodSandbox89(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_RunPodSandbox890);
			child_RunPodSandbox890?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			run RunPodSandbox89(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_RunPodSandbox891);
			child_RunPodSandbox891?0;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	run ListPodSandbox490(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_ListPodSandbox4902);
	child_ListPodSandbox4902?0;
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
proctype ListPodSandbox490(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_checkpointscheckpoints = -2; // opt var_checkpointscheckpoints
	int var_containerscontainers = -2; // opt var_containerscontainers
	int var_filter_LabelSelectorfilter_LabelSelector = -2; // opt var_filter_LabelSelectorfilter_LabelSelector
	

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

