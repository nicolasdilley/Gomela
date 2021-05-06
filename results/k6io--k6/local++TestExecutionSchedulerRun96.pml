
// https://github.com/k6io/k6/blob/master/core/local/local_test.go#L96
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
	chan child_TestExecutionSchedulerRun960 = [1] of {int};
	run TestExecutionSchedulerRun96(child_TestExecutionSchedulerRun960)
stop_process:skip
}

proctype TestExecutionSchedulerRun96(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestExecutionSchedulerRun1021010 = [1] of {int};
	Chandef err;
	Mutexdef execScheduler_state_pauseStateLock;
	Mutexdef execScheduler_initProgress_logger_Logger_mu_lock;
	Mutexdef execScheduler_initProgress_mutex;
	Mutexdef execScheduler_logger_mu_lock;
	run mutexMonitor(execScheduler_logger_mu_lock);
	run mutexMonitor(execScheduler_initProgress_mutex);
	run mutexMonitor(execScheduler_initProgress_logger_Logger_mu_lock);
	run mutexMonitor(execScheduler_state_pauseStateLock);
	

	if
	:: 1 > 0 -> 
		err.size = 1;
		run AsyncChan(err)
	:: else -> 
		run sync_monitor(err)
	fi;
	run AnonymousTestExecutionSchedulerRun102101(err,execScheduler_logger_mu_lock,execScheduler_initProgress_mutex,execScheduler_initProgress_logger_Logger_mu_lock,execScheduler_state_pauseStateLock,child_AnonymousTestExecutionSchedulerRun1021010);
	

	if
	:: err.deq?state,num_msgs;
	:: err.sync?state -> 
		err.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestExecutionSchedulerRun102101(Chandef err;Mutexdef execScheduler_logger_mu_lock;Mutexdef execScheduler_initProgress_mutex;Mutexdef execScheduler_initProgress_logger_Logger_mu_lock;Mutexdef execScheduler_state_pauseStateLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: err.enq!0;
	:: err.sync!false -> 
		err.sending!false
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

