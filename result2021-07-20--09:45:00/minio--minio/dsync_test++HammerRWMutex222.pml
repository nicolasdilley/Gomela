// num_comm_params=2
// num_mand_comm_params=1
// num_opt_comm_params=1

// git_link=https://github.com/minio/minio/blob/e948e7cdf65028f7a8545d1a05c2baea75198bd0/pkg/dsync/drwmutex_test.go#L222
#define var_numIterations  -2 // opt numIterations line 222
#define var_numReaders  ?? // mand numReaders line 222
#define ub_for234_2  ??
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
	chan child_HammerRWMutex2220 = [1] of {int};
	run HammerRWMutex222(var_numIterations,var_numReaders,child_HammerRWMutex2220);
	run receiver(child_HammerRWMutex2220)
stop_process:skip
}

proctype HammerRWMutex222(int numIterations;int numReaders;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_reader1884 = [1] of {int};
	chan child_writer2053 = [1] of {int};
	chan child_reader1881 = [1] of {int};
	chan child_writer2050 = [1] of {int};
	Chandef cdone_ch;
	Mutexdef rwm_m;
	run mutexMonitor(rwm_m);
	run sync_monitor(cdone_ch);
	run writer205(rwm_m,cdone_ch,numIterations,child_writer2050);
	run receiver(child_writer2050);
		for(i : 0.. var_numReaders / 2-1) {
		for20: skip;
		run reader188(rwm_m,cdone_ch,numIterations,child_reader1881);
		run receiver(child_reader1881);
		for20_end: skip
	};
	for20_exit: skip;
	run writer205(rwm_m,cdone_ch,numIterations,child_writer2053);
	run receiver(child_writer2053);
		for(i : 0.. ub_for234_2) {
		for30: skip;
		run reader188(rwm_m,cdone_ch,numIterations,child_reader1884);
		run receiver(child_reader1884);
		for30_end: skip
	};
	for30_exit: skip;
	

	if
	:: 0 != -2 && var_2 + numReaders-1 != -3 -> 
				for(i : 0.. var_2 + numReaders-1) {
			for41: skip;
			

			if
			:: cdone_ch.deq?state,num_msgs;
			:: cdone_ch.sync?state -> 
				cdone_ch.rcving!false
			fi;
			for41_end: skip
		};
		for41_exit: skip
	:: else -> 
		do
		:: true -> 
			for40: skip;
			

			if
			:: cdone_ch.deq?state,num_msgs;
			:: cdone_ch.sync?state -> 
				cdone_ch.rcving!false
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
proctype writer205(Mutexdef rwm_m;Chandef cdone_ch;int numIterations;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: cdone_ch.enq!0;
	:: cdone_ch.sync!false -> 
		cdone_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype reader188(Mutexdef rwm_m;Chandef cdone_ch;int numIterations;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: cdone_ch.enq!0;
	:: cdone_ch.sync!false -> 
		cdone_ch.sending!false
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

