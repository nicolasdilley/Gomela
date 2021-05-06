
// https://github.com/syncthing/syncthing/blob/master/lib/model/requests_test.go#L1403
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
	chan child_TestRequestIssue747414030 = [1] of {int};
	run TestRequestIssue74741403(child_TestRequestIssue747414030)
stop_process:skip
}

proctype TestRequestIssue74741403(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_sendIndexUpdate1492 = [1] of {int};
	chan child_addFileWithLocalFlags1001 = [1] of {int};
	chan child_setIndexFn530 = [1] of {int};
	Chandef indexChan;
	Mutexdef fc_mut;
	Chandef done;
	run sync_monitor(done);
	run mutexMonitor(fc_mut);
	run sync_monitor(indexChan);
	run setIndexFn53(fc_mut,child_setIndexFn530);
	child_setIndexFn530?0;
	run addFileWithLocalFlags100(fc_mut,child_addFileWithLocalFlags1001);
	child_addFileWithLocalFlags1001?0;
	run sendIndexUpdate149(fc_mut,child_sendIndexUpdate1492);
	child_sendIndexUpdate1492?0;
	do
	:: true -> 
		break
	:: indexChan.deq?state,num_msgs -> 
		break
	:: indexChan.sync?state -> 
		indexChan.rcving!false;
		break
	od;
	stop_process: skip;
		done.closing!true;
	child!0
}
proctype setIndexFn53(Mutexdef f_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype addFileWithLocalFlags100(Mutexdef f_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_addFileLocked651 = [1] of {int};
	f_mut.Lock!false;
	run addFileLocked65(f_mut,child_addFileLocked651);
	child_addFileLocked651?0;
	stop_process: skip;
		f_mut.Unlock!false;
	child!0
}
proctype addFileLocked65(Mutexdef f_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true;
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype sendIndexUpdate149(Mutexdef f_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.rcving?false;
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.sync!true -> 
		 ch.num_msgs = ch.num_msgs - 1
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

