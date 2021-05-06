
// https://github.com/istio/istio/blob/master/pilot/pkg/xds/pushqueue_test.go#L30
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
	chan child_getWithTimeout300 = [1] of {int};
	run getWithTimeout30(child_getWithTimeout300)
stop_process:skip
}

proctype getWithTimeout30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousgetWithTimeout32310 = [1] of {int};
	Chandef done;
	

	if
	:: 1 > 0 -> 
		done.size = 1;
		run AsyncChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	run AnonymousgetWithTimeout3231(done,child_AnonymousgetWithTimeout32310);
	do
	:: done.deq?state,num_msgs -> 
		goto stop_process
	:: done.sync?state -> 
		done.rcving!false;
		goto stop_process
	:: true -> 
		goto stop_process
	od;
	stop_process: skip;
	child!0
}
proctype AnonymousgetWithTimeout3231(Chandef done;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef __Push_initializeMutex;
	Mutexdef __Push_networksMu;
	Mutexdef __Push_JwtKeyResolver_keyEntries_mu;
	Mutexdef __Push_proxyStatusMutex;
	Mutexdef con_node_Locality_state_atomicMessageInfo_initMu;
	Mutexdef con_node_Metadata_state_atomicMessageInfo_initMu;
	Mutexdef con_node_state_atomicMessageInfo_initMu;
	Mutexdef con_proxy_Locality_state_atomicMessageInfo_initMu;
	run mutexMonitor(con_proxy_Locality_state_atomicMessageInfo_initMu);
	run mutexMonitor(con_node_state_atomicMessageInfo_initMu);
	run mutexMonitor(con_node_Metadata_state_atomicMessageInfo_initMu);
	run mutexMonitor(con_node_Locality_state_atomicMessageInfo_initMu);
	run mutexMonitor(__Push_proxyStatusMutex);
	run mutexMonitor(__Push_JwtKeyResolver_keyEntries_mu);
	run mutexMonitor(__Push_networksMu);
	run mutexMonitor(__Push_initializeMutex);
	

	if
	:: done.enq!0;
	:: done.sync!false -> 
		done.sending!false
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

