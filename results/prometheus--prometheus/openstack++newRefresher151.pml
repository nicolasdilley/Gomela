
// https://github.com/prometheus/prometheus/blob/master/discovery/openstack/openstack.go#L151
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newRefresher1510 = [1] of {int};
	run newRefresher151(child_newRefresher1510)
stop_process:skip
}

proctype newRefresher151(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newHypervisorDiscovery520 = [1] of {int};
	chan child_newInstanceDiscovery611 = [1] of {int};
	Mutexdef tls_mutex;
	Mutexdef client_mut;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	run mutexMonitor(client_mut);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(tls_mutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run newHypervisorDiscovery52(client_mut,child_newHypervisorDiscovery520);
		child_newHypervisorDiscovery520?0;
		goto stop_process
	:: true -> 
		run newInstanceDiscovery61(client_mut,child_newInstanceDiscovery611);
		child_newInstanceDiscovery611?0;
		goto stop_process
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newHypervisorDiscovery52(Mutexdef provider_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newInstanceDiscovery61(Mutexdef provider_mut;chan child) {
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

