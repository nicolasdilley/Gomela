// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/physical/aerospike/aerospike.go#L41
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
	run NewAerospikeBackend41(child_NewAerospikeBackend410);
	run receiver(child_NewAerospikeBackend410)
stop_process:skip
}

proctype NewAerospikeBackend41(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_buildAerospikeClient660 = [1] of {int};
	Wgdef client_cluster_wgTend;
	Mutexdef client_cluster_statsLock;
	Mutexdef policy_TlsConfig_mutex;
	run mutexMonitor(policy_TlsConfig_mutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(client_cluster_statsLock);
	run wgMonitor(client_cluster_wgTend);
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

proctype receiver(chan c) {
c?0
}

