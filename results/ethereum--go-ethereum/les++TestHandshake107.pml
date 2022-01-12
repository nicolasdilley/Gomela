// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob//les/peer_test.go#L107
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
	chan child_TestHandshake1070 = [1] of {int};
	run TestHandshake107(child_TestHandshake1070);
	run receiver(child_TestHandshake1070)
stop_process:skip
}

proctype TestHandshake107(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestHandshake1391191 = [1] of {int};
	chan child_AnonymousTestHandshake1331190 = [1] of {int};
	Chandef errCh2_ch;
	Chandef errCh1_ch;
	Mutexdef peer2_nodeValueTracker_vt_statsExpirer_lock;
	Mutexdef peer2_nodeValueTracker_vt_statsExpLock;
	Mutexdef peer2_nodeValueTracker_vt_lock;
	Mutexdef peer2_nodeValueTracker_lock;
	Mutexdef peer2_vtLock;
	Mutexdef peer2_fcServer_lock;
	Mutexdef peer1_fcClient_cm_lock;
	Mutexdef peer1_fcClient_lock;
	Mutexdef peer1_invalidLock;
	Mutexdef peer1_responseLock;
	run mutexMonitor(peer1_responseLock);
	run mutexMonitor(peer1_invalidLock);
	run mutexMonitor(peer1_fcClient_lock);
	run mutexMonitor(peer1_fcClient_cm_lock);
	run mutexMonitor(peer2_fcServer_lock);
	run mutexMonitor(peer2_vtLock);
	run mutexMonitor(peer2_nodeValueTracker_lock);
	run mutexMonitor(peer2_nodeValueTracker_vt_lock);
	run mutexMonitor(peer2_nodeValueTracker_vt_statsExpLock);
	run mutexMonitor(peer2_nodeValueTracker_vt_statsExpirer_lock);
	

	if
	:: 1 > 0 -> 
		errCh1_ch.size = 1;
		run AsyncChan(errCh1_ch)
	:: else -> 
		run sync_monitor(errCh1_ch)
	fi;
	

	if
	:: 1 > 0 -> 
		errCh2_ch.size = 1;
		run AsyncChan(errCh2_ch)
	:: else -> 
		run sync_monitor(errCh2_ch)
	fi;
	run AnonymousTestHandshake133119(errCh1_ch,errCh2_ch,peer1_responseLock,peer1_invalidLock,peer1_fcClient_lock,peer1_fcClient_cm_lock,peer2_fcServer_lock,peer2_vtLock,peer2_nodeValueTracker_lock,peer2_nodeValueTracker_vt_lock,peer2_nodeValueTracker_vt_statsExpLock,peer2_nodeValueTracker_vt_statsExpirer_lock,child_AnonymousTestHandshake1331190);
	run receiver(child_AnonymousTestHandshake1331190);
	run AnonymousTestHandshake139119(errCh1_ch,errCh2_ch,peer1_responseLock,peer1_invalidLock,peer1_fcClient_lock,peer1_fcClient_cm_lock,peer2_fcServer_lock,peer2_vtLock,peer2_nodeValueTracker_lock,peer2_nodeValueTracker_vt_lock,peer2_nodeValueTracker_vt_statsExpLock,peer2_nodeValueTracker_vt_statsExpirer_lock,child_AnonymousTestHandshake1391191);
	run receiver(child_AnonymousTestHandshake1391191);
	

	if
	:: 0 != -2 && 2-1 != -3 -> 
				for(i : 0.. 2-1) {
			for12: skip;
			do
			:: errCh1_ch.deq?state,num_msgs -> 
				break
			:: errCh1_ch.sync?state -> 
				errCh1_ch.rcving!false;
				break
			:: errCh2_ch.deq?state,num_msgs -> 
				break
			:: errCh2_ch.sync?state -> 
				errCh2_ch.rcving!false;
				break
			:: true -> 
				break
			od;
			for13_exit: skip;
			for13_end: skip;
			for12_end: skip
		};
		for12_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			do
			:: errCh1_ch.deq?state,num_msgs -> 
				break
			:: errCh1_ch.sync?state -> 
				errCh1_ch.rcving!false;
				break
			:: errCh2_ch.deq?state,num_msgs -> 
				break
			:: errCh2_ch.sync?state -> 
				errCh2_ch.rcving!false;
				break
			:: true -> 
				break
			od;
			for11_exit: skip;
			for11_end: skip;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestHandshake133119(Chandef errCh1_ch;Chandef errCh2_ch;Mutexdef peer1_responseLock;Mutexdef peer1_invalidLock;Mutexdef peer1_fcClient_lock;Mutexdef peer1_fcClient_cm_lock;Mutexdef peer2_fcServer_lock;Mutexdef peer2_vtLock;Mutexdef peer2_nodeValueTracker_lock;Mutexdef peer2_nodeValueTracker_vt_lock;Mutexdef peer2_nodeValueTracker_vt_statsExpLock;Mutexdef peer2_nodeValueTracker_vt_statsExpirer_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: errCh1_ch.enq!0;
	:: errCh1_ch.sync!false -> 
		errCh1_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestHandshake139119(Chandef errCh1_ch;Chandef errCh2_ch;Mutexdef peer1_responseLock;Mutexdef peer1_invalidLock;Mutexdef peer1_fcClient_lock;Mutexdef peer1_fcClient_cm_lock;Mutexdef peer2_fcServer_lock;Mutexdef peer2_vtLock;Mutexdef peer2_nodeValueTracker_lock;Mutexdef peer2_nodeValueTracker_vt_lock;Mutexdef peer2_nodeValueTracker_vt_statsExpLock;Mutexdef peer2_nodeValueTracker_vt_statsExpirer_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: errCh2_ch.enq!0;
	:: errCh2_ch.sync!false -> 
		errCh2_ch.sending!false
	fi;
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

