// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/volume/azuredd/attacher_test.go#L44
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestWaitForAttach440 = [1] of {int};
	run TestWaitForAttach44(child_TestWaitForAttach440);
	run receiver(child_TestWaitForAttach440)
stop_process:skip
}

proctype TestWaitForAttach44(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WaitForAttach1380 = [1] of {int};
	chan child_WaitForAttach1381 = [1] of {int};
	Mutexdef attacher_cloud_routeCIDRsLock;
	Mutexdef attacher_cloud_nodeCachesLock;
	int var_teststests = -2; // opt var_teststests
	run mutexMonitor(attacher_cloud_nodeCachesLock);
	run mutexMonitor(attacher_cloud_routeCIDRsLock);
	

	if
	:: var_tests-1 != -3 -> 
				for(i : 0.. var_tests-1) {
			for10: skip;
			run WaitForAttach138(attacher_cloud_nodeCachesLock,attacher_cloud_routeCIDRsLock,child_WaitForAttach1380);
			child_WaitForAttach1380?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run WaitForAttach138(attacher_cloud_nodeCachesLock,attacher_cloud_routeCIDRsLock,child_WaitForAttach1381);
			child_WaitForAttach1381?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype WaitForAttach138(Mutexdef a_cloud_nodeCachesLock;Mutexdef a_cloud_routeCIDRsLock;chan child) {
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

