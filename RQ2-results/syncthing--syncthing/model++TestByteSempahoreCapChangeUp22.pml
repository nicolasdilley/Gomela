
// https://github.com/syncthing/syncthing/blob/master/lib/model/bytesemaphore_test.go#L22
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
	chan child_TestByteSempahoreCapChangeUp220 = [1] of {int};
	run TestByteSempahoreCapChangeUp22(child_TestByteSempahoreCapChangeUp220)
stop_process:skip
}

proctype TestByteSempahoreCapChangeUp22(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_setCapacity942 = [1] of {int};
	chan child_AnonymousTestByteSempahoreCapChangeUp33321 = [1] of {int};
	Chandef gotit;
	chan child_take490 = [1] of {int};
	Mutexdef s_mut;
	run mutexMonitor(s_mut);
	run take49(s_mut,child_take490);
	child_take490?0;
	run sync_monitor(gotit);
	run AnonymousTestByteSempahoreCapChangeUp3332(gotit,s_mut,child_AnonymousTestByteSempahoreCapChangeUp33321);
	run setCapacity94(s_mut,child_setCapacity942);
	child_setCapacity942?0;
	

	if
	:: gotit.deq?state,num_msgs;
	:: gotit.sync?state -> 
		gotit.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype take49(Mutexdef s_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_takeInner530 = [1] of {int};
	run takeInner53(s_mut,child_takeInner530);
	child_takeInner530?0;
	stop_process: skip;
	child!0
}
proctype takeInner53(Mutexdef s_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		goto stop_process
	:: true -> 
		break
	od;
	s_mut.Lock!false;
	goto stop_process;
	stop_process: skip;
		s_mut.Unlock!false;
	child!0
}
proctype AnonymousTestByteSempahoreCapChangeUp3332(Chandef gotit;Mutexdef s_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_take491 = [1] of {int};
	run take49(s_mut,child_take491);
	child_take491?0;
	gotit.closing!true;
	stop_process: skip;
	child!0
}
proctype setCapacity94(Mutexdef s_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mut.Lock!false;
	s_mut.Unlock!false;
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

