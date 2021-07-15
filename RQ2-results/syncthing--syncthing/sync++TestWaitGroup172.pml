
// https://github.com/syncthing/syncthing/blob/master/lib/sync/sync_test.go#L172
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
	chan child_TestWaitGroup1720 = [1] of {int};
	run TestWaitGroup172(child_TestWaitGroup1720)
stop_process:skip
}

proctype TestWaitGroup172(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestWaitGroup2121931 = [1] of {int};
	Chandef waiting;
	chan child_AnonymousTestWaitGroup1951930 = [1] of {int};
	Chandef waiting;
	Mutexdef msgmut;
	Mutexdef clock_mut;
	run mutexMonitor(clock_mut);
	run mutexMonitor(msgmut);
	run sync_monitor(waiting);
	run AnonymousTestWaitGroup195193(waiting,clock_mut,msgmut,child_AnonymousTestWaitGroup1951930);
	waiting.closing!true;
	run sync_monitor(waiting);
	run AnonymousTestWaitGroup212193(waiting,clock_mut,msgmut,child_AnonymousTestWaitGroup2121931);
	waiting.closing!true;
	stop_process: skip;
	child!0
}
proctype AnonymousTestWaitGroup195193(Chandef waiting;Mutexdef clock_mut;Mutexdef msgmut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_wind3450 = [1] of {int};
	

	if
	:: waiting.deq?state,num_msgs;
	:: waiting.sync?state -> 
		waiting.rcving!false
	fi;
	run wind345(clock_mut,child_wind3450);
	child_wind3450?0;
	stop_process: skip;
	child!0
}
proctype wind345(Mutexdef t_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	t_mut.Lock!false;
	t_mut.Unlock!false;
	stop_process: skip;
	child!0
}
proctype AnonymousTestWaitGroup212193(Chandef waiting;Mutexdef clock_mut;Mutexdef msgmut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_wind3451 = [1] of {int};
	

	if
	:: waiting.deq?state,num_msgs;
	:: waiting.sync?state -> 
		waiting.rcving!false
	fi;
	run wind345(clock_mut,child_wind3451);
	child_wind3451?0;
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

