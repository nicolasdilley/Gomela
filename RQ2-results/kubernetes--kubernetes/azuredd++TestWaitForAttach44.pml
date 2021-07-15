
// https://github.com/kubernetes/kubernetes/blob/master/pkg/volume/azuredd/attacher_test.go#L44
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestWaitForAttach440 = [1] of {int};
	run TestWaitForAttach44(child_TestWaitForAttach440)
stop_process:skip
}

proctype TestWaitForAttach44(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WaitForAttach1380 = [1] of {int};
	chan child_WaitForAttach1381 = [1] of {int};
	Mutexdef attacher_cloud_rtCache_Lock;
	Mutexdef attacher_cloud_nsgCache_Lock;
	Mutexdef attacher_cloud_lbCache_Lock;
	Mutexdef attacher_cloud_vmCache_Lock;
	Mutexdef attacher_cloud_routeUpdater_lock;
	Mutexdef attacher_cloud_routeCIDRsLock;
	Mutexdef attacher_cloud_nodeCachesLock;
	Mutexdef attacher_cloud_metadata_imsCache_Lock;
	int tests = -2;
	run mutexMonitor(attacher_cloud_metadata_imsCache_Lock);
	run mutexMonitor(attacher_cloud_nodeCachesLock);
	run mutexMonitor(attacher_cloud_routeCIDRsLock);
	run mutexMonitor(attacher_cloud_routeUpdater_lock);
	run mutexMonitor(attacher_cloud_vmCache_Lock);
	run mutexMonitor(attacher_cloud_lbCache_Lock);
	run mutexMonitor(attacher_cloud_nsgCache_Lock);
	run mutexMonitor(attacher_cloud_rtCache_Lock);
	

	if
	:: tests-1 != -3 -> 
				for(i : 0.. tests-1) {
			for10: skip;
			run WaitForAttach138(attacher_cloud_metadata_imsCache_Lock,attacher_cloud_nodeCachesLock,attacher_cloud_routeCIDRsLock,attacher_cloud_routeUpdater_lock,attacher_cloud_vmCache_Lock,attacher_cloud_lbCache_Lock,attacher_cloud_nsgCache_Lock,attacher_cloud_rtCache_Lock,child_WaitForAttach1380);
			child_WaitForAttach1380?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run WaitForAttach138(attacher_cloud_metadata_imsCache_Lock,attacher_cloud_nodeCachesLock,attacher_cloud_routeCIDRsLock,attacher_cloud_routeUpdater_lock,attacher_cloud_vmCache_Lock,attacher_cloud_lbCache_Lock,attacher_cloud_nsgCache_Lock,attacher_cloud_rtCache_Lock,child_WaitForAttach1381);
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
proctype WaitForAttach138(Mutexdef a_cloud_metadata_imsCache_Lock;Mutexdef a_cloud_nodeCachesLock;Mutexdef a_cloud_routeCIDRsLock;Mutexdef a_cloud_routeUpdater_lock;Mutexdef a_cloud_vmCache_Lock;Mutexdef a_cloud_lbCache_Lock;Mutexdef a_cloud_nsgCache_Lock;Mutexdef a_cloud_rtCache_Lock;chan child) {
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

