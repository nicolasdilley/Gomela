
// https://github.com/hashicorp/consul/blob/master/agent/ae/ae_test.go#L99
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
	chan child_TestAE_Run_SyncFullBeforeChanges990 = [1] of {int};
	run TestAE_Run_SyncFullBeforeChanges99(child_TestAE_Run_SyncFullBeforeChanges990)
stop_process:skip
}

proctype TestAE_Run_SyncFullBeforeChanges99(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestAE_Run_SyncFullBeforeChanges1161000 = [1] of {int};
	Wgdef wg;
	Mutexdef l_pauseLock;
	Chandef shutdownCh;
	run sync_monitor(shutdownCh);
	run mutexMonitor(l_pauseLock);
	run wgMonitor(wg);
	wg.update!1;
	run AnonymousTestAE_Run_SyncFullBeforeChanges116100(shutdownCh,wg,l_pauseLock,child_AnonymousTestAE_Run_SyncFullBeforeChanges1161000);
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestAE_Run_SyncFullBeforeChanges116100(Chandef shutdownCh;Wgdef wg;Mutexdef l_pauseLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Run1530 = [1] of {int};
	run Run153(l_pauseLock,child_Run1530);
	child_Run1530?0;
	stop_process: skip;
		wg.update!-1;
	child!0
}
proctype Run153(Mutexdef s_pauseLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runFSM1621 = [1] of {int};
	chan child_resetNextFullSyncCh2980 = [1] of {int};
	run resetNextFullSyncCh298(s_pauseLock,child_resetNextFullSyncCh2980);
	child_resetNextFullSyncCh2980?0;
	run runFSM162(s_pauseLock,child_runFSM1621);
	child_runFSM1621?0;
	stop_process: skip;
	child!0
}
proctype resetNextFullSyncCh298(Mutexdef s_pauseLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype runFSM162(Mutexdef s_pauseLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

