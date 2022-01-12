// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//gossip/election/adapter_test.go#L47
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAdapterImpl_CreateMessage470 = [1] of {int};
	run TestAdapterImpl_CreateMessage47(child_TestAdapterImpl_CreateMessage470);
	run receiver(child_TestAdapterImpl_CreateMessage470)
stop_process:skip
}

proctype TestAdapterImpl_CreateMessage47(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewAdapter800 = [1] of {int};
	Mutexdef mockGossip_clusterLock;
	Mutexdef mockGossip_acceptorLock;
	Mutexdef mockGossip_cluster_peersLock;
	run mutexMonitor(mockGossip_cluster_peersLock);
	run mutexMonitor(mockGossip_acceptorLock);
	run mutexMonitor(mockGossip_clusterLock);
	run NewAdapter80(mockGossip_acceptorLock,mockGossip_cluster_peersLock,mockGossip_clusterLock,child_NewAdapter800);
	child_NewAdapter800?0;
	stop_process: skip;
	child!0
}
proctype NewAdapter80(Mutexdef gossip_acceptorLock;Mutexdef gossip_cluster_peersLock;Mutexdef gossip_clusterLock;chan child) {
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

proctype receiver(chan c) {
c?0
}

