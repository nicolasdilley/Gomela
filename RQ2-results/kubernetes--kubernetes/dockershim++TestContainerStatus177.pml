
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/dockershim/docker_container_test.go#L177
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContainerStatus1770 = [1] of {int};
	run TestContainerStatus177(child_TestContainerStatus1770)
stop_process:skip
}

proctype TestContainerStatus177(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ContainerStatus3567 = [1] of {int};
	chan child_RemoveContainer3166 = [1] of {int};
	chan child_ContainerStatus3565 = [1] of {int};
	chan child_StopContainer3074 = [1] of {int};
	chan child_ContainerStatus3563 = [1] of {int};
	chan child_StartContainer2862 = [1] of {int};
	chan child_ContainerStatus3561 = [1] of {int};
	chan child_CreateContainer1090 = [1] of {int};
	Mutexdef ds_cleanupInfosLock;
	Mutexdef ds_networkReadyLock;
	Mutexdef ds_network_podsLock;
	run mutexMonitor(ds_network_podsLock);
	run mutexMonitor(ds_networkReadyLock);
	run mutexMonitor(ds_cleanupInfosLock);
	run CreateContainer109(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_CreateContainer1090);
	child_CreateContainer1090?0;
	run ContainerStatus356(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_ContainerStatus3561);
	child_ContainerStatus3561?0;
	run StartContainer286(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_StartContainer2862);
	child_StartContainer2862?0;
	run ContainerStatus356(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_ContainerStatus3563);
	child_ContainerStatus3563?0;
	run StopContainer307(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_StopContainer3074);
	child_StopContainer3074?0;
	run ContainerStatus356(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_ContainerStatus3565);
	child_ContainerStatus3565?0;
	run RemoveContainer316(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_RemoveContainer3166);
	child_RemoveContainer3166?0;
	run ContainerStatus356(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_ContainerStatus3567);
	child_ContainerStatus3567?0;
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
proctype ContainerStatus356(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true;
			:: true;
			:: true;
			fi
		fi
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
proctype StartContainer286(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_createContainerLogSymlink2312 = [1] of {int};
	run createContainerLogSymlink231(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_createContainerLogSymlink2312);
	child_createContainerLogSymlink2312?0;
	

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
	chan child_IsCRISupportedLogDriver1203 = [1] of {int};
	chan child_getContainerLogPath2222 = [1] of {int};
	run getContainerLogPath222(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getContainerLogPath2222);
	child_getContainerLogPath2222?0;
	

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
		run IsCRISupportedLogDriver120(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_IsCRISupportedLogDriver1203);
		child_IsCRISupportedLogDriver1203?0;
		

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
proctype StopContainer307(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
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
proctype RemoveContainer316(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_performPlatformSpecificContainerForContainer4847 = [1] of {int};
	chan child_removeContainerLogSymlink2706 = [1] of {int};
	run removeContainerLogSymlink270(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_removeContainerLogSymlink2706);
	child_removeContainerLogSymlink2706?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run performPlatformSpecificContainerForContainer484(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_performPlatformSpecificContainerForContainer4847);
	child_performPlatformSpecificContainerForContainer4847?0;
	

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
proctype removeContainerLogSymlink270(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getContainerLogPath2226 = [1] of {int};
	run getContainerLogPath222(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getContainerLogPath2226);
	child_getContainerLogPath2226?0;
	

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
proctype performPlatformSpecificContainerForContainer484(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_clearContainerCleanupInfo999 = [1] of {int};
	chan child_performPlatformSpecificContainerCleanupAndLogErrors4968 = [1] of {int};
	chan child_getContainerCleanupInfo867 = [1] of {int};
	run getContainerCleanupInfo86(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getContainerCleanupInfo867);
	child_getContainerCleanupInfo867?0;
	

	if
	:: true -> 
		run performPlatformSpecificContainerCleanupAndLogErrors496(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_performPlatformSpecificContainerCleanupAndLogErrors4968);
		child_performPlatformSpecificContainerCleanupAndLogErrors4968?0;
		

		if
		:: true -> 
			run clearContainerCleanupInfo99(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_clearContainerCleanupInfo999);
			child_clearContainerCleanupInfo999?0
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getContainerCleanupInfo86(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ds_cleanupInfosLock.RLock!false;
	goto stop_process;
	stop_process: skip;
		ds_cleanupInfosLock.RUnlock!false;
	child!0
}
proctype clearContainerCleanupInfo99(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ds_cleanupInfosLock.Lock!false;
	stop_process: skip;
		ds_cleanupInfosLock.Unlock!false;
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

