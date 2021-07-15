#define numIterations220  3
#define numReaders220  0
#define ub_for232_2  3

// https://github.com/minio/minio/blob/master/pkg/lsync/lrwmutex_test.go#L220
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
	chan child_HammerRWMutex2200 = [1] of {int};
	run HammerRWMutex220(numIterations220,numReaders220,child_HammerRWMutex2200)
stop_process:skip
}

proctype HammerRWMutex220(int numIterations;int numReaders;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_reader1864 = [1] of {int};
	chan child_writer2033 = [1] of {int};
	chan child_reader1861 = [1] of {int};
	chan child_writer2030 = [1] of {int};
	Chandef cdone;
	Mutexdef rwm_mu;
	run mutexMonitor(rwm_mu);
	run sync_monitor(cdone);
	run writer203(rwm_mu,cdone,numIterations,child_writer2030);
		for(i : 0.. numReaders / 2-1) {
		for20: skip;
		run reader186(rwm_mu,cdone,numIterations,child_reader1861);
		for20_end: skip
	};
	for20_exit: skip;
	run writer203(rwm_mu,cdone,numIterations,child_writer2033);
		for(i : 0.. ub_for232_2) {
		for30: skip;
		run reader186(rwm_mu,cdone,numIterations,child_reader1864);
		for30_end: skip
	};
	for30_exit: skip;
	

	if
	:: 0 != -2 && 2 + numReaders-1 != -3 -> 
				for(i : 0.. 2 + numReaders-1) {
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
proctype writer203(Mutexdef rwm_mu;Chandef cdone;int numIterations;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: cdone.enq!0;
	:: cdone.sync!false -> 
		cdone.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype reader186(Mutexdef rwm_mu;Chandef cdone;int numIterations;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: cdone.enq!0;
	:: cdone.sync!false -> 
		cdone.sending!false
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


