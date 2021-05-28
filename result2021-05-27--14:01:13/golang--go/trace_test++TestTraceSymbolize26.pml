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
	chan child_AnonymousTestTraceSymbolize103557 = [1] of {int};
	Chandef pipeReadDone;
	chan child_AnonymousTestTraceSymbolize88596 = [1] of {int};
	chan child_AnonymousTestTraceSymbolize79515 = [1] of {int};
	chan child_AnonymousTestTraceSymbolize75514 = [1] of {int};
	Wgdef wg;
	chan child_AnonymousTestTraceSymbolize69513 = [1] of {int};
	Mutexdef mu;
	chan child_AnonymousTestTraceSymbolize61602 = [1] of {int};
	Chandef c2;
	Chandef c1;
	chan child_AnonymousTestTraceSymbolize56511 = [1] of {int};
	Chandef done2;
	chan child_AnonymousTestTraceSymbolize52510 = [1] of {int};
	Chandef done1;
	int ev_Stk = -2; // opt ev_Stk
	int want = -2; // opt want
	int events = -2; // opt events
	run sync_monitor(done1);
	run AnonymousTestTraceSymbolize5251(done1,child_AnonymousTestTraceSymbolize52510);
	run receiver(child_AnonymousTestTraceSymbolize52510);
	run sync_monitor(done2);
	run AnonymousTestTraceSymbolize5651(done1,done2,child_AnonymousTestTraceSymbolize56511);
	run receiver(child_AnonymousTestTraceSymbolize56511);
	run sync_monitor(c1);
	run sync_monitor(c2);
	run AnonymousTestTraceSymbolize6160(c2,done1,done2,c1,child_AnonymousTestTraceSymbolize61602);
	run receiver(child_AnonymousTestTraceSymbolize61602);
	run mutexMonitor(mu);
	mu.Lock!false;
	run AnonymousTestTraceSymbolize6951(done1,done2,c1,c2,mu,child_AnonymousTestTraceSymbolize69513);
	run receiver(child_AnonymousTestTraceSymbolize69513);
	run wgMonitor(wg);
	wg.update!1;
	run AnonymousTestTraceSymbolize7551(done1,done2,c1,c2,wg,mu,child_AnonymousTestTraceSymbolize75514);
	run receiver(child_AnonymousTestTraceSymbolize75514);
	run AnonymousTestTraceSymbolize7951(done1,done2,c1,c2,wg,mu,child_AnonymousTestTraceSymbolize79515);
	run receiver(child_AnonymousTestTraceSymbolize79515);
	run AnonymousTestTraceSymbolize8859(c1,c2,done1,done2,wg,mu,child_AnonymousTestTraceSymbolize88596);
	run receiver(child_AnonymousTestTraceSymbolize88596);
	run sync_monitor(pipeReadDone);
	run AnonymousTestTraceSymbolize10355(done2,c1,c2,pipeReadDone,done1,wg,mu,child_AnonymousTestTraceSymbolize103557);
	run receiver(child_AnonymousTestTraceSymbolize103557);
	

	if
	:: done1.enq!0;
	:: done1.sync!false -> 
		done1.sending!false
	fi;
	

	if
	:: done2.deq?state,num_msgs;
	:: done2.sync?state -> 
		done2.rcving!false
	fi;
	do
	:: c1.enq!0 -> 
		break
	:: c1.sync!false -> 
		c1.sending!false;
		break
	:: c2.enq!0 -> 
		break
	:: c2.sync!false -> 
		c2.sending!false;
		break
	od;
	for20_exit: skip;
	mu.Unlock!false;
	wg.update!-1;
	

	if
	:: pipeReadDone.deq?state,num_msgs;
	:: pipeReadDone.sync?state -> 
		pipeReadDone.rcving!false
	fi;
		stop_process: skip;
		stop_process: skip;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceSymbolize5251(Chandef done1;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: done1.deq?state,num_msgs;
	:: done1.sync?state -> 
		done1.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceSymbolize5651(Chandef done1;Chandef done2;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: done2.enq!0;
	:: done2.sync!false -> 
		done2.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceSymbolize6160(Chandef c2;Chandef done1;Chandef done2;Chandef c1;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: c1.deq?state,num_msgs -> 
		break
	:: c1.sync?state -> 
		c1.rcving!false;
		break
	:: c2.deq?state,num_msgs -> 
		break
	:: c2.sync?state -> 
		c2.rcving!false;
		break
	od;
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceSymbolize6951(Chandef done1;Chandef done2;Chandef c1;Chandef c2;Mutexdef mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	mu.Lock!false;
	mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceSymbolize7551(Chandef done1;Chandef done2;Chandef c1;Chandef c2;Wgdef wg;Mutexdef mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceSymbolize7951(Chandef done1;Chandef done2;Chandef c1;Chandef c2;Wgdef wg;Mutexdef mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype AnonymousTestTraceSymbolize8859(Chandef c1;Chandef c2;Chandef done1;Chandef done2;Wgdef wg;Mutexdef mu;chan child) {
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
proctype AnonymousTestTraceSymbolize10355(Chandef done2;Chandef c1;Chandef c2;Chandef pipeReadDone;Chandef done1;Wgdef wg;Mutexdef mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: pipeReadDone.enq!0;
	:: pipeReadDone.sync!false -> 
		pipeReadDone.sending!false
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

