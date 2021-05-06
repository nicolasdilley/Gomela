
// https://github.com/kubernetes/kubernetes/blob/master/test/e2e/framework/providers/gce/ingress.go#L205
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ListTargetHTTPProxies2050 = [1] of {int};
	run ListTargetHTTPProxies205(child_ListTargetHTTPProxies2050)
stop_process:skip
}

proctype ListTargetHTTPProxies205(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ListTargetHTTPProxies2050 = [1] of {int};
	Mutexdef gceCloud_sharedResourceLock;
	Mutexdef gceCloud_nodeZonesLock;
	Mutexdef gceCloud_computeNodeTagLock;
	Mutexdef gceCloud_subnetworkURLAndIsLegacyNetworkInitializer_m;
	Mutexdef gceCloud_ClusterID_idLock;
	run mutexMonitor(gceCloud_ClusterID_idLock);
	run mutexMonitor(gceCloud_subnetworkURLAndIsLegacyNetworkInitializer_m);
	run mutexMonitor(gceCloud_computeNodeTagLock);
	run mutexMonitor(gceCloud_nodeZonesLock);
	run mutexMonitor(gceCloud_sharedResourceLock);
	run ListTargetHTTPProxies205(gceCloud_ClusterID_idLock,gceCloud_subnetworkURLAndIsLegacyNetworkInitializer_m,gceCloud_computeNodeTagLock,gceCloud_nodeZonesLock,gceCloud_sharedResourceLock,child_ListTargetHTTPProxies2050);
	child_ListTargetHTTPProxies2050?0;
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

