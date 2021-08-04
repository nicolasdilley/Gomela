// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/kubelet/dockershim/docker_service_test.go#L167
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAPIVersionWithCache1670 = [1] of {int};
	run TestAPIVersionWithCache167(child_TestAPIVersionWithCache1670);
	run receiver(child_TestAPIVersionWithCache1670)
stop_process:skip
}

proctype TestAPIVersionWithCache167(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getDockerAPIVersion5050 = [1] of {int};
	Mutexdef ds_cleanupInfosLock;
	Mutexdef ds_networkReadyLock;
	Mutexdef ds_network_podsLock;
	run mutexMonitor(ds_network_podsLock);
	run mutexMonitor(ds_networkReadyLock);
	run mutexMonitor(ds_cleanupInfosLock);
	run getDockerAPIVersion505(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_getDockerAPIVersion5050);
	child_getDockerAPIVersion5050?0;
	stop_process: skip;
	child!0
}
proctype getDockerAPIVersion505(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getDockerVersionFromCache5240 = [1] of {int};
	chan child_getDockerVersion3411 = [1] of {int};
	

	if
	:: true -> 
		run getDockerVersionFromCache524(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_getDockerVersionFromCache5240);
		child_getDockerVersionFromCache5240?0
	:: true -> 
		run getDockerVersion341(ds_cleanupInfosLock,ds_network_podsLock,ds_networkReadyLock,child_getDockerVersion3411);
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
proctype getDockerVersionFromCache524(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
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
proctype getDockerVersion341(Mutexdef ds_cleanupInfosLock;Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;chan child) {
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

proctype receiver(chan c) {
c?0
}

