
// https://github.com/moby/moby/blob/master/pkg/broadcaster/unbuffered_test.go#L116
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
	chan child_TestRaceUnbuffered1160 = [1] of {int};
	run TestRaceUnbuffered116(child_TestRaceUnbuffered1160)
stop_process:skip
}

proctype TestRaceUnbuffered116(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Write231 = [1] of {int};
	chan child_AnonymousTestRaceUnbuffered1191180 = [1] of {int};
	Chandef c;
	Mutexdef writer_mu;
	run mutexMonitor(writer_mu);
	run sync_monitor(c);
	run AnonymousTestRaceUnbuffered119118(c,writer_mu,child_AnonymousTestRaceUnbuffered1191180);
	run Write23(writer_mu,child_Write231);
	child_Write231?0;
	

	if
	:: c.deq?state,num_msgs;
	:: c.sync?state -> 
		c.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRaceUnbuffered119118(Chandef c;Mutexdef writer_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Add150 = [1] of {int};
	run Add15(writer_mu,child_Add150);
	child_Add150?0;
	

	if
	:: c.enq!0;
	:: c.sync!false -> 
		c.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype Add15(Mutexdef w_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	w_mu.Lock!false;
	w_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Write23(Mutexdef w_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	w_mu.Lock!false;
	w_mu.Unlock!false;
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

