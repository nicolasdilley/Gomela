// num_comm_params=2
// num_mand_comm_params=1
// num_opt_comm_params=1

// git_link=https://github.com/valyala/fasthttp/blob/19fcd408632d6dae8425ae95c6c62a25c823ff81/client_test.go#L121
#define TestPipelineClientIssue832_attempts  ??
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
	chan child_TestPipelineClientIssue8321210 = [1] of {int};
	run TestPipelineClientIssue832121(child_TestPipelineClientIssue8321210);
	run receiver(child_TestPipelineClientIssue8321210)
stop_process:skip
}

proctype TestPipelineClientIssue832121(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestPipelineClientIssue8321581571 = [1] of {int};
	Chandef done_ch;
	chan child_AnonymousTestPipelineClientIssue8321421240 = [1] of {int};
	Mutexdef client_connClientsLock;
	Mutexdef client_TLSConfig_mutex;
	Mutexdef ln_lock;
	run mutexMonitor(ln_lock);
	run mutexMonitor(client_TLSConfig_mutex);
	run mutexMonitor(client_connClientsLock);
	run AnonymousTestPipelineClientIssue832142124(ln_lock,client_TLSConfig_mutex,client_connClientsLock,child_AnonymousTestPipelineClientIssue8321421240);
	run receiver(child_AnonymousTestPipelineClientIssue8321421240);
	run sync_monitor(done_ch);
	run AnonymousTestPipelineClientIssue832158157(done_ch,ln_lock,client_TLSConfig_mutex,client_connClientsLock,child_AnonymousTestPipelineClientIssue8321581571);
	run receiver(child_AnonymousTestPipelineClientIssue8321581571);
	do
	:: true -> 
		break
	:: done_ch.deq?state,num_msgs -> 
		break
	:: done_ch.sync?state -> 
		done_ch.rcving!false;
		break
	od;
	for30_exit: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestPipelineClientIssue832142124(Mutexdef ln_lock;Mutexdef client_TLSConfig_mutex;Mutexdef client_connClientsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousAnonymousTestPipelineClientIssue8321421491241 = [1] of {int};
	chan child_Accept14680 = [1] of {int};
	int var_attempts = TestPipelineClientIssue832_attempts; // mand var_attempts
		for(i : 0.. var_attempts-1) {
		for10: skip;
		run Accept1468(ln_lock,child_Accept14680);
		child_Accept14680?0;
		

		if
		:: true -> 
			run AnonymousAnonymousTestPipelineClientIssue832142149124(ln_lock,client_TLSConfig_mutex,client_connClientsLock,child_AnonymousAnonymousTestPipelineClientIssue8321421491241);
			run receiver(child_AnonymousAnonymousTestPipelineClientIssue8321421491241)
		:: true;
		fi;
		for10_end: skip
	};
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype Accept1468(Mutexdef ln_lock;chan child) {
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
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousAnonymousTestPipelineClientIssue832142149124(Mutexdef ln_lock;Mutexdef client_TLSConfig_mutex;Mutexdef client_connClientsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype AnonymousTestPipelineClientIssue832158157(Chandef done_ch;Mutexdef ln_lock;Mutexdef client_TLSConfig_mutex;Mutexdef client_connClientsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Do24332 = [1] of {int};
	chan child_Do24331 = [1] of {int};
	int var_attemptsattempts = -2; // opt var_attemptsattempts
	

	if
	:: 0 != -2 && var_attempts-1 != -3 -> 
				for(i : 0.. var_attempts-1) {
			for21: skip;
			run Do2433(client_connClientsLock,client_TLSConfig_mutex,child_Do24332);
			child_Do24332?0;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run Do2433(client_connClientsLock,client_TLSConfig_mutex,child_Do24331);
			child_Do24331?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
		defer1: skip;
	done.closing!true;
	stop_process: skip;
	child!0
}
proctype Do2433(Mutexdef c_connClientsLock;Mutexdef c_TLSConfig_mutex;chan child) {
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

