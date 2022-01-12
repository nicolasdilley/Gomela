// num_comm_params=2
// num_mand_comm_params=1
// num_opt_comm_params=1

// git_link=https://github.com/minio/minio/blob//pkg/lsync/lrwmutex_test.go#L220
#define def_var_numIterations  -2 // opt numIterations line 220
#define def_var_numReaders  ?? // mand numReaders line 220
#define ub_for232_2  ??
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
	run HammerRWMutex220(def_var_numIterations,def_var_numReaders,child_HammerRWMutex2200);
	run receiver(child_HammerRWMutex2200)
stop_process:skip
}

proctype HammerRWMutex220(int var_numIterations;int var_numReaders;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_reader1864 = [1] of {int};
	chan child_writer2033 = [1] of {int};
	chan child_reader1861 = [1] of {int};
	chan child_writer2030 = [1] of {int};
	Chandef cdone_ch;
	Mutexdef rwm_mu;
	run mutexMonitor(rwm_mu);
	run sync_monitor(cdone_ch);
	run writer203(rwm_mu,cdone_ch,var_numIterations,child_writer2030);
	run receiver(child_writer2030);
		for(i : 0.. var_numReaders/2-1) {
		for20: skip;
		run reader186(rwm_mu,cdone_ch,var_numIterations,child_reader1861);
		run receiver(child_reader1861);
		for20_end: skip
	};
	for20_exit: skip;
	run writer203(rwm_mu,cdone_ch,var_numIterations,child_writer2033);
	run receiver(child_writer2033);
		for(i : 0.. ub_for232_2) {
		for30: skip;
		run reader186(rwm_mu,cdone_ch,var_numIterations,child_reader1864);
		run receiver(child_reader1864);
		for30_end: skip
	};
	for30_exit: skip;
	

	if
	:: 0 != -2 && 2+var_numReaders-1 != -3 -> 
				for(i : 0.. 2+var_numReaders-1) {
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
proctype writer203(Mutexdef rwm_mu;Chandef cdone_ch;int var_numIterations;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Unlock1293 = [1] of {int};
	chan child_GetLock522 = [1] of {int};
	chan child_Unlock1291 = [1] of {int};
	chan child_GetLock520 = [1] of {int};
	

	if
	:: 0 != -2 && var_numIterations-1 != -3 -> 
				for(i : 0.. var_numIterations-1) {
			for17: skip;
			run GetLock52(rwm_mu,child_GetLock522);
			child_GetLock522?0;
			

			if
			:: true -> 
				run Unlock129(rwm_mu,child_Unlock1293);
				child_Unlock1293?0
			:: true;
			fi;
			for17_end: skip
		};
		for17_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run GetLock52(rwm_mu,child_GetLock520);
			child_GetLock520?0;
			

			if
			:: true -> 
				run Unlock129(rwm_mu,child_Unlock1291);
				child_Unlock1291?0
			:: true;
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: cdone_ch.enq!0;
	:: cdone_ch.sync!false -> 
		cdone_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype GetLock52(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_lockLoop1050 = [1] of {int};
	run lockLoop105(lm_mu,child_lockLoop1050);
	child_lockLoop1050?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype lockLoop105(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_lock750 = [1] of {int};
	do
	:: true -> 
		for11: skip;
		do
		:: true -> 
			goto stop_process
		:: true -> 
			run lock75(lm_mu,child_lock750);
			child_lock750?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		od;
		for12_exit: skip;
		for12_end: skip;
		for11_end: skip
	od;
	for11_exit: skip;
	stop_process: skip;
	child!0
}
proctype lock75(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	lm_mu.Lock!false;
	goto defer1;
		defer1: skip;
	lm_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Unlock129(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_unlock1501 = [1] of {int};
	run unlock150(lm_mu,child_unlock1501);
	child_unlock1501?0;
	stop_process: skip;
	child!0
}
proctype unlock150(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	lm_mu.Lock!false;
	goto defer1;
		defer1: skip;
	lm_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype reader186(Mutexdef rwm_mu;Chandef cdone_ch;int var_numIterations;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RUnlock1414 = [1] of {int};
	chan child_GetRLock693 = [1] of {int};
	chan child_RUnlock1412 = [1] of {int};
	chan child_GetRLock691 = [1] of {int};
	

	if
	:: 0 != -2 && var_numIterations-1 != -3 -> 
				for(i : 0.. var_numIterations-1) {
			for24: skip;
			run GetRLock69(rwm_mu,child_GetRLock693);
			child_GetRLock693?0;
			

			if
			:: true -> 
				run RUnlock141(rwm_mu,child_RUnlock1414);
				child_RUnlock1414?0
			:: true;
			fi;
			for24_end: skip
		};
		for24_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			run GetRLock69(rwm_mu,child_GetRLock691);
			child_GetRLock691?0;
			

			if
			:: true -> 
				run RUnlock141(rwm_mu,child_RUnlock1412);
				child_RUnlock1412?0
			:: true;
			fi;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	

	if
	:: cdone_ch.enq!0;
	:: cdone_ch.sync!false -> 
		cdone_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype GetRLock69(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_lockLoop1051 = [1] of {int};
	run lockLoop105(lm_mu,child_lockLoop1051);
	child_lockLoop1051?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype RUnlock141(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_unlock1502 = [1] of {int};
	run unlock150(lm_mu,child_unlock1502);
	child_unlock1502?0;
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

