
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/dockershim/docker_image_test.go#L88
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPullWithJSONError880 = [1] of {int};
	run TestPullWithJSONError88(child_TestPullWithJSONError880)
stop_process:skip
}

proctype TestPullWithJSONError88(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PullImage960 = [1] of {int};
	chan child_PullImage961 = [1] of {int};
	Mutexdef ds_cleanupInfosLock;
	Mutexdef ds_networkReadyLock;
	Mutexdef ds_network_podsLock;
	int tests = -2;
	run mutexMonitor(ds_network_podsLock);
	run mutexMonitor(ds_networkReadyLock);
	run mutexMonitor(ds_cleanupInfosLock);
	

	if
	:: tests-1 != -3 -> 
				for(i : 0.. tests-1) {
			for10: skip;
			run PullImage96(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_PullImage960);
			child_PullImage960?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run PullImage96(ds_network_podsLock,ds_networkReadyLock,ds_cleanupInfosLock,child_PullImage961);
			child_PullImage961?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype PullImage96(Mutexdef ds_network_podsLock;Mutexdef ds_networkReadyLock;Mutexdef ds_cleanupInfosLock;chan child) {
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

