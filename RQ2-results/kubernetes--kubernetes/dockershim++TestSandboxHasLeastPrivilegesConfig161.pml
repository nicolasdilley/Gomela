
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/dockershim/docker_sandbox_test.go#L161
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSandboxHasLeastPrivilegesConfig1610 = [1] of {int};
	run TestSandboxHasLeastPrivilegesConfig161(child_TestSandboxHasLeastPrivilegesConfig1610)
stop_process:skip
}

proctype TestSandboxHasLeastPrivilegesConfig161(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_makeSandboxDockerConfig6200 = [1] of {int};
	Mutexdef ds_cleanupInfosLock;
	Mutexdef ds_networkReadyLock;
	Mutexdef ds_network_podsLock;
	run mutexMonitor(ds_network_podsLock);
	run mutexMonitor(ds_networkReadyLock);
	run mutexMonitor(ds_cleanupInfosLock);
	run makeSandboxDockerConfig620(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_makeSandboxDockerConfig6200);
	child_makeSandboxDockerConfig6200?0;
	stop_process: skip;
	child!0
}
proctype makeSandboxDockerConfig620(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getSandBoxSecurityOpts402 = [1] of {int};
	chan child_applySandboxResources6011 = [1] of {int};
	chan child_applySandboxLinuxOptions5870 = [1] of {int};
	run applySandboxLinuxOptions587(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_applySandboxLinuxOptions5870);
	child_applySandboxLinuxOptions5870?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run applySandboxResources601(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_applySandboxResources6011);
	child_applySandboxResources6011?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getSandBoxSecurityOpts40(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getSandBoxSecurityOpts402);
	child_getSandBoxSecurityOpts402?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype applySandboxLinuxOptions587(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
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
proctype applySandboxResources601(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GenerateExpectedCgroupParent4681 = [1] of {int};
	

	if
	:: true -> 
		run GenerateExpectedCgroupParent468(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_GenerateExpectedCgroupParent4681);
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

