
// https://github.com/hashicorp/vault/blob/master/physical/raft/chunking_test.go#L24
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
	chan child_TestRaft_Chunking_Lifecycle240 = [1] of {int};
	run TestRaft_Chunking_Lifecycle24(child_TestRaft_Chunking_Lifecycle240)
stop_process:skip
}

proctype TestRaft_Chunking_Lifecycle24(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TeardownCluster8601 = [1] of {int};
	Mutexdef logData_state_atomicMessageInfo_initMu;
	chan child_applyConfigSettings5870 = [1] of {int};
	Mutexdef b_followerStates_l;
	Mutexdef b_autopilot_execLock;
	Mutexdef b_autopilot_leaderLock_mu;
	Mutexdef b_autopilot_stateLock;
	Mutexdef b_streamLayer_closeLock;
	Mutexdef b_raft_observersLock;
	Mutexdef b_raft_shutdownLock;
	Mutexdef b_raft_leaderLock;
	Mutexdef b_raft_lastContactLock;
	Mutexdef b_fsm_db_statlock;
	Mutexdef b_fsm_db_mmaplock;
	Mutexdef b_fsm_db_metalock;
	Mutexdef b_fsm_db_rwlock;
	Mutexdef b_fsm_db_batch_start_m;
	Mutexdef b_fsm_db_batchMu;
	Mutexdef b_fsm_db_freelistLoad_m;
	Mutexdef b_fsm_l;
	Mutexdef b_l;
	run mutexMonitor(b_l);
	run mutexMonitor(b_fsm_l);
	run mutexMonitor(b_fsm_db_freelistLoad_m);
	run mutexMonitor(b_fsm_db_batchMu);
	run mutexMonitor(b_fsm_db_batch_start_m);
	run mutexMonitor(b_fsm_db_rwlock);
	run mutexMonitor(b_fsm_db_metalock);
	run mutexMonitor(b_fsm_db_mmaplock);
	run mutexMonitor(b_fsm_db_statlock);
	run mutexMonitor(b_raft_lastContactLock);
	run mutexMonitor(b_raft_leaderLock);
	run mutexMonitor(b_raft_shutdownLock);
	run mutexMonitor(b_raft_observersLock);
	run mutexMonitor(b_streamLayer_closeLock);
	run mutexMonitor(b_autopilot_stateLock);
	run mutexMonitor(b_autopilot_leaderLock_mu);
	run mutexMonitor(b_autopilot_execLock);
	run mutexMonitor(b_followerStates_l);
	run applyConfigSettings587(b_l,b_fsm_l,b_fsm_db_freelistLoad_m,b_fsm_db_batchMu,b_fsm_db_batch_start_m,b_fsm_db_rwlock,b_fsm_db_metalock,b_fsm_db_mmaplock,b_fsm_db_statlock,b_raft_lastContactLock,b_raft_leaderLock,b_raft_shutdownLock,b_raft_observersLock,b_streamLayer_closeLock,b_autopilot_stateLock,b_autopilot_leaderLock_mu,b_autopilot_execLock,b_followerStates_l,child_applyConfigSettings5870);
	child_applyConfigSettings5870?0;
	run mutexMonitor(logData_state_atomicMessageInfo_initMu);
	run TeardownCluster860(b_l,b_fsm_l,b_fsm_db_freelistLoad_m,b_fsm_db_batchMu,b_fsm_db_batch_start_m,b_fsm_db_rwlock,b_fsm_db_metalock,b_fsm_db_mmaplock,b_fsm_db_statlock,b_raft_lastContactLock,b_raft_leaderLock,b_raft_shutdownLock,b_raft_observersLock,b_streamLayer_closeLock,b_autopilot_stateLock,b_autopilot_leaderLock_mu,b_autopilot_execLock,b_followerStates_l,child_TeardownCluster8601);
	child_TeardownCluster8601?0;
	stop_process: skip;
	child!0
}
proctype applyConfigSettings587(Mutexdef b_l;Mutexdef b_fsm_l;Mutexdef b_fsm_db_freelistLoad_m;Mutexdef b_fsm_db_batchMu;Mutexdef b_fsm_db_batch_start_m;Mutexdef b_fsm_db_rwlock;Mutexdef b_fsm_db_metalock;Mutexdef b_fsm_db_mmaplock;Mutexdef b_fsm_db_statlock;Mutexdef b_raft_lastContactLock;Mutexdef b_raft_leaderLock;Mutexdef b_raft_shutdownLock;Mutexdef b_raft_observersLock;Mutexdef b_streamLayer_closeLock;Mutexdef b_autopilot_stateLock;Mutexdef b_autopilot_leaderLock_mu;Mutexdef b_autopilot_execLock;Mutexdef b_followerStates_l;chan child) {
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
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype TeardownCluster860(Mutexdef b_l;Mutexdef b_fsm_l;Mutexdef b_fsm_db_freelistLoad_m;Mutexdef b_fsm_db_batchMu;Mutexdef b_fsm_db_batch_start_m;Mutexdef b_fsm_db_rwlock;Mutexdef b_fsm_db_metalock;Mutexdef b_fsm_db_mmaplock;Mutexdef b_fsm_db_statlock;Mutexdef b_raft_lastContactLock;Mutexdef b_raft_leaderLock;Mutexdef b_raft_shutdownLock;Mutexdef b_raft_observersLock;Mutexdef b_streamLayer_closeLock;Mutexdef b_autopilot_stateLock;Mutexdef b_autopilot_leaderLock_mu;Mutexdef b_autopilot_execLock;Mutexdef b_followerStates_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef b_raftInitCh;
	b_l.Lock!false;
	run sync_monitor(b_raftInitCh);
	b_l.Unlock!false;
	

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
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.rcving?false;
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.sync!true -> 
		 ch.num_msgs = ch.num_msgs - 1
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

