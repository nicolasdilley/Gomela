// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/valyala/fasthttp/blob/19fcd408632d6dae8425ae95c6c62a25c823ff81/fasthttputil/pipeconns_test.go#L147
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
	chan child_testPipeConnsCloseWhileReadWrite1470 = [1] of {int};
	run testPipeConnsCloseWhileReadWrite147(child_testPipeConnsCloseWhileReadWrite1470);
	run receiver(child_testPipeConnsCloseWhileReadWrite1470)
stop_process:skip
}

proctype testPipeConnsCloseWhileReadWrite147(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymoustestPipeConnsCloseWhileReadWrite1661523 = [1] of {int};
	Chandef writeCh_ch;
	chan child_AnonymoustestPipeConnsCloseWhileReadWrite1531522 = [1] of {int};
	Chandef readCh_ch;
	chan child_Conn2631 = [1] of {int};
	chan child_Conn1550 = [1] of {int};
	Mutexdef pc_stopChLock;
	Mutexdef pc_c2_readDeadlineChLock;
	Mutexdef pc_c1_readDeadlineChLock;
	run mutexMonitor(pc_c1_readDeadlineChLock);
	run mutexMonitor(pc_c2_readDeadlineChLock);
	run mutexMonitor(pc_stopChLock);
	run Conn155(pc_c1_readDeadlineChLock,pc_c2_readDeadlineChLock,pc_stopChLock,child_Conn1550);
	child_Conn1550?0;
	run Conn263(pc_c1_readDeadlineChLock,pc_c2_readDeadlineChLock,pc_stopChLock,child_Conn2631);
	child_Conn2631?0;
	run sync_monitor(readCh_ch);
	run AnonymoustestPipeConnsCloseWhileReadWrite153152(readCh_ch,pc_c1_readDeadlineChLock,pc_c2_readDeadlineChLock,pc_stopChLock,child_AnonymoustestPipeConnsCloseWhileReadWrite1531522);
	run receiver(child_AnonymoustestPipeConnsCloseWhileReadWrite1531522);
	run sync_monitor(writeCh_ch);
	run AnonymoustestPipeConnsCloseWhileReadWrite166152(readCh_ch,writeCh_ch,pc_c1_readDeadlineChLock,pc_c2_readDeadlineChLock,pc_stopChLock,child_AnonymoustestPipeConnsCloseWhileReadWrite1661523);
	run receiver(child_AnonymoustestPipeConnsCloseWhileReadWrite1661523);
	do
	:: readCh_ch.deq?state,num_msgs -> 
		break
	:: readCh_ch.sync?state -> 
		readCh_ch.rcving!false;
		break
	:: true -> 
		break
	od;
	for20_exit: skip;
	for20_end: skip;
	do
	:: writeCh_ch.deq?state,num_msgs -> 
		break
	:: writeCh_ch.sync?state -> 
		writeCh_ch.rcving!false;
		break
	:: true -> 
		break
	od;
	for30_exit: skip;
	for30_end: skip;
	stop_process: skip;
	child!0
}
proctype Conn155(Mutexdef pc_c1_readDeadlineChLock;Mutexdef pc_c2_readDeadlineChLock;Mutexdef pc_stopChLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Conn263(Mutexdef pc_c1_readDeadlineChLock;Mutexdef pc_c2_readDeadlineChLock;Mutexdef pc_stopChLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymoustestPipeConnsCloseWhileReadWrite153152(Chandef readCh_ch;Mutexdef pc_c1_readDeadlineChLock;Mutexdef pc_c2_readDeadlineChLock;Mutexdef pc_stopChLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: readCh_ch.enq!0;
	:: readCh_ch.sync!false -> 
		readCh_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymoustestPipeConnsCloseWhileReadWrite166152(Chandef readCh_ch;Chandef writeCh_ch;Mutexdef pc_c1_readDeadlineChLock;Mutexdef pc_c2_readDeadlineChLock;Mutexdef pc_stopChLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: writeCh_ch.enq!0;
	:: writeCh_ch.sync!false -> 
		writeCh_ch.sending!false
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
