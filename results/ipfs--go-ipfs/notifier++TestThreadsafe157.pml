// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/ipfs/go-ipfs/blob//thirdparty/notifier/notifier_test.go#L157
#define def_var_N169  ?? // mand N line 169
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
	chan child_TestThreadsafe1570 = [1] of {int};
	run TestThreadsafe157(child_TestThreadsafe1570);
	run receiver(child_TestThreadsafe1570)
stop_process:skip
}

proctype TestThreadsafe157(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_String9513 = [1] of {int};
	chan child_String9512 = [1] of {int};
	chan child_String9511 = [1] of {int};
	chan child_String9510 = [1] of {int};
	chan child_String959 = [1] of {int};
	chan child_String958 = [1] of {int};
	chan child_String957 = [1] of {int};
	chan child_AnonymousTestThreadsafe1801624 = [1] of {int};
	chan child_AnonymousTestThreadsafe1721613 = [1] of {int};
	Wgdef wg;
	chan child_Notify242 = [1] of {int};
	chan child_Notify241 = [1] of {int};
	chan child_Notify240 = [1] of {int};
	Chandef m3_received_ch;
	Chandef m2_received_ch;
	Chandef m1_received_ch;
	Mutexdef r_notifier_mu;
	Chandef r_queue_ch;
	int var_n = -2; // opt var_n
	int var_N = def_var_N169; // mand var_N
	

	if
	:: 10 > 0 -> 
		r_queue_ch.size = 10;
		run AsyncChan(r_queue_ch)
	:: else -> 
		run sync_monitor(r_queue_ch)
	fi;
	run mutexMonitor(r_notifier_mu);
	run sync_monitor(m1_received_ch);
	run sync_monitor(m2_received_ch);
	run sync_monitor(m3_received_ch);
	run Notify24(r_queue_ch,r_notifier_mu,child_Notify240);
	child_Notify240?0;
	run Notify24(r_queue_ch,r_notifier_mu,child_Notify241);
	child_Notify241?0;
	run Notify24(r_queue_ch,r_notifier_mu,child_Notify242);
	child_Notify242?0;
	run wgMonitor(wg);
		for(i : 0.. var_N-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestThreadsafe172161(m2_received_ch,m3_received_ch,r_queue_ch,m1_received_ch,wg,r_notifier_mu,child_AnonymousTestThreadsafe1721613);
		run receiver(child_AnonymousTestThreadsafe1721613);
		

		if
		:: true -> 
			wg.update!1;
			run AnonymousTestThreadsafe180162(m3_received_ch,r_queue_ch,m1_received_ch,m2_received_ch,wg,r_notifier_mu,child_AnonymousTestThreadsafe1801624);
			run receiver(child_AnonymousTestThreadsafe1801624)
		:: true;
		fi;
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && var_n*3-1 != -3 -> 
				for(i : 0.. var_n*3-1) {
			for22: skip;
			do
			:: m1_received_ch.deq?state,num_msgs -> 
				break
			:: m1_received_ch.sync?state -> 
				m1_received_ch.rcving!false;
				break
			:: m2_received_ch.deq?state,num_msgs -> 
				break
			:: m2_received_ch.sync?state -> 
				m2_received_ch.rcving!false;
				break
			:: m3_received_ch.deq?state,num_msgs -> 
				break
			:: m3_received_ch.sync?state -> 
				m3_received_ch.rcving!false;
				break
			od;
			for23_exit: skip;
			for23_end: skip;
			for22_end: skip
		};
		for22_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			do
			:: m1_received_ch.deq?state,num_msgs -> 
				break
			:: m1_received_ch.sync?state -> 
				m1_received_ch.rcving!false;
				break
			:: m2_received_ch.deq?state,num_msgs -> 
				break
			:: m2_received_ch.sync?state -> 
				m2_received_ch.rcving!false;
				break
			:: m3_received_ch.deq?state,num_msgs -> 
				break
			:: m3_received_ch.sync?state -> 
				m3_received_ch.rcving!false;
				break
			od;
			for21_exit: skip;
			for21_end: skip;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	wg.wait?0;
	run String95(m1_received_ch,child_String957);
	child_String957?0;
	run String95(m2_received_ch,child_String958);
	child_String958?0;
	run String95(m3_received_ch,child_String959);
	child_String959?0;
	run String95(m1_received_ch,child_String9510);
	child_String9510?0;
	run String95(m2_received_ch,child_String9511);
	child_String9511?0;
	run String95(m2_received_ch,child_String9512);
	child_String9512?0;
	run String95(m3_received_ch,child_String9513);
	child_String9513?0;
	stop_process: skip;
	child!0
}
proctype Notify24(Chandef r_queue_ch;Mutexdef r_notifier_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Notify650 = [1] of {int};
	run Notify65(r_notifier_mu,child_Notify650);
	child_Notify650?0;
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
proctype AnonymousTestThreadsafe172161(Chandef m2_received_ch;Chandef m3_received_ch;Chandef r_queue_ch;Chandef m1_received_ch;Wgdef wg;Mutexdef r_notifier_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Receive383 = [1] of {int};
	run Receive38(r_queue_ch,r_notifier_mu,child_Receive383);
	child_Receive383?0;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype Receive38(Chandef r_queue_ch;Mutexdef r_notifier_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_notifyAll323 = [1] of {int};
	chan child_notifyAll324 = [1] of {int};
	chan child_notifyAll325 = [1] of {int};
	do
	:: r_queue_ch.enq!0 -> 
		run notifyAll32(r_queue_ch,r_notifier_mu,child_notifyAll323);
		child_notifyAll323?0;
		break
	:: r_queue_ch.sync!false -> 
		r_queue_ch.sending!false;
		run notifyAll32(r_queue_ch,r_notifier_mu,child_notifyAll324);
		child_notifyAll324?0;
		break
	:: true -> 
		run notifyAll32(r_queue_ch,r_notifier_mu,child_notifyAll325);
		child_notifyAll325?0;
		break
	od;
	for11_exit: skip;
	for11_end: skip;
	stop_process: skip;
	child!0
}
proctype notifyAll32(Chandef r_queue_ch;Mutexdef r_notifier_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NotifyAll1213 = [1] of {int};
	run NotifyAll121(r_notifier_mu,child_NotifyAll1213);
	child_NotifyAll1213?0;
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
proctype AnonymousTestThreadsafe180162(Chandef m3_received_ch;Chandef r_queue_ch;Chandef m1_received_ch;Chandef m2_received_ch;Wgdef wg;Mutexdef r_notifier_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Forward534 = [1] of {int};
	run Forward53(r_queue_ch,r_notifier_mu,child_Forward534);
	child_Forward534?0;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype Forward53(Chandef r_queue_ch;Mutexdef r_notifier_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_notifyAll324 = [1] of {int};
	

	if
	:: r_queue_ch.deq?state,num_msgs;
	:: r_queue_ch.sync?state -> 
		r_queue_ch.rcving!false
	fi;
	run notifyAll32(r_queue_ch,r_notifier_mu,child_notifyAll324);
	child_notifyAll324?0;
	stop_process: skip;
	child!0
}
proctype String95(Chandef m_received_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

