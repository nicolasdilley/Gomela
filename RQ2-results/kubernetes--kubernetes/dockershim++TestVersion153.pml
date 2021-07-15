
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/dockershim/docker_service_test.go#L153
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestVersion1530 = [1] of {int};
	run TestVersion153(child_TestVersion1530)
stop_process:skip
}

proctype TestVersion153(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getDockerAPIVersion5051 = [1] of {int};
	chan child_getDockerVersion3410 = [1] of {int};
	Mutexdef ds_cleanupInfosLock;
	Mutexdef ds_networkReadyLock;
	Mutexdef ds_network_podsLock;
	run mutexMonitor(ds_network_podsLock);
	run mutexMonitor(ds_networkReadyLock);
	run mutexMonitor(ds_cleanupInfosLock);
	run getDockerVersion341(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getDockerVersion3410);
	child_getDockerVersion3410?0;
	run getDockerAPIVersion505(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getDockerAPIVersion5051);
	child_getDockerAPIVersion5051?0;
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
proctype getDockerAPIVersion505(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getDockerVersionFromCache5241 = [1] of {int};
	chan child_getDockerVersion3412 = [1] of {int};
	

	if
	:: true -> 
		run getDockerVersionFromCache524(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getDockerVersionFromCache5241);
		child_getDockerVersionFromCache5241?0
	:: true -> 
		run getDockerVersion341(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_getDockerVersion3412);
		child_getDockerVersion3412?0
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

