// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/http/transport_test.go#L3179
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
	chan child_TestTransportTLSHandshakeTimeout31790 = [1] of {int};
	run TestTransportTLSHandshakeTimeout3179(child_TestTransportTLSHandshakeTimeout31790);
	run receiver(child_TestTransportTLSHandshakeTimeout31790)
stop_process:skip
}

proctype TestTransportTLSHandshakeTimeout3179(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestTransportTLSHandshakeTimeout320031991 = [1] of {int};
	Chandef getdonec;
	chan child_AnonymousTestTransportTLSHandshakeTimeout318931860 = [1] of {int};
	Chandef testdonec;
	run sync_monitor(testdonec);
	run AnonymousTestTransportTLSHandshakeTimeout31893186(testdonec,child_AnonymousTestTransportTLSHandshakeTimeout318931860);
	run receiver(child_AnonymousTestTransportTLSHandshakeTimeout318931860);
	run sync_monitor(getdonec);
	run AnonymousTestTransportTLSHandshakeTimeout32003199(getdonec,testdonec,child_AnonymousTestTransportTLSHandshakeTimeout320031991);
	run receiver(child_AnonymousTestTransportTLSHandshakeTimeout320031991);
	do
	:: getdonec.deq?state,num_msgs -> 
		break
	:: getdonec.sync?state -> 
		getdonec.rcving!false;
		break
	:: true -> 
		break
	od;
	for10_exit: skip;
		defer1: skip;
	testdonec.closing!true;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTransportTLSHandshakeTimeout31893186(Chandef testdonec;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: testdonec.deq?state,num_msgs;
	:: testdonec.sync?state -> 
		testdonec.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTransportTLSHandshakeTimeout32003199(Chandef getdonec;Chandef testdonec;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef tr_nextProtoOnce_m;
	Mutexdef tr_TLSClientConfig_mutex;
	Mutexdef tr_connsPerHostMu;
	Mutexdef tr_altMu;
	Mutexdef tr_reqMu;
	Mutexdef tr_idleMu;
	run mutexMonitor(tr_idleMu);
	run mutexMonitor(tr_reqMu);
	run mutexMonitor(tr_altMu);
	run mutexMonitor(tr_connsPerHostMu);
	run mutexMonitor(tr_TLSClientConfig_mutex);
	run mutexMonitor(tr_nextProtoOnce_m);
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
		defer1: skip;
	getdonec.closing!true;
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

