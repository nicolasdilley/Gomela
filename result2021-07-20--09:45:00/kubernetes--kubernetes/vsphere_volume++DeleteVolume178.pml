// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/volume/vsphere_volume/vsphere_volume_util.go#L178
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_DeleteVolume1780 = [1] of {int};
	run DeleteVolume178(child_DeleteVolume1780);
	run receiver(child_DeleteVolume1780)
stop_process:skip
}

proctype DeleteVolume178(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DeleteVolume1780 = [1] of {int};
	Mutexdef cloud_nodeManager_credentialManagerLock;
	Mutexdef cloud_nodeManager_nodeInfoLock;
	Mutexdef cloud_nodeManager_registeredNodesLock;
	Mutexdef cloud_vsphereVolumeMap_lock;
	run mutexMonitor(cloud_vsphereVolumeMap_lock);
	run mutexMonitor(cloud_nodeManager_registeredNodesLock);
	run mutexMonitor(cloud_nodeManager_nodeInfoLock);
	run mutexMonitor(cloud_nodeManager_credentialManagerLock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run DeleteVolume178(cloud_nodeManager_credentialManagerLock,cloud_nodeManager_nodeInfoLock,cloud_nodeManager_registeredNodesLock,cloud_vsphereVolumeMap_lock,child_DeleteVolume1780);
	child_DeleteVolume1780?0;
	

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

