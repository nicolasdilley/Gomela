
// https://github.com/hashicorp/vault/blob/master/physical/aerospike/aerospike.go#L41
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewAerospikeBackend410 = [1] of {int};
	run NewAerospikeBackend41(child_NewAerospikeBackend410)
stop_process:skip
}

proctype NewAerospikeBackend41(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_buildAerospikeClient660 = [1] of {int};
	Mutexdef client_cluster_password_lock;
	Wgdef client_cluster_wgTend;
	Mutexdef client_cluster_clientPolicy_TlsConfig_mutex;
	Mutexdef client_cluster_statsLock;
	Mutexdef client_cluster_nodes_lock;
	Mutexdef client_cluster_nodesMap_lock;
	Mutexdef client_cluster_aliases_lock;
	Mutexdef client_cluster_seeds_lock;
	Mutexdef policy_TlsConfig_mutex;
	run mutexMonitor(policy_TlsConfig_mutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(client_cluster_seeds_lock);
	run mutexMonitor(client_cluster_aliases_lock);
	run mutexMonitor(client_cluster_nodesMap_lock);
	run mutexMonitor(client_cluster_nodes_lock);
	run mutexMonitor(client_cluster_statsLock);
	run mutexMonitor(client_cluster_clientPolicy_TlsConfig_mutex);
	run wgMonitor(client_cluster_wgTend);
	run mutexMonitor(client_cluster_password_lock);
	run buildAerospikeClient66(policy_TlsConfig_mutex,child_buildAerospikeClient660);
	child_buildAerospikeClient660?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype buildAerospikeClient66(Mutexdef policy_TlsConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
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
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

