// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/crypto/tls/handshake_server_test.go#L182
#define ub_for952_2  -2
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
	chan child_TestRenegotiationExtension1820 = [1] of {int};
	run TestRenegotiationExtension182(child_TestRenegotiationExtension1820);
	run receiver(child_TestRenegotiationExtension1820)
stop_process:skip
}

proctype TestRenegotiationExtension182(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestRenegotiationExtension1941910 = [1] of {int};
	Chandef bufChan;
	

	if
	:: 1 > 0 -> 
		bufChan.size = 1;
		run AsyncChan(bufChan)
	:: else -> 
		run sync_monitor(bufChan)
	fi;
	run AnonymousTestRenegotiationExtension194191(bufChan,child_AnonymousTestRenegotiationExtension1941910);
	run receiver(child_AnonymousTestRenegotiationExtension1941910);
	

	if
	:: bufChan.deq?state,num_msgs;
	:: bufChan.sync?state -> 
		bufChan.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRenegotiationExtension194191(Chandef bufChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_writeRecord9980 = [1] of {int};
	Mutexdef cli_config_mutex;
	Mutexdef cli_handshakeMutex;
	run mutexMonitor(cli_handshakeMutex);
	run mutexMonitor(cli_config_mutex);
	run writeRecord998(cli_config_mutex,cli_handshakeMutex,child_writeRecord9980);
	child_writeRecord9980?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: bufChan.enq!0;
	:: bufChan.sync!false -> 
		bufChan.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype writeRecord998(Mutexdef c_config_mutex;Mutexdef c_handshakeMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_writeRecordLocked9380 = [1] of {int};
	run writeRecordLocked938(c_config_mutex,c_handshakeMutex,child_writeRecordLocked9380);
	child_writeRecordLocked9380?0;
	goto stop_process;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype writeRecordLocked938(Mutexdef c_config_mutex;Mutexdef c_handshakeMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_sendAlertLocked8046 = [1] of {int};
	chan child_write9065 = [1] of {int};
	chan child_rand9324 = [1] of {int};
	chan child_maxPayloadSizeForWrite8593 = [1] of {int};
	chan child_write9062 = [1] of {int};
	chan child_rand9321 = [1] of {int};
	chan child_maxPayloadSizeForWrite8590 = [1] of {int};
	

	if
	:: 0 != -2 && ub_for952_2 != -2 -> 
				for(i : 0.. ub_for952_2) {
			for11: skip;
			run maxPayloadSizeForWrite859(c_config_mutex,c_handshakeMutex,child_maxPayloadSizeForWrite8593);
			child_maxPayloadSizeForWrite8593?0;
			run rand932(c_config_mutex,child_rand9324);
			child_rand9324?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run write906(c_config_mutex,c_handshakeMutex,child_write9065);
			child_write9065?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run maxPayloadSizeForWrite859(c_config_mutex,c_handshakeMutex,child_maxPayloadSizeForWrite8590);
			child_maxPayloadSizeForWrite8590?0;
			run rand932(c_config_mutex,child_rand9321);
			child_rand9321?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			run write906(c_config_mutex,c_handshakeMutex,child_write9062);
			child_write9062?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			run sendAlertLocked804(c_config_mutex,c_handshakeMutex,child_sendAlertLocked8046);
			child_sendAlertLocked8046?0;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype maxPayloadSizeForWrite859(Mutexdef c_config_mutex;Mutexdef c_handshakeMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true;
		:: true;
		:: true;
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype rand932(Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype write906(Mutexdef c_config_mutex;Mutexdef c_handshakeMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype sendAlertLocked804(Mutexdef c_config_mutex;Mutexdef c_handshakeMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_writeRecordLocked9386 = [1] of {int};
	

	if
	:: true;
	:: true;
	fi;
	run writeRecordLocked938(c_config_mutex,c_handshakeMutex,child_writeRecordLocked9386);
	child_writeRecordLocked9386?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

