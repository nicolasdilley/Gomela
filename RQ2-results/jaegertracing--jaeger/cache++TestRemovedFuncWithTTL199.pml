
// https://github.com/jaegertracing/jaeger/blob/master/pkg/cache/lru_test.go#L199
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
	chan child_TestRemovedFuncWithTTL1990 = [1] of {int};
	run TestRemovedFuncWithTTL199(child_TestRemovedFuncWithTTL1990)
stop_process:skip
}

proctype TestRemovedFuncWithTTL199(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get592 = [1] of {int};
	chan child_Get591 = [1] of {int};
	chan child_Put840 = [1] of {int};
	Mutexdef cache_mux;
	Chandef ch;
	run sync_monitor(ch);
	run mutexMonitor(cache_mux);
	run Put84(cache_mux,child_Put840);
	child_Put840?0;
	run Get59(cache_mux,child_Get591);
	child_Get591?0;
	run Get59(cache_mux,child_Get592);
	child_Get592?0;
	do
	:: ch.deq?state,num_msgs -> 
		break
	:: ch.sync?state -> 
		ch.rcving!false;
		break
	:: true -> 
		break
	od;
	stop_process: skip;
	child!0
}
proctype Put84(Mutexdef c_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_putWithMutexHold1160 = [1] of {int};
	c_mux.Lock!false;
	run putWithMutexHold116(c_mux,child_putWithMutexHold1160);
	child_putWithMutexHold1160?0;
	goto stop_process;
	stop_process: skip;
		c_mux.Unlock!false;
	child!0
}
proctype putWithMutexHold116(Mutexdef c_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Get59(Mutexdef c_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mux.Lock!false;
	

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
	goto stop_process;
	stop_process: skip;
		c_mux.Unlock!false;
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

