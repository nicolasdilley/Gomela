// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/minio/minio/blob//pkg/lsync/lrwmutex_test.go#L261
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
	chan child_TestDRLocker2610 = [1] of {int};
	run TestDRLocker261(child_TestDRLocker2610);
	run receiver(child_TestDRLocker2610)
stop_process:skip
}

proctype TestDRLocker261(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Unlock1293 = [1] of {int};
	chan child_Unlock1292 = [1] of {int};
	chan child_AnonymousTestDRLocker2682641 = [1] of {int};
	chan child_DRLocker1850 = [1] of {int};
	Chandef rlocked_ch;
	Chandef wlocked_ch;
	Mutexdef wl_mu;
	int var_n = -2; // opt var_n
	run mutexMonitor(wl_mu);
	

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
	run DRLocker185(wl_mu,child_DRLocker1850);
	child_DRLocker1850?0;
	run AnonymousTestDRLocker268264(wlocked_ch,rlocked_ch,wl_mu,var_n,child_AnonymousTestDRLocker2682641);
	run receiver(child_AnonymousTestDRLocker2682641);
	

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
			run Unlock129(wl_mu,child_Unlock1293);
			child_Unlock1293?0;
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
			run Unlock129(wl_mu,child_Unlock1292);
			child_Unlock1292?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype DRLocker185(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousTestDRLocker268264(Chandef wlocked_ch;Chandef rlocked_ch;Mutexdef wl_mu;int var_n;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Lock452 = [1] of {int};
	chan child_Lock451 = [1] of {int};
	

	if
	:: 0 != -2 && var_n-1 != -3 -> 
				for(i : 0.. var_n-1) {
			for15: skip;
			

			if
			:: rlocked_ch.enq!0;
			:: rlocked_ch.sync!false -> 
				rlocked_ch.sending!false
			fi;
			run Lock45(wl_mu,child_Lock452);
			child_Lock452?0;
			

			if
			:: wlocked_ch.enq!0;
			:: wlocked_ch.sync!false -> 
				wlocked_ch.sending!false
			fi;
			for15_end: skip
		};
		for15_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: rlocked_ch.enq!0;
			:: rlocked_ch.sync!false -> 
				rlocked_ch.sending!false
			fi;
			run Lock45(wl_mu,child_Lock451);
			child_Lock451?0;
			

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
proctype Lock45(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_lockLoop1051 = [1] of {int};
	run lockLoop105(lm_mu,child_lockLoop1051);
	child_lockLoop1051?0;
	stop_process: skip;
	child!0
}
proctype lockLoop105(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_lock751 = [1] of {int};
	do
	:: true -> 
		for11: skip;
		do
		:: true -> 
			goto stop_process
		:: true -> 
			run lock75(lm_mu,child_lock751);
			child_lock751?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		od;
		for12_exit: skip;
		for12_end: skip;
		for11_end: skip
	od;
	for11_exit: skip;
	stop_process: skip;
	child!0
}
proctype lock75(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	lm_mu.Lock!false;
	goto defer1;
		defer1: skip;
	lm_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Unlock129(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_unlock1502 = [1] of {int};
	run unlock150(lm_mu,child_unlock1502);
	child_unlock1502?0;
	stop_process: skip;
	child!0
}
proctype unlock150(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	lm_mu.Lock!false;
	goto defer1;
		defer1: skip;
	lm_mu.Unlock!false;
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

