// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//gossip/service/join_test.go#L140
typedef Chandef {
	chan sync = [0] of {bool};
	chan enq = [0] of {int};
	chan deq = [0] of {bool,int};
	chan sending = [0] of {bool};
	chan rcving = [0] of {bool};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestJoinChannelConfig1400 = [1] of {int};
	run TestJoinChannelConfig140(child_TestJoinChannelConfig1400);
	run receiver(child_TestJoinChannelConfig1400)
stop_process:skip
}

proctype TestJoinChannelConfig140(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_updateAnchors4321 = [1] of {int};
	Mutexdef g2_anchorPeerTracker_mutex;
	Mutexdef g2_lock;
	Chandef succChan_ch;
	chan child_updateAnchors4320 = [1] of {int};
	Mutexdef g1_anchorPeerTracker_mutex;
	Mutexdef g1_lock;
	Mutexdef anchorPeerTracker_mutex;
	Chandef failChan_ch;
	

	if
	:: 1 > 0 -> 
		failChan_ch.size = 1;
		run AsyncChan(failChan_ch)
	:: else -> 
		run sync_monitor(failChan_ch)
	fi;
	run mutexMonitor(anchorPeerTracker_mutex);
	run mutexMonitor(g1_lock);
	run mutexMonitor(g1_anchorPeerTracker_mutex);
	run updateAnchors432(g1_anchorPeerTracker_mutex,g1_lock,child_updateAnchors4320);
	child_updateAnchors4320?0;
	do
	:: true -> 
		break
	:: failChan_ch.deq?state,num_msgs -> 
		break
	:: failChan_ch.sync?state -> 
		failChan_ch.rcving!false;
		break
	od;
	for30_exit: skip;
	for30_end: skip;
	

	if
	:: 1 > 0 -> 
		succChan_ch.size = 1;
		run AsyncChan(succChan_ch)
	:: else -> 
		run sync_monitor(succChan_ch)
	fi;
	run mutexMonitor(g2_lock);
	run mutexMonitor(g2_anchorPeerTracker_mutex);
	run updateAnchors432(g2_anchorPeerTracker_mutex,g2_lock,child_updateAnchors4321);
	child_updateAnchors4321?0;
	do
	:: true -> 
		break
	:: succChan_ch.deq?state,num_msgs -> 
		break
	:: succChan_ch.sync?state -> 
		succChan_ch.rcving!false;
		break
	od;
	for40_exit: skip;
	for40_end: skip;
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
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.num_msgs > 0 -> // cannot send on closed channel
    end4: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.deq!true,ch.num_msgs -> 
  		 ch.num_msgs = ch.num_msgs - 1
    fi;
  :: else ->    end5: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.sync!true; 
    fi;
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.deq!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		    ch.closed = true
		   :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.enq?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.rcving?false ->
 		    ch.sending?false;
		fi;
		:: else -> 
		end3: if
		  :: ch.enq?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.deq!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		     ch.closed = true
		  :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.rcving?false;
  :: ch.sync!true; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.rcving?false ->
       ch.sending?false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
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

