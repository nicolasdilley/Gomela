// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kops/blob//protokube/pkg/gossip/memberlist/gossip.go#L48
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewMemberlistGossiper480 = [1] of {int};
	run NewMemberlistGossiper48(child_NewMemberlistGossiper480);
	run receiver(child_NewMemberlistGossiper480)
stop_process:skip
}

proctype NewMemberlistGossiper48(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef s_mtx;
	Mutexdef peer_peerLock;
	Mutexdef peer_mtx;
	Mutexdef peer_delegate_bcast_mu;
	Mutexdef peer_mlist_logger_mu;
	Mutexdef peer_mlist_broadcasts_mu;
	Mutexdef peer_mlist_ackLock;
	Mutexdef peer_mlist_tickerLock;
	Mutexdef peer_mlist_nodeLock;
	Mutexdef peer_mlist_msgQueueLock;
	Mutexdef peer_mlist_leaveLock;
	Mutexdef peer_mlist_shutdownLock;
	Mutexdef peer_mlist_config_Logger_mu;
	Mutexdef peer_mlist_config_Keyring_l;
	int var_initialPeers = -2; // opt var_initialPeers
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(peer_mlist_config_Keyring_l);
	run mutexMonitor(peer_mlist_config_Logger_mu);
	run mutexMonitor(peer_mlist_shutdownLock);
	run mutexMonitor(peer_mlist_leaveLock);
	run mutexMonitor(peer_mlist_msgQueueLock);
	run mutexMonitor(peer_mlist_nodeLock);
	run mutexMonitor(peer_mlist_tickerLock);
	run mutexMonitor(peer_mlist_ackLock);
	run mutexMonitor(peer_mlist_broadcasts_mu);
	run mutexMonitor(peer_mlist_logger_mu);
	run mutexMonitor(peer_delegate_bcast_mu);
	run mutexMonitor(peer_mtx);
	run mutexMonitor(peer_peerLock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(s_mtx);
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

