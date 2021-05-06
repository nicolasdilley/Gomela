
// https://github.com/cayleygraph/cayley/blob/master/internal/lru/lru_test.go#L24
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
	chan child_TestPanicLRUCache240 = [1] of {int};
	run TestPanicLRUCache24(child_TestPanicLRUCache240)
stop_process:skip
}

proctype TestPanicLRUCache24(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestPanicLRUCache28280 = [1] of {int};
	Mutexdef c_mu;
	Chandef xch;
	run sync_monitor(xch);
	run mutexMonitor(c_mu);
		for(i : 0.. 100-1) {
		for10: skip;
		run AnonymousTestPanicLRUCache2828(xch,c_mu,child_AnonymousTestPanicLRUCache28280);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && 100-1 != -3 -> 
				for(i : 0.. 100-1) {
			for21: skip;
			

			if
			:: xch.deq?state,num_msgs;
			:: xch.sync?state -> 
				xch.rcving!false
			fi;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: xch.deq?state,num_msgs;
			:: xch.sync?state -> 
				xch.rcving!false
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestPanicLRUCache2828(Chandef xch;Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get711 = [1] of {int};
	chan child_Put450 = [1] of {int};
	run Put45(c_mu,child_Put450);
	child_Put450?0;
	run Get71(c_mu,child_Get711);
	child_Get711?0;
	

	if
	:: xch.enq!0;
	:: xch.sync!false -> 
		xch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype Put45(Mutexdef lru_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get710 = [1] of {int};
	run Get71(lru_mu,child_Get710);
	child_Get710?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	lru_mu.Lock!false;
	stop_process: skip;
		lru_mu.Unlock!false;
	child!0
}
proctype Get71(Mutexdef lru_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	lru_mu.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		lru_mu.Unlock!false;
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

