#define not_found_{ab}71420  -2

// https://github.com/syncthing/syncthing/blob/master/lib/model/requests_test.go#L689
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
	chan child_TestRequestRemoteRenameChanged6890 = [1] of {int};
	run TestRequestRemoteRenameChanged689(child_TestRequestRemoteRenameChanged6890)
stop_process:skip
}

proctype TestRequestRemoteRenameChanged689(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_sendIndexUpdate1497 = [1] of {int};
	chan child_updateFile1186 = [1] of {int};
	chan child_deleteFile1315 = [1] of {int};
	chan child_setIndexFn534 = [1] of {int};
	Chandef done;
	chan child_sendIndexUpdate1493 = [1] of {int};
	chan child_addFile1091 = [1] of {int};
	chan child_addFile1092 = [1] of {int};
	chan child_setIndexFn530 = [1] of {int};
	Chandef received;
	Mutexdef fc_mut;
	run mutexMonitor(fc_mut);
	run sync_monitor(received);
	run setIndexFn53(fc_mut,child_setIndexFn530);
	child_setIndexFn530?0;
	

	if
	:: not_found_{ab}71420-1 != -3 -> 
				for(i : 0.. not_found_{ab}71420-1) {
			for10: skip;
			run addFile109(fc_mut,child_addFile1091);
			child_addFile1091?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run addFile109(fc_mut,child_addFile1092);
			child_addFile1092?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	run sendIndexUpdate149(fc_mut,child_sendIndexUpdate1493);
	child_sendIndexUpdate1493?0;
	do
	:: received.deq?state,num_msgs -> 
		received.closing!true;
		break
	:: received.sync?state -> 
		received.rcving!false;
		received.closing!true;
		break
	:: true -> 
		break
	od;
	run sync_monitor(done);
	run setIndexFn53(fc_mut,child_setIndexFn534);
	child_setIndexFn534?0;
	run deleteFile131(fc_mut,child_deleteFile1315);
	child_deleteFile1315?0;
	run updateFile118(fc_mut,child_updateFile1186);
	child_updateFile1186?0;
	fc_mut.Lock!false;
	fc_mut.Unlock!false;
	run sendIndexUpdate149(fc_mut,child_sendIndexUpdate1497);
	child_sendIndexUpdate1497?0;
	do
	:: done.deq?state,num_msgs -> 
		break
	:: done.sync?state -> 
		done.rcving!false;
		break
	:: true -> 
		break
	od;
	stop_process: skip;
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
proctype addFile109(Mutexdef f_mut;chan child) {
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
proctype deleteFile131(Mutexdef f_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	f_mut.Lock!false;
	stop_process: skip;
		f_mut.Unlock!false;
	child!0
}
proctype updateFile118(Mutexdef f_mut;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_addFileLocked656 = [1] of {int};
	chan child_addFileLocked657 = [1] of {int};
	int f_files = -2;
	f_mut.Lock!false;
	

	if
	:: f_files-1 != -3 -> 
				for(i : 0.. f_files-1) {
			for50: skip;
			

			if
			:: true -> 
				run addFileLocked65(f_mut,child_addFileLocked656);
				child_addFileLocked656?0;
				goto stop_process
			:: true;
			fi;
			for50_end: skip
		};
		for50_exit: skip
	:: else -> 
		do
		:: true -> 
			for51: skip;
			

			if
			:: true -> 
				run addFileLocked65(f_mut,child_addFileLocked657);
				child_addFileLocked657?0;
				goto stop_process
			:: true;
			fi;
			for51_end: skip
		:: true -> 
			break
		od;
		for51_exit: skip
	fi;
	stop_process: skip;
		f_mut.Unlock!false;
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

