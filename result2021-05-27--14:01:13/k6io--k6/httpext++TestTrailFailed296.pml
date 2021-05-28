// num_comm_params=2
// num_mand_comm_params=1
// num_opt_comm_params=1

// git_link=https://github.com/k6io/k6/blob/af1e032ebf949cde092d4a2eddb78528ea0a5864/lib/netext/httpext/request_test.go#L296
#define TestTrailFailed_testCases  ??
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
	run TestTrailFailed296(child_TestTrailFailed2960);
	run receiver(child_TestTrailFailed2960)
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
	Mutexdef logger_mu_lock;
	Chandef samples;
	Mutexdef srv_mu;
	Wgdef srv_wg;
	Mutexdef srv_Config_mu;
	Mutexdef srv_TLS_mutex;
	int sample_GetSamples__ = -2; // opt sample_GetSamples__
	int testCases = TestTrailFailed_testCases; // mand testCases
	run mutexMonitor(srv_TLS_mutex);
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
	run mutexMonitor(state_Group_groupMutex);
	run mutexMonitor(state_Group_checkMutex);
	run mutexMonitor(state_CookieJar_mu);
	run mutexMonitor(state_TLSConfig_mutex);
	run mutexMonitor(state_RPSLimit_mu);
	run WithState31(state_CookieJar_mu,state_Group_checkMutex,state_Group_groupMutex,state_RPSLimit_mu,state_TLSConfig_mutex,child_WithState311);
	child_WithState311?0;
		defer1: skip;
		defer1: skip;
	run Close131(srv_wg,srv_Config_mu,srv_mu,srv_TLS_mutex,child_Close1310);
	child_Close1310?0;
	stop_process: skip;
	child!0
}
proctype Close131(Wgdef r_wg;Mutexdef r_Config_mu;Mutexdef r_mu;Mutexdef r_TLS_mutex;chan child) {
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
proctype WithState31(Mutexdef state_CookieJar_mu;Mutexdef state_Group_checkMutex;Mutexdef state_Group_groupMutex;Mutexdef state_RPSLimit_mu;Mutexdef state_TLSConfig_mutex;chan child) {
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

proctype receiver(chan c) {
c?0
}

