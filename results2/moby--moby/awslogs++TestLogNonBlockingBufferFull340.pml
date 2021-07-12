// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/moby/moby/blob/5a82cee6d499e51bc903a743e4f0f205adb161a9/daemon/logger/awslogs/cloudwatchlogs_test.go#L340
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
	chan child_TestLogNonBlockingBufferFull3400 = [1] of {int};
	run TestLogNonBlockingBufferFull340(child_TestLogNonBlockingBufferFull3400);
	run receiver(child_TestLogNonBlockingBufferFull3400)
stop_process:skip
}

proctype TestLogNonBlockingBufferFull340(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestLogNonBlockingBufferFull3503420 = [1] of {int};
	Chandef started_ch;
	Chandef errorCh_ch;
	Mutexdef stream_lock;
	Chandef stream_messages_ch;
	

	if
	:: 1 > 0 -> 
		stream_messages_ch.size = 1;
		run AsyncChan(stream_messages_ch)
	:: else -> 
		run sync_monitor(stream_messages_ch)
	fi;
	run mutexMonitor(stream_lock);
	

	if
	:: stream_messages_ch.enq!0;
	:: stream_messages_ch.sync!false -> 
		stream_messages_ch.sending!false
	fi;
	

	if
	:: 1 > 0 -> 
		errorCh_ch.size = 1;
		run AsyncChan(errorCh_ch)
	:: else -> 
		run sync_monitor(errorCh_ch)
	fi;
	run sync_monitor(started_ch);
	run AnonymousTestLogNonBlockingBufferFull350342(stream_messages_ch,errorCh_ch,started_ch,stream_lock,child_AnonymousTestLogNonBlockingBufferFull3503420);
	run receiver(child_AnonymousTestLogNonBlockingBufferFull3503420);
	

	if
	:: started_ch.deq?state,num_msgs;
	:: started_ch.sync?state -> 
		started_ch.rcving!false
	fi;
	do
	:: errorCh_ch.deq?state,num_msgs -> 
		break
	:: errorCh_ch.sync?state -> 
		errorCh_ch.rcving!false;
		break
	:: true -> 
		break
	od;
	for20_exit: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestLogNonBlockingBufferFull350342(Chandef stream_messages_ch;Chandef errorCh_ch;Chandef started_ch;Mutexdef stream_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Log4090 = [1] of {int};
	

	if
	:: started_ch.enq!0;
	:: started_ch.sync!false -> 
		started_ch.sending!false
	fi;
	run Log409(stream_messages_ch,stream_lock,child_Log4090);
	child_Log4090?0;
	

	if
	:: errorCh_ch.enq!0;
	:: errorCh_ch.sync!false -> 
		errorCh_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype Log409(Chandef l_messages_ch;Mutexdef l_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	l_lock.RLock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		do
		:: l_messages_ch.enq!0 -> 
			goto defer1
		:: l_messages_ch.sync!false -> 
			l_messages_ch.sending!false;
			goto defer1
		:: true -> 
			goto defer1
		od;
		for10_exit: skip
	:: true;
	fi;
	

	if
	:: l_messages_ch.enq!0;
	:: l_messages_ch.sync!false -> 
		l_messages_ch.sending!false
	fi;
	goto defer1;
		defer1: skip;
	l_lock.RUnlock!false;
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

