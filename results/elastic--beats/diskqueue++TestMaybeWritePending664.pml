// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//libbeat/publisher/queue/diskqueue/core_loop_test.go#L664
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
	chan child_TestMaybeWritePending6640 = [1] of {int};
	run TestMaybeWritePending664(child_TestMaybeWritePending6640);
	run receiver(child_TestMaybeWritePending6640)
stop_process:skip
}

proctype TestMaybeWritePending664(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_maybeWritePending3072 = [1] of {int};
	chan child_maybeWritePending3071 = [1] of {int};
	chan child_maybeWritePending3070 = [1] of {int};
	Wgdef dq_waitGroup;
	Mutexdef dq_acks_lock;
	Chandef dq_writerLoop_requestChan_ch;
	

	if
	:: 1 > 0 -> 
		dq_writerLoop_requestChan_ch.size = 1;
		run AsyncChan(dq_writerLoop_requestChan_ch)
	:: else -> 
		run sync_monitor(dq_writerLoop_requestChan_ch)
	fi;
	run mutexMonitor(dq_acks_lock);
	run wgMonitor(dq_waitGroup);
	run maybeWritePending307(dq_writerLoop_requestChan_ch,dq_waitGroup,dq_acks_lock,child_maybeWritePending3070);
	child_maybeWritePending3070?0;
	do
	:: dq_writerLoop_requestChan_ch.deq?state,num_msgs -> 
		break
	:: dq_writerLoop_requestChan_ch.sync?state -> 
		dq_writerLoop_requestChan_ch.rcving!false;
		break
	:: true -> 
		break
	od;
	for20_exit: skip;
	for20_end: skip;
	run maybeWritePending307(dq_writerLoop_requestChan_ch,dq_waitGroup,dq_acks_lock,child_maybeWritePending3071);
	child_maybeWritePending3071?0;
	do
	:: dq_writerLoop_requestChan_ch.deq?state,num_msgs -> 
		break
	:: dq_writerLoop_requestChan_ch.sync?state -> 
		dq_writerLoop_requestChan_ch.rcving!false;
		break
	:: true -> 
		break
	od;
	for30_exit: skip;
	for30_end: skip;
	run maybeWritePending307(dq_writerLoop_requestChan_ch,dq_waitGroup,dq_acks_lock,child_maybeWritePending3072);
	child_maybeWritePending3072?0;
	do
	:: dq_writerLoop_requestChan_ch.deq?state,num_msgs -> 
		break
	:: dq_writerLoop_requestChan_ch.sync?state -> 
		dq_writerLoop_requestChan_ch.rcving!false;
		break
	:: true -> 
		break
	od;
	for40_exit: skip;
	for40_end: skip;
	stop_process: skip;
	child!0
}
proctype maybeWritePending307(Chandef dq_writerLoop_requestChan_ch;Wgdef dq_waitGroup;Mutexdef dq_acks_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_frames = -2; // opt var_frames
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: dq_writerLoop_requestChan_ch.enq!0;
	:: dq_writerLoop_requestChan_ch.sync!false -> 
		dq_writerLoop_requestChan_ch.sending!false
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

