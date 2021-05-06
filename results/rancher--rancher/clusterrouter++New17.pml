
// https://github.com/rancher/rancher/blob/master/pkg/clusterrouter/router.go#L17
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_New170 = [1] of {int};
	run New17(child_New170)
stop_process:skip
}

proctype New17(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef serverFactory_servers_mu;
	Mutexdef serverFactory_serverLock_mu;
	Mutexdef serverFactory_clusters_mu;
	run mutexMonitor(serverFactory_clusters_mu);
	run mutexMonitor(serverFactory_serverLock_mu);
	run mutexMonitor(serverFactory_servers_mu);
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

