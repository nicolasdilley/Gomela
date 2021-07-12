// num_comm_params=3
// num_mand_comm_params=0
// num_opt_comm_params=3

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/runtime/trace/trace_stack_test.go#L26
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
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTraceSymbolize260 = [1] of {int};
	run TestTraceSymbolize26(child_TestTraceSymbolize260);
	run receiver(child_TestTraceSymbolize260)
stop_process:skip
}

proctype TestTraceSymbolize26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestTraceSymbolize103517 = [1] of {int};
	Chandef pipeReadDone_ch;
	chan child_AnonymousTestTraceSymbolize88556 = [1] of {int};
	chan child_AnonymousTestTraceSymbolize79515 = [1] of {int};
	chan child_AnonymousTestTraceSymbolize75554 = [1] of {int};
	Wgdef wg;
	chan child_AnonymousTestTraceSymbolize69603 = [1] of {int};
	Mutexdef mu;
	chan child_AnonymousTestTraceSymbolize61512 = [1] of {int};
	Chandef c2_ch;
	Chandef c1_ch;
	chan child_AnonymousTestTraceSymbolize56511 = [1] of {int};
	Chandef done2_ch;
	chan child_AnonymousTestTraceSymbolize52510 = [1] of {int};
	Chandef done1_ch;
	int var_ev_Stkev_Stk = -2; // opt var_ev_Stkev_Stk
	int var_wantwant = -2; // opt var_wantwant
	int var_eventsevents = -2; // opt var_eventsevents
	run sync_monitor(done1_ch);
	run AnonymousTestTraceSymbolize5251(done1_ch,child_AnonymousTestTraceSymbolize52510);
	run receiver(child_AnonymousTestTraceSymbolize52510);
	run sync_monitor(done2_ch);
	run AnonymousTestTraceSymbolize5651(done1_ch,done2_ch,child_AnonymousTestTraceSymbolize56511);
	run receiver(child_AnonymousTestTraceSymbolize56511);
	run sync_monitor(c1_ch);
	run sync_monitor(c2_ch);
	run AnonymousTestTraceSymbolize6151(done1_ch,done2_ch,c1_ch,c2_ch,child_AnonymousTestTraceSymbolize61512);
	run receiver(child_AnonymousTestTraceSymbolize61512);
	run mutexMonitor(mu);
	mu.Lock!false;
	run AnonymousTestTraceSymbolize6960(c2_ch,done1_ch,done2_ch,c1_ch,mu,child_AnonymousTestTraceSymbolize69603);
	run receiver(child_AnonymousTestTraceSymbolize69603);
	run wgMonitor(wg);
	wg.update!1;
	run AnonymousTestTraceSymbolize7555(done2_ch,c1_ch,c2_ch,done1_ch,wg,mu,child_AnonymousTestTraceSymbolize75554);
	run receiver(child_AnonymousTestTraceSymbolize75554);
	run AnonymousTestTraceSymbolize7951(done1_ch,done2_ch,c1_ch,c2_ch,wg,mu,child_AnonymousTestTraceSymbolize79515);
	run receiver(child_AnonymousTestTraceSymbolize79515);
	run AnonymousTestTraceSymbolize8855(done2_ch,c1_ch,c2_ch,done1_ch,wg,mu,child_AnonymousTestTraceSymbolize88556);
	run receiver(child_AnonymousTestTraceSymbolize88556);
	run sync_monitor(pipeReadDone_ch);
	run AnonymousTestTraceSymbolize10351(done1_ch,done2_ch,c1_ch,c2_ch,pipeReadDone_ch,wg,mu,child_AnonymousTestTraceSymbolize103517);
	run receiver(child_AnonymousTestTraceSymbolize103517);
	

	if
	:: done1_ch.enq!0;
	:: done1_ch.sync!false -> 
		done1_ch.sending!false
	fi;
	

	if
	:: done2_ch.deq?state,num_msgs;
	:: done2_ch.sync?state -> 
		done2_ch.rcving!false
	fi;
	do
	:: c1_ch.enq!0 -> 
		break
	:: c1_ch.sync!false -> 
		c1_ch.sending!false;
		break
	:: c2_ch.enq!0 -> 
		break
	:: c2_ch.sync!false -> 
		c2_ch.sending!false;
		break
	od;
	for20_exit: skip;
	mu.Unlock!false;
	wg.update!-1;
	

	if
	:: pipeReadDone_ch.deq?state,num_msgs;
	:: pipeReadDone_ch.sync?state -> 
		pipeReadDone_ch.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceSymbolize5251(Chandef done1_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: done1_ch.deq?state,num_msgs;
	:: done1_ch.sync?state -> 
		done1_ch.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceSymbolize5651(Chandef done1_ch;Chandef done2_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: done2_ch.enq!0;
	:: done2_ch.sync!false -> 
		done2_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceSymbolize6151(Chandef done1_ch;Chandef done2_ch;Chandef c1_ch;Chandef c2_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: c1_ch.deq?state,num_msgs -> 
		break
	:: c1_ch.sync?state -> 
		c1_ch.rcving!false;
		break
	:: c2_ch.deq?state,num_msgs -> 
		break
	:: c2_ch.sync?state -> 
		c2_ch.rcving!false;
		break
	od;
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceSymbolize6960(Chandef c2_ch;Chandef done1_ch;Chandef done2_ch;Chandef c1_ch;Mutexdef mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	mu.Lock!false;
	mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceSymbolize7555(Chandef done2_ch;Chandef c1_ch;Chandef c2_ch;Chandef done1_ch;Wgdef wg;Mutexdef mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceSymbolize7951(Chandef done1_ch;Chandef done2_ch;Chandef c1_ch;Chandef c2_ch;Wgdef wg;Mutexdef mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceSymbolize8855(Chandef done2_ch;Chandef c1_ch;Chandef c2_ch;Chandef done1_ch;Wgdef wg;Mutexdef mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceSymbolize10351(Chandef done1_ch;Chandef done2_ch;Chandef c1_ch;Chandef c2_ch;Chandef pipeReadDone_ch;Wgdef wg;Mutexdef mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: pipeReadDone_ch.enq!0;
	:: pipeReadDone_ch.sync!false -> 
		pipeReadDone_ch.sending!false
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

proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
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

