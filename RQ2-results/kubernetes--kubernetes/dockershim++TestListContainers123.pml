
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/dockershim/docker_container_test.go#L123
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestListContainers1230 = [1] of {int};
	run TestListContainers123(child_TestListContainers1230)
stop_process:skip
}

proctype TestListContainers123(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ListContainers394 = [1] of {int};
	chan child_StartContainer2861 = [1] of {int};
	chan child_CreateContainer1090 = [1] of {int};
	chan child_StartContainer2863 = [1] of {int};
	chan child_CreateContainer1092 = [1] of {int};
	Mutexdef ds_cleanupInfosLock;
	Mutexdef ds_networkReadyLock;
	Mutexdef ds_network_podsLock;
	int configs = -2;
	run mutexMonitor(ds_network_podsLock);
	run mutexMonitor(ds_networkReadyLock);
	run mutexMonitor(ds_cleanupInfosLock);
	

	if
	:: configs-1 != -3 -> 
				for(i : 0.. configs-1) {
			for20: skip;
			run CreateContainer109(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_CreateContainer1090);
			child_CreateContainer1090?0;
			run StartContainer286(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_StartContainer2861);
			child_StartContainer2861?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for27: skip;
			run CreateContainer109(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_CreateContainer1092);
			child_CreateContainer1092?0;
			run StartContainer286(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_StartContainer2863);
			child_StartContainer2863?0;
			for27_end: skip
		:: true -> 
			break
		od;
		for27_exit: skip
	fi;
	run ListContainers39(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_ListContainers394);
	child_ListContainers394?0;
	stop_process: skip;
	child!0
}
proctype CreateContainer109(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_performPlatformSpecificContainerCleanupAndLogErrors4965 = [1] of {int};
	chan child_setContainerCleanupInfo934 = [1] of {int};
	chan child_applyPlatformSpecificDockerConfig313 = [1] of {int};
	chan child_getSecurityOpts352 = [1] of {int};
	chan child_updateCreateConfig451 = [1] of {int};
	chan child_getDockerAPIVersion5050 = [1] of {int};
	

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
	run getDockerAPIVersion505(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getDockerAPIVersion5050);
	child_getDockerAPIVersion5050?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run updateCreateConfig45(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_updateCreateConfig451);
	child_updateCreateConfig451?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getSecurityOpts35(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getSecurityOpts352);
	child_getSecurityOpts352?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run applyPlatformSpecificDockerConfig31(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_applyPlatformSpecificDockerConfig313);
	child_applyPlatformSpecificDockerConfig313?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run setContainerCleanupInfo93(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_setContainerCleanupInfo934);
			child_setContainerCleanupInfo934?0
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	run performPlatformSpecificContainerCleanupAndLogErrors496(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_performPlatformSpecificContainerCleanupAndLogErrors4965);
	child_performPlatformSpecificContainerCleanupAndLogErrors4965?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getDockerAPIVersion505(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getDockerVersionFromCache5240 = [1] of {int};
	chan child_getDockerVersion3411 = [1] of {int};
	

	if
	:: true -> 
		run getDockerVersionFromCache524(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getDockerVersionFromCache5240);
		child_getDockerVersionFromCache5240?0
	:: true -> 
		run getDockerVersion341(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getDockerVersion3411);
		child_getDockerVersion3411?0
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
proctype getDockerVersionFromCache524(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
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
proctype getDockerVersion341(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
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
proctype updateCreateConfig45(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getSecurityOpts35(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype applyPlatformSpecificDockerConfig31(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype setContainerCleanupInfo93(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ds_cleanupInfosLock.Lock!false;
	stop_process: skip;
		ds_cleanupInfosLock.Unlock!false;
	child!0
}
proctype performPlatformSpecificContainerCleanupAndLogErrors496(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_performPlatformSpecificContainerCleanup375 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run performPlatformSpecificContainerCleanup37(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_performPlatformSpecificContainerCleanup375);
	child_performPlatformSpecificContainerCleanup375?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype performPlatformSpecificContainerCleanup37(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype StartContainer286(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_createContainerLogSymlink2311 = [1] of {int};
	run createContainerLogSymlink231(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_createContainerLogSymlink2311);
	child_createContainerLogSymlink2311?0;
	

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
proctype createContainerLogSymlink231(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsCRISupportedLogDriver1202 = [1] of {int};
	chan child_getContainerLogPath2221 = [1] of {int};
	run getContainerLogPath222(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getContainerLogPath2221);
	child_getContainerLogPath2221?0;
	

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
		fi
	:: true -> 
		run IsCRISupportedLogDriver120(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_IsCRISupportedLogDriver1202);
		child_IsCRISupportedLogDriver1202?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getContainerLogPath222(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
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
proctype IsCRISupportedLogDriver120(Mutexdef d_network_podsLock;Mutexdef d_networkReadyLock;Mutexdef d_cleanupInfosLock;chan child) {
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
proctype ListContainers39(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
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

