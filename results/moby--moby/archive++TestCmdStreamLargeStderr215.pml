// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/moby/moby/blob//pkg/archive/archive_test.go#L215
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
	chan child_TestCmdStreamLargeStderr2150 = [1] of {int};
	run TestCmdStreamLargeStderr215(child_TestCmdStreamLargeStderr2150);
	run receiver(child_TestCmdStreamLargeStderr2150)
stop_process:skip
}

proctype TestCmdStreamLargeStderr215(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestCmdStreamLargeStderr2222211 = [1] of {int};
	Chandef errCh_ch;
	chan child_cmdStream12370 = [1] of {int};
	Mutexdef cmd_Process_sigMu;
	run mutexMonitor(cmd_Process_sigMu);
	run cmdStream1237(cmd_Process_sigMu,child_cmdStream12370);
	child_cmdStream12370?0;
	

	if
	:: 1 > 0 -> 
		errCh_ch.size = 1;
		run AsyncChan(errCh_ch)
	:: else -> 
		run sync_monitor(errCh_ch)
	fi;
	run AnonymousTestCmdStreamLargeStderr222221(errCh_ch,cmd_Process_sigMu,child_AnonymousTestCmdStreamLargeStderr2222211);
	run receiver(child_AnonymousTestCmdStreamLargeStderr2222211);
	do
	:: errCh_ch.deq?state,num_msgs -> 
		break
	:: errCh_ch.sync?state -> 
		errCh_ch.rcving!false;
		break
	:: true -> 
		break
	od;
	for10_exit: skip;
	for10_end: skip;
	stop_process: skip;
	child!0
}
proctype cmdStream1237(Mutexdef cmd_Process_sigMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewReadCloserWrapper241 = [1] of {int};
	chan child_AnonymouscmdStream125312500 = [1] of {int};
	Chandef done_ch;
	Mutexdef pipeW_p_once_m;
	Mutexdef pipeW_p_wrMu;
	Mutexdef pipeR_p_once_m;
	Mutexdef pipeR_p_wrMu;
	run mutexMonitor(pipeR_p_wrMu);
	run mutexMonitor(pipeR_p_once_m);
	run mutexMonitor(pipeW_p_wrMu);
	run mutexMonitor(pipeW_p_once_m);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(done_ch);
	run AnonymouscmdStream12531250(done_ch,cmd_Process_sigMu,pipeR_p_wrMu,pipeR_p_once_m,pipeW_p_wrMu,pipeW_p_once_m,child_AnonymouscmdStream125312500);
	run receiver(child_AnonymouscmdStream125312500);
	run NewReadCloserWrapper24(pipeR_p_once_m,pipeR_p_wrMu,child_NewReadCloserWrapper241);
	child_NewReadCloserWrapper241?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymouscmdStream12531250(Chandef done_ch;Mutexdef cmd_Process_sigMu;Mutexdef pipeR_p_wrMu;Mutexdef pipeR_p_once_m;Mutexdef pipeW_p_wrMu;Mutexdef pipeW_p_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	done_ch.closing!true;
	stop_process: skip;
	child!0
}
proctype NewReadCloserWrapper24(Mutexdef r_p_once_m;Mutexdef r_p_wrMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousTestCmdStreamLargeStderr222221(Chandef errCh_ch;Mutexdef cmd_Process_sigMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: errCh_ch.enq!0;
	:: errCh_ch.sync!false -> 
		errCh_ch.sending!false
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

