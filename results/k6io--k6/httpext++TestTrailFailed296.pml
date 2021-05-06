#define TestTrailFailed_testCases  3

// https://github.com/k6io/k6/blob/master/lib/netext/httpext/request_test.go#L296
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
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTrailFailed2960 = [1] of {int};
	run TestTrailFailed296(child_TestTrailFailed2960)
stop_process:skip
}

proctype TestTrailFailed296(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1310 = [1] of {int};
	chan child_WithState311 = [1] of {int};
	Mutexdef state_RPSLimit_mu;
	Mutexdef state_TLSConfig_mutex;
	Mutexdef state_CookieJar_mu;
	Mutexdef state_Group_checkMutex;
	Mutexdef state_Group_groupMutex;
	Mutexdef state_Logger_mu_lock;
	Mutexdef logger_mu_lock;
	Chandef samples;
	Mutexdef srv_mu;
	Wgdef srv_wg;
	Mutexdef srv_Config_mu;
	Mutexdef srv_Config_nextProtoOnce_m;
	Mutexdef srv_Config_ErrorLog_mu;
	Mutexdef srv_Config_TLSConfig_mutex;
	Mutexdef srv_TLS_mutex;
	int testCases = TestTrailFailed_testCases;
	run mutexMonitor(srv_TLS_mutex);
	run mutexMonitor(srv_Config_TLSConfig_mutex);
	run mutexMonitor(srv_Config_ErrorLog_mu);
	run mutexMonitor(srv_Config_nextProtoOnce_m);
	run mutexMonitor(srv_Config_mu);
	run wgMonitor(srv_wg);
	run mutexMonitor(srv_mu);
	

	if
	:: 10 > 0 -> 
		samples.size = 10;
		run AsyncChan(samples)
	:: else -> 
		run sync_monitor(samples)
	fi;
	run mutexMonitor(logger_mu_lock);
	run mutexMonitor(state_Logger_mu_lock);
	run mutexMonitor(state_Group_groupMutex);
	run mutexMonitor(state_Group_checkMutex);
	run mutexMonitor(state_CookieJar_mu);
	run mutexMonitor(state_TLSConfig_mutex);
	run mutexMonitor(state_RPSLimit_mu);
	run WithState31(state_Logger_mu_lock,state_Group_groupMutex,state_Group_checkMutex,state_CookieJar_mu,state_TLSConfig_mutex,state_RPSLimit_mu,child_WithState311);
	child_WithState311?0;
	stop_process: skip;
		run Close131(srv_wg,srv_TLS_mutex,srv_Config_TLSConfig_mutex,srv_Config_ErrorLog_mu,srv_Config_nextProtoOnce_m,srv_Config_mu,srv_mu,child_Close1310);
	child_Close1310?0;
	child!0
}
proctype Close131(Wgdef r_wg;Mutexdef r_TLS_mutex;Mutexdef r_Config_TLSConfig_mutex;Mutexdef r_Config_ErrorLog_mu;Mutexdef r_Config_nextProtoOnce_m;Mutexdef r_Config_mu;Mutexdef r_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true;
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype WithState31(Mutexdef state_Logger_mu_lock;Mutexdef state_Group_groupMutex;Mutexdef state_Group_checkMutex;Mutexdef state_CookieJar_mu;Mutexdef state_TLSConfig_mutex;Mutexdef state_RPSLimit_mu;chan child) {
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

proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
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

