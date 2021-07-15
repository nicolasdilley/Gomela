#define not_found_{"initialization completed; start all containers""initialization in progress; do nothing""Kill pod and restart the first init container if the pod sandbox is dead""initialization failed; restart the last init container if RestartPolicy == Always""initialization failed; restart the last init container if RestartPolicy == OnFailure""initialization failed; kill pod if RestartPolicy == Never""init container state unknown; kill and recreate the last init container if RestartPolicy == Always""init container state unknown; kill and recreate the last init container if RestartPolicy == OnFailure""init container state unknown; kill pod if RestartPolicy == Never""Pod sandbox not ready, init container failed, but RestartPolicy == Never; kill pod only""Pod sandbox not ready, and RestartPolicy == Never, but no visible init containers;  create a new pod sandbox""Pod sandbox not ready, init container failed, and RestartPolicy == OnFailure; create a new pod sandbox"}102826  -2

// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/kuberuntime/kuberuntime_manager_test.go#L1015
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestComputePodActionsWithInitContainers10150 = [1] of {int};
	run TestComputePodActionsWithInitContainers1015(child_TestComputePodActionsWithInitContainers10150)
stop_process:skip
}

proctype TestComputePodActionsWithInitContainers1015(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_computePodActions5160 = [1] of {int};
	chan child_computePodActions5161 = [1] of {int};
	Mutexdef m_logReduction_errorMapLock;
	run mutexMonitor(m_logReduction_errorMapLock);
	

	if
	:: not_found_{"initialization completed; start all containers""initialization in progress; do nothing""Kill pod and restart the first init container if the pod sandbox is dead""initialization failed; restart the last init container if RestartPolicy == Always""initialization failed; restart the last init container if RestartPolicy == OnFailure""initialization failed; kill pod if RestartPolicy == Never""init container state unknown; kill and recreate the last init container if RestartPolicy == Always""init container state unknown; kill and recreate the last init container if RestartPolicy == OnFailure""init container state unknown; kill pod if RestartPolicy == Never""Pod sandbox not ready, init container failed, but RestartPolicy == Never; kill pod only""Pod sandbox not ready, and RestartPolicy == Never, but no visible init containers;  create a new pod sandbox""Pod sandbox not ready, init container failed, and RestartPolicy == OnFailure; create a new pod sandbox"}102826-1 != -3 -> 
				for(i : 0.. not_found_{"initialization completed; start all containers""initialization in progress; do nothing""Kill pod and restart the first init container if the pod sandbox is dead""initialization failed; restart the last init container if RestartPolicy == Always""initialization failed; restart the last init container if RestartPolicy == OnFailure""initialization failed; kill pod if RestartPolicy == Never""init container state unknown; kill and recreate the last init container if RestartPolicy == Always""init container state unknown; kill and recreate the last init container if RestartPolicy == OnFailure""init container state unknown; kill pod if RestartPolicy == Never""Pod sandbox not ready, init container failed, but RestartPolicy == Never; kill pod only""Pod sandbox not ready, and RestartPolicy == Never, but no visible init containers;  create a new pod sandbox""Pod sandbox not ready, init container failed, and RestartPolicy == OnFailure; create a new pod sandbox"}102826-1) {
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

