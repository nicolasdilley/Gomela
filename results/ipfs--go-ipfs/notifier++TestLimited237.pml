// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ipfs/go-ipfs/blob//thirdparty/notifier/notifier_test.go#L237
#define ub_for263_2  -2
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
	chan child_TestLimited2370 = [1] of {int};
	run TestLimited237(child_TestLimited2370);
	run receiver(child_TestLimited2370)
stop_process:skip
}

proctype TestLimited237(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestLimited2502493 = [1] of {int};
	Chandef done_ch;
	Chandef exit_ch;
	Chandef entr_ch;
	chan child_Notify652 = [1] of {int};
	chan child_Notify651 = [1] of {int};
	chan child_Notify650 = [1] of {int};
	Mutexdef n_mu;
	Mutexdef hwm_mu;
	Chandef hwm_errs_ch;
	

	if
	:: 100 > 0 -> 
		hwm_errs_ch.size = 100;
		run AsyncChan(hwm_errs_ch)
	:: else -> 
		run sync_monitor(hwm_errs_ch)
	fi;
	run mutexMonitor(hwm_mu);
	run mutexMonitor(n_mu);
	run Notify65(n_mu,child_Notify650);
	child_Notify650?0;
	run Notify65(n_mu,child_Notify651);
	child_Notify651?0;
	run Notify65(n_mu,child_Notify652);
	child_Notify652?0;
	run sync_monitor(entr_ch);
	run sync_monitor(exit_ch);
	run sync_monitor(done_ch);
	run AnonymousTestLimited250249(done_ch,hwm_errs_ch,entr_ch,exit_ch,hwm_mu,n_mu,child_AnonymousTestLimited2502493);
	run receiver(child_AnonymousTestLimited2502493);
	

	if
	:: 0 != -2 && ub_for263_2 != -2 -> 
				for(i : 0.. ub_for263_2) {
			for23: skip;
			do
			:: entr_ch.deq?state,num_msgs -> 
				goto for24_end;
				break
			:: entr_ch.sync?state -> 
				entr_ch.rcving!false;
				goto for24_end;
				break
			:: true -> 
				break
			od;
			for24_exit: skip;
			for24_end: skip;
			do
			:: entr_ch.deq?state,num_msgs -> 
				goto for25_end;
				break
			:: entr_ch.sync?state -> 
				entr_ch.rcving!false;
				goto for25_end;
				break
			:: exit_ch.enq!0 -> 
				break
			:: exit_ch.sync!false -> 
				exit_ch.sending!false;
				break
			:: true -> 
				break
			od;
			for25_exit: skip;
			for25_end: skip;
			for23_end: skip
		};
		for23_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			do
			:: entr_ch.deq?state,num_msgs -> 
				goto for21_end;
				break
			:: entr_ch.sync?state -> 
				entr_ch.rcving!false;
				goto for21_end;
				break
			:: true -> 
				break
			od;
			for21_exit: skip;
			for21_end: skip;
			do
			:: entr_ch.deq?state,num_msgs -> 
				goto for22_end;
				break
			:: entr_ch.sync?state -> 
				entr_ch.rcving!false;
				goto for22_end;
				break
			:: exit_ch.enq!0 -> 
				break
			:: exit_ch.sync!false -> 
				exit_ch.sending!false;
				break
			:: true -> 
				break
			od;
			for22_exit: skip;
			for22_end: skip;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	do
	:: done_ch.deq?state,num_msgs -> 
		break
	:: done_ch.sync?state -> 
		done_ch.rcving!false;
		break
	:: true -> 
		break
	od;
	for30_exit: skip;
	for30_end: skip;
	hwm_errs_ch.closing!true;
	do
	:: true -> 
		num_msgs = 0;
		

		if
		:: hwm_errs_ch.deq?state,num_msgs;
		:: hwm_errs_ch.sync?state -> 
			hwm_errs_ch.rcving!false
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for40: skip;
			for40_end: skip
		fi
	od;
	for40_exit: skip;
	stop_process: skip;
	child!0
}
proctype Notify65(Mutexdef n_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	n_mu.Lock!false;
	n_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype AnonymousTestLimited250249(Chandef done_ch;Chandef hwm_errs_ch;Chandef entr_ch;Chandef exit_ch;Mutexdef hwm_mu;Mutexdef n_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NotifyAll1214 = [1] of {int};
	chan child_NotifyAll1213 = [1] of {int};
	

	if
	:: 0 != -2 && 10-1 != -3 -> 
				for(i : 0.. 10-1) {
			for13: skip;
			run NotifyAll121(n_mu,child_NotifyAll1214);
			child_NotifyAll1214?0;
			for13_end: skip
		};
		for13_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run NotifyAll121(n_mu,child_NotifyAll1213);
			child_NotifyAll1213?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: done_ch.enq!0;
	:: done_ch.sync!false -> 
		done_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype NotifyAll121(Mutexdef n_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_n_nots = -2; // opt var_n_nots
	n_mu.Lock!false;
	

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
	n_mu.Unlock!false;
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

