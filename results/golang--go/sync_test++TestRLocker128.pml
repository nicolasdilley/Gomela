// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//sync/rwmutex_test.go#L128
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
	chan child_TestRLocker1280 = [1] of {int};
	run TestRLocker128(child_TestRLocker1280);
	run receiver(child_TestRLocker1280)
stop_process:skip
}

proctype TestRLocker128(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestRLocker1351310 = [1] of {int};
	Chandef rlocked_ch;
	Chandef wlocked_ch;
	Mutexdef wl;
	int var_n = -2; // opt var_n
	run mutexMonitor(wl);
	

	if
	:: 1 > 0 -> 
		wlocked_ch.size = 1;
		run AsyncChan(wlocked_ch)
	:: else -> 
		run sync_monitor(wlocked_ch)
	fi;
	

	if
	:: 1 > 0 -> 
		rlocked_ch.size = 1;
		run AsyncChan(rlocked_ch)
	:: else -> 
		run sync_monitor(rlocked_ch)
	fi;
	run AnonymousTestRLocker135131(wlocked_ch,rlocked_ch,wl,var_n,child_AnonymousTestRLocker1351310);
	run receiver(child_AnonymousTestRLocker1351310);
	

	if
	:: 0 != -2 && var_n-1 != -3 -> 
				for(i : 0.. var_n-1) {
			for23: skip;
			

			if
			:: rlocked_ch.deq?state,num_msgs;
			:: rlocked_ch.sync?state -> 
				rlocked_ch.rcving!false
			fi;
			do
			:: wlocked_ch.deq?state,num_msgs -> 
				break
			:: wlocked_ch.sync?state -> 
				wlocked_ch.rcving!false;
				break
			:: true -> 
				break
			od;
			for24_exit: skip;
			for24_end: skip;
			

			if
			:: wlocked_ch.deq?state,num_msgs;
			:: wlocked_ch.sync?state -> 
				wlocked_ch.rcving!false
			fi;
			do
			:: rlocked_ch.deq?state,num_msgs -> 
				break
			:: rlocked_ch.sync?state -> 
				rlocked_ch.rcving!false;
				break
			:: true -> 
				break
			od;
			for25_exit: skip;
			for25_end: skip;
			wl.Unlock!false;
			for23_end: skip
		};
		for23_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: rlocked_ch.deq?state,num_msgs;
			:: rlocked_ch.sync?state -> 
				rlocked_ch.rcving!false
			fi;
			do
			:: wlocked_ch.deq?state,num_msgs -> 
				break
			:: wlocked_ch.sync?state -> 
				wlocked_ch.rcving!false;
				break
			:: true -> 
				break
			od;
			for21_exit: skip;
			for21_end: skip;
			

			if
			:: wlocked_ch.deq?state,num_msgs;
			:: wlocked_ch.sync?state -> 
				wlocked_ch.rcving!false
			fi;
			do
			:: rlocked_ch.deq?state,num_msgs -> 
				break
			:: rlocked_ch.sync?state -> 
				rlocked_ch.rcving!false;
				break
			:: true -> 
				break
			od;
			for22_exit: skip;
			for22_end: skip;
			wl.Unlock!false;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRLocker135131(Chandef wlocked_ch;Chandef rlocked_ch;Mutexdef wl;int var_n;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: 0 != -2 && var_n-1 != -3 -> 
				for(i : 0.. var_n-1) {
			for11: skip;
			

			if
			:: rlocked_ch.enq!0;
			:: rlocked_ch.sync!false -> 
				rlocked_ch.sending!false
			fi;
			wl.Lock!false;
			

			if
			:: wlocked_ch.enq!0;
			:: wlocked_ch.sync!false -> 
				wlocked_ch.sending!false
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: rlocked_ch.enq!0;
			:: rlocked_ch.sync!false -> 
				rlocked_ch.sending!false
			fi;
			wl.Lock!false;
			

			if
			:: wlocked_ch.enq!0;
			:: wlocked_ch.sync!false -> 
				wlocked_ch.sending!false
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
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

