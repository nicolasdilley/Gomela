// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//gossip/service/join_test.go#L185
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
	chan child_TestJoinChannelNoAnchorPeers1850 = [1] of {int};
	run TestJoinChannelNoAnchorPeers185(child_TestJoinChannelNoAnchorPeers1850);
	run receiver(child_TestJoinChannelNoAnchorPeers1850)
stop_process:skip
}

proctype TestJoinChannelNoAnchorPeers185(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_updateAnchors4320 = [1] of {int};
	Mutexdef g_anchorPeerTracker_mutex;
	Mutexdef g_lock;
	Mutexdef anchorPeerTracker_mutex;
	Wgdef joinChanCalled;
	run wgMonitor(joinChanCalled);
	joinChanCalled.update!1;
	run mutexMonitor(anchorPeerTracker_mutex);
	run mutexMonitor(g_lock);
	run mutexMonitor(g_anchorPeerTracker_mutex);
	run updateAnchors432(g_anchorPeerTracker_mutex,g_lock,child_updateAnchors4320);
	child_updateAnchors4320?0;
	joinChanCalled.wait?0;
	stop_process: skip;
	child!0
}
proctype updateAnchors432(Mutexdef g_anchorPeerTracker_mutex;Mutexdef g_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_update2111 = [1] of {int};
	chan child_amIinChannel5010 = [1] of {int};
	int var_appOrg_AnchorPeers = -2; // opt var_appOrg_AnchorPeers
	int var_configUpdate_Organizations = -2; // opt var_configUpdate_Organizations
	run amIinChannel501(g_anchorPeerTracker_mutex,g_lock,child_amIinChannel5010);
	child_amIinChannel5010?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run update211(g_anchorPeerTracker_mutex,child_update2111);
	child_update2111?0;
	stop_process: skip;
	child!0
}
proctype amIinChannel501(Mutexdef g_anchorPeerTracker_mutex;Mutexdef g_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_orgListFromConfigUpdate = -2; // opt var_orgListFromConfigUpdate
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype update211(Mutexdef t_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	t_mutex.Lock!false;
		defer1: skip;
	t_mutex.Unlock!false;
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

