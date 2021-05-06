#define not_found_{"everying is good; do nothing""start pod sandbox and all containers for a new pod""restart exited containers if RestartPolicy == Always""restart failed containers if RestartPolicy == OnFailure""don't restart containers if RestartPolicy == Never""Kill pod and recreate everything if the pod sandbox is dead, and RestartPolicy == Always""Kill pod and recreate all containers (except for the succeeded one) if the pod sandbox is dead, and RestartPolicy == OnFailure""Kill pod and recreate all containers if the PodSandbox does not have an IP""Kill and recreate the container if the container's spec changed""Kill and recreate the container if the liveness check has failed""Kill and recreate the container if the startup check has failed""Verify we do not create a pod sandbox if no ready sandbox for pod with RestartPolicy=Never and all containers exited""Verify we do not create a pod sandbox if no ready sandbox for pod with RestartPolicy=OnFailure and all containers succeeded""Verify we create a pod sandbox if no ready sandbox for pod with RestartPolicy=Never and no containers have ever been created""Kill and recreate the container if the container is in unknown state"}73226  -2

// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/kuberuntime/kuberuntime_manager_test.go#L719
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestComputePodActions7190 = [1] of {int};
	run TestComputePodActions719(child_TestComputePodActions7190)
stop_process:skip
}

proctype TestComputePodActions719(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_computePodActions5160 = [1] of {int};
	chan child_computePodActions5161 = [1] of {int};
	Mutexdef m_logReduction_errorMapLock;
	run mutexMonitor(m_logReduction_errorMapLock);
	

	if
	:: not_found_{"everying is good; do nothing""start pod sandbox and all containers for a new pod""restart exited containers if RestartPolicy == Always""restart failed containers if RestartPolicy == OnFailure""don't restart containers if RestartPolicy == Never""Kill pod and recreate everything if the pod sandbox is dead, and RestartPolicy == Always""Kill pod and recreate all containers (except for the succeeded one) if the pod sandbox is dead, and RestartPolicy == OnFailure""Kill pod and recreate all containers if the PodSandbox does not have an IP""Kill and recreate the container if the container's spec changed""Kill and recreate the container if the liveness check has failed""Kill and recreate the container if the startup check has failed""Verify we do not create a pod sandbox if no ready sandbox for pod with RestartPolicy=Never and all containers exited""Verify we do not create a pod sandbox if no ready sandbox for pod with RestartPolicy=OnFailure and all containers succeeded""Verify we create a pod sandbox if no ready sandbox for pod with RestartPolicy=Never and no containers have ever been created""Kill and recreate the container if the container is in unknown state"}73226-1 != -3 -> 
				for(i : 0.. not_found_{"everying is good; do nothing""start pod sandbox and all containers for a new pod""restart exited containers if RestartPolicy == Always""restart failed containers if RestartPolicy == OnFailure""don't restart containers if RestartPolicy == Never""Kill pod and recreate everything if the pod sandbox is dead, and RestartPolicy == Always""Kill pod and recreate all containers (except for the succeeded one) if the pod sandbox is dead, and RestartPolicy == OnFailure""Kill pod and recreate all containers if the PodSandbox does not have an IP""Kill and recreate the container if the container's spec changed""Kill and recreate the container if the liveness check has failed""Kill and recreate the container if the startup check has failed""Verify we do not create a pod sandbox if no ready sandbox for pod with RestartPolicy=Never and all containers exited""Verify we do not create a pod sandbox if no ready sandbox for pod with RestartPolicy=OnFailure and all containers succeeded""Verify we create a pod sandbox if no ready sandbox for pod with RestartPolicy=Never and no containers have ever been created""Kill and recreate the container if the container is in unknown state"}73226-1) {
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

