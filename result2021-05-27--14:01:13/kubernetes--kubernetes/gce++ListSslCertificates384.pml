// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/test/e2e/framework/providers/gce/ingress.go#L384
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ListSslCertificates3840 = [1] of {int};
	run ListSslCertificates384(child_ListSslCertificates3840);
	run receiver(child_ListSslCertificates3840)
stop_process:skip
}

proctype ListSslCertificates384(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ListSslCertificates3840 = [1] of {int};
	Mutexdef gceCloud_sharedResourceLock;
	Mutexdef gceCloud_nodeZonesLock;
	Mutexdef gceCloud_computeNodeTagLock;
	Mutexdef gceCloud_subnetworkURLAndIsLegacyNetworkInitializer_m;
	Mutexdef gceCloud_ClusterID_idLock;
	int l = -2; // opt l
	run mutexMonitor(gceCloud_ClusterID_idLock);
	run mutexMonitor(gceCloud_subnetworkURLAndIsLegacyNetworkInitializer_m);
	run mutexMonitor(gceCloud_computeNodeTagLock);
	run mutexMonitor(gceCloud_nodeZonesLock);
	run mutexMonitor(gceCloud_sharedResourceLock);
	run ListSslCertificates384(gceCloud_ClusterID_idLock,gceCloud_computeNodeTagLock,gceCloud_nodeZonesLock,gceCloud_sharedResourceLock,gceCloud_subnetworkURLAndIsLegacyNetworkInitializer_m,child_ListSslCertificates3840);
	child_ListSslCertificates3840?0;
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

