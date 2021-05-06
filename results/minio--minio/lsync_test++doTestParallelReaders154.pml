#define numReaders154  3

// https://github.com/minio/minio/blob/master/pkg/lsync/lrwmutex_test.go#L154
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
	chan child_doTestParallelReaders1540 = [1] of {int};
	run doTestParallelReaders154(numReaders154,child_doTestParallelReaders1540)
stop_process:skip
}

proctype doTestParallelReaders154(int numReaders;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_parallelReader1440 = [1] of {int};
	Chandef cdone;
	Chandef cunlock;
	Chandef clocked;
	Mutexdef m_mu;
	run mutexMonitor(m_mu);
	run sync_monitor(clocked);
	run sync_monitor(cunlock);
	run sync_monitor(cdone);
		for(i : 0.. numReaders-1) {
		for10: skip;
		run parallelReader144(m_mu,clocked,cunlock,cdone,child_parallelReader1440);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && numReaders-1 != -3 -> 
				for(i : 0.. numReaders-1) {
			for21: skip;
			

			if
			:: clocked.deq?state,num_msgs;
			:: clocked.sync?state -> 
				clocked.rcving!false
			fi;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: clocked.deq?state,num_msgs;
			:: clocked.sync?state -> 
				clocked.rcving!false
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	

	if
	:: 0 != -2 && numReaders-1 != -3 -> 
				for(i : 0.. numReaders-1) {
			for31: skip;
			

			if
			:: cunlock.enq!0;
			:: cunlock.sync!false -> 
				cunlock.sending!false
			fi;
			for31_end: skip
		};
		for31_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: cunlock.enq!0;
			:: cunlock.sync!false -> 
				cunlock.sending!false
			fi;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	

	if
	:: 0 != -2 && numReaders-1 != -3 -> 
				for(i : 0.. numReaders-1) {
			for41: skip;
			

			if
			:: cdone.deq?state,num_msgs;
			:: cdone.sync?state -> 
				cdone.rcving!false
			fi;
			for41_end: skip
		};
		for41_exit: skip
	:: else -> 
		do
		:: true -> 
			for40: skip;
			

			if
			:: cdone.deq?state,num_msgs;
			:: cdone.sync?state -> 
				cdone.rcving!false
			fi;
			for40_end: skip
		:: true -> 
			break
		od;
		for40_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype parallelReader144(Mutexdef m_mu;Chandef clocked;Chandef cunlock;Chandef cdone;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: clocked.enq!0;
		:: clocked.sync!false -> 
			clocked.sending!false
		fi;
		

		if
		:: cunlock.deq?state,num_msgs;
		:: cunlock.sync?state -> 
			cunlock.rcving!false
		fi;
		

		if
		:: cdone.enq!0;
		:: cdone.sync!false -> 
			cdone.sending!false
		fi
	:: true;
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

