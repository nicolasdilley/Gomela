
// https://github.com/kubernetes/kubernetes/blob/master/pkg/volume/vsphere_volume/attacher.go#L260
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewDetacher2600 = [1] of {int};
	run NewDetacher260(child_NewDetacher2600)
stop_process:skip
}

proctype NewDetacher260(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef vsphereCloud_nodeManager_credentialManagerLock;
	Mutexdef vsphereCloud_nodeManager_nodeInfoLock;
	Mutexdef vsphereCloud_nodeManager_registeredNodesLock;
	Mutexdef vsphereCloud_nodeManager_credentialManager_Cache_cacheLock;
	Mutexdef vsphereCloud_vsphereVolumeMap_lock;
	run mutexMonitor(vsphereCloud_vsphereVolumeMap_lock);
	run mutexMonitor(vsphereCloud_nodeManager_credentialManager_Cache_cacheLock);
	run mutexMonitor(vsphereCloud_nodeManager_registeredNodesLock);
	run mutexMonitor(vsphereCloud_nodeManager_nodeInfoLock);
	run mutexMonitor(vsphereCloud_nodeManager_credentialManagerLock);
	

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

