#define not_found_386  -2
#define not_found_{{descriptioncontainerspolicyremainevictTerminatedPodsallSourcesReady}{descriptioncontainerspolicyremainevictTerminatedPodsallSourcesReady}{descriptioncontainerspolicyremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}}20723  -2

// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/kuberuntime/kuberuntime_gc_test.go#L200
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContainerGC2000 = [1] of {int};
	run TestContainerGC200(child_TestContainerGC2000)
stop_process:skip
}

proctype TestContainerGC200(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_makeFakeContainers1840 = [1] of {int};
	chan child_makeFakeContainers1841 = [1] of {int};
	Mutexdef m_logReduction_errorMapLock;
	run mutexMonitor(m_logReduction_errorMapLock);
	

	if
	:: not_found_{{descriptioncontainerspolicyremainevictTerminatedPodsallSourcesReady}{descriptioncontainerspolicyremainevictTerminatedPodsallSourcesReady}{descriptioncontainerspolicyremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}}20723-1 != -3 -> 
				for(i : 0.. not_found_{{descriptioncontainerspolicyremainevictTerminatedPodsallSourcesReady}{descriptioncontainerspolicyremainevictTerminatedPodsallSourcesReady}{descriptioncontainerspolicyremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}{descriptioncontainersremainevictTerminatedPodsallSourcesReady}}20723-1) {
			for10: skip;
			run makeFakeContainers184(m_logReduction_errorMapLock,not_found_386,child_makeFakeContainers1840);
			child_makeFakeContainers1840?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for117: skip;
			run makeFakeContainers184(m_logReduction_errorMapLock,not_found_386,child_makeFakeContainers1841);
			child_makeFakeContainers1841?0;
			for117_end: skip
		:: true -> 
			break
		od;
		for117_exit: skip
	fi;
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
			for11: skip;
			run makeFakeContainer156(m_logReduction_errorMapLock,child_makeFakeContainer1560);
			child_makeFakeContainer1560?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for114: skip;
			run makeFakeContainer156(m_logReduction_errorMapLock,child_makeFakeContainer1561);
			child_makeFakeContainer1561?0;
			for114_end: skip
		:: true -> 
			break
		od;
		for114_exit: skip
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

