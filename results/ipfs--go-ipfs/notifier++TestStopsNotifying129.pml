// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ipfs/go-ipfs/blob//thirdparty/notifier/notifier_test.go#L129
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
	chan child_TestStopsNotifying1290 = [1] of {int};
	run TestStopsNotifying129(child_TestStopsNotifying1290);
	run receiver(child_TestStopsNotifying1290)
stop_process:skip
}

proctype TestStopsNotifying129(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Receive385 = [1] of {int};
	chan child_Receive384 = [1] of {int};
	chan child_StopNotify283 = [1] of {int};
	chan child_Receive382 = [1] of {int};
	chan child_Receive381 = [1] of {int};
	chan child_Notify240 = [1] of {int};
	Mutexdef r_notifier_mu;
	Chandef r_queue_ch;
	Chandef m_received_ch;
	run sync_monitor(m_received_ch);
	

	if
	:: 10 > 0 -> 
		r_queue_ch.size = 10;
		run AsyncChan(r_queue_ch)
	:: else -> 
		run sync_monitor(r_queue_ch)
	fi;
	run mutexMonitor(r_notifier_mu);
	run Notify24(r_queue_ch,r_notifier_mu,child_Notify240);
	child_Notify240?0;
	

	if
	:: 0 != -2 && 5-1 != -3 -> 
				for(i : 0.. 5-1) {
			for14: skip;
			run Receive38(r_queue_ch,r_notifier_mu,child_Receive382);
			child_Receive382?0;
			

			if
			:: m_received_ch.deq?state,num_msgs;
			:: m_received_ch.sync?state -> 
				m_received_ch.rcving!false
			fi;
			for14_end: skip
		};
		for14_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Receive38(r_queue_ch,r_notifier_mu,child_Receive381);
			child_Receive381?0;
			

			if
			:: m_received_ch.deq?state,num_msgs;
			:: m_received_ch.sync?state -> 
				m_received_ch.rcving!false
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run StopNotify28(r_queue_ch,r_notifier_mu,child_StopNotify283);
	child_StopNotify283?0;
	

	if
	:: 0 != -2 && 5-1 != -3 -> 
				for(i : 0.. 5-1) {
			for22: skip;
			run Receive38(r_queue_ch,r_notifier_mu,child_Receive385);
			child_Receive385?0;
			do
			:: m_received_ch.deq?state,num_msgs -> 
				break
			:: m_received_ch.sync?state -> 
				m_received_ch.rcving!false;
				break
			:: true -> 
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
			run Receive38(r_queue_ch,r_notifier_mu,child_Receive384);
			child_Receive384?0;
			do
			:: m_received_ch.deq?state,num_msgs -> 
				break
			:: m_received_ch.sync?state -> 
				m_received_ch.rcving!false;
				break
			:: true -> 
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
proctype Receive38(Chandef r_queue_ch;Mutexdef r_notifier_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_notifyAll321 = [1] of {int};
	chan child_notifyAll322 = [1] of {int};
	chan child_notifyAll323 = [1] of {int};
	do
	:: r_queue_ch.enq!0 -> 
		run notifyAll32(r_queue_ch,r_notifier_mu,child_notifyAll321);
		child_notifyAll321?0;
		break
	:: r_queue_ch.sync!false -> 
		r_queue_ch.sending!false;
		run notifyAll32(r_queue_ch,r_notifier_mu,child_notifyAll322);
		child_notifyAll322?0;
		break
	:: true -> 
		run notifyAll32(r_queue_ch,r_notifier_mu,child_notifyAll323);
		child_notifyAll323?0;
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
	chan child_NotifyAll1211 = [1] of {int};
	run NotifyAll121(r_notifier_mu,child_NotifyAll1211);
	child_NotifyAll1211?0;
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
proctype StopNotify28(Chandef r_queue_ch;Mutexdef r_notifier_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StopNotify883 = [1] of {int};
	run StopNotify88(r_notifier_mu,child_StopNotify883);
	child_StopNotify883?0;
	stop_process: skip;
	child!0
}
proctype StopNotify88(Mutexdef n_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	n_mu.Lock!false;
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

