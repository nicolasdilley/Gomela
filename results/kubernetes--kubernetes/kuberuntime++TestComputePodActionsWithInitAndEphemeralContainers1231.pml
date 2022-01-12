// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob//pkg/kubelet/kuberuntime/kuberuntime_manager_test.go#L1231
#define not_found_124726  -2
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestComputePodActionsWithInitAndEphemeralContainers12310 = [1] of {int};
	run TestComputePodActionsWithInitAndEphemeralContainers1231(child_TestComputePodActionsWithInitAndEphemeralContainers12310);
	run receiver(child_TestComputePodActionsWithInitAndEphemeralContainers12310)
stop_process:skip
}

proctype TestComputePodActionsWithInitAndEphemeralContainers1231(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_computePodActions5160 = [1] of {int};
	chan child_computePodActions5161 = [1] of {int};
	Mutexdef m_logReduction_errorMapLock;
	run mutexMonitor(m_logReduction_errorMapLock);
	

	if
	:: not_found_124726-1 != -3 -> 
				for(i : 0.. not_found_124726-1) {
			for10: skip;
			run computePodActions516(m_logReduction_errorMapLock,child_computePodActions5160);
			child_computePodActions5160?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for19: skip;
			run computePodActions516(m_logReduction_errorMapLock,child_computePodActions5161);
			child_computePodActions5161?0;
			for19_end: skip
		:: true -> 
			break
		od;
		for19_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype computePodActions516(Mutexdef m_logReduction_errorMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_podSandboxChanged4580 = [1] of {int};
	int var_pod_Spec_EphemeralContainers = -2; // opt var_pod_Spec_EphemeralContainers
	int var_pod_Spec_Containers = -2; // opt var_pod_Spec_Containers
	run podSandboxChanged458(m_logReduction_errorMapLock,child_podSandboxChanged4580);
	child_podSandboxChanged4580?0;
	

	if
	:: true -> 
		

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
proctype podSandboxChanged458(Mutexdef m_logReduction_errorMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_podStatus_SandboxStatuses = -2; // opt var_podStatus_SandboxStatuses
	

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

proctype receiver(chan c) {
c?0
}

