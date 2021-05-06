
// https://github.com/kubernetes/kubernetes/blob/master/pkg/volume/gcepd/gce_util.go#L77
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_DeleteVolume770 = [1] of {int};
	run DeleteVolume77(child_DeleteVolume770)
stop_process:skip
}

proctype DeleteVolume77(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DeleteDisk6080 = [1] of {int};
	Mutexdef cloud_sharedResourceLock;
	Mutexdef cloud_nodeZonesLock;
	Mutexdef cloud_computeNodeTagLock;
	Mutexdef cloud_subnetworkURLAndIsLegacyNetworkInitializer_m;
	Mutexdef cloud_ClusterID_idLock;
	run mutexMonitor(cloud_ClusterID_idLock);
	run mutexMonitor(cloud_subnetworkURLAndIsLegacyNetworkInitializer_m);
	run mutexMonitor(cloud_computeNodeTagLock);
	run mutexMonitor(cloud_nodeZonesLock);
	run mutexMonitor(cloud_sharedResourceLock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run DeleteDisk608(cloud_ClusterID_idLock,cloud_subnetworkURLAndIsLegacyNetworkInitializer_m,cloud_computeNodeTagLock,cloud_nodeZonesLock,cloud_sharedResourceLock,child_DeleteDisk6080);
	child_DeleteDisk6080?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DeleteDisk608(Mutexdef testcase_ClusterID_idLock;Mutexdef testcase_subnetworkURLAndIsLegacyNetworkInitializer_m;Mutexdef testcase_computeNodeTagLock;Mutexdef testcase_nodeZonesLock;Mutexdef testcase_sharedResourceLock;chan child) {
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

