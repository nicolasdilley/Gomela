
// https://github.com/labstack/echo/blob/master/middleware/proxy_test.go#L249
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
	chan child_TestProxyRewriteRegex2490 = [1] of {int};
	run TestProxyRewriteRegex249(child_TestProxyRewriteRegex2490)
stop_process:skip
}

proctype TestProxyRewriteRegex249(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1010 = [1] of {int};
	Mutexdef e_AutoTLSManager_challengeMu;
	Mutexdef e_AutoTLSManager_renewalMu;
	Mutexdef e_AutoTLSManager_stateMu;
	Mutexdef e_AutoTLSManager_client_noncesMu;
	Mutexdef e_AutoTLSManager_client_cacheMu;
	Mutexdef e_AutoTLSManager_clientMu;
	Mutexdef e_AutoTLSManager_Client_noncesMu;
	Mutexdef e_AutoTLSManager_Client_cacheMu;
	Mutexdef e_TLSServer_mu;
	Mutexdef e_TLSServer_nextProtoOnce_m;
	Mutexdef e_TLSServer_ErrorLog_mu;
	Mutexdef e_TLSServer_TLSConfig_mutex;
	Mutexdef e_Server_mu;
	Mutexdef e_Server_nextProtoOnce_m;
	Mutexdef e_Server_ErrorLog_mu;
	Mutexdef e_Server_TLSConfig_mutex;
	Mutexdef e_StdLogger_mu;
	Mutexdef e_startupMutex;
	Mutexdef upstream_mu;
	Wgdef upstream_wg;
	Mutexdef upstream_Config_mu;
	Mutexdef upstream_Config_nextProtoOnce_m;
	Mutexdef upstream_Config_ErrorLog_mu;
	Mutexdef upstream_Config_TLSConfig_mutex;
	Mutexdef upstream_TLS_mutex;
	Chandef receivedRequestURI;
	

	if
	:: 1 > 0 -> 
		receivedRequestURI.size = 1;
		run AsyncChan(receivedRequestURI)
	:: else -> 
		run sync_monitor(receivedRequestURI)
	fi;
	run mutexMonitor(upstream_TLS_mutex);
	run mutexMonitor(upstream_Config_TLSConfig_mutex);
	run mutexMonitor(upstream_Config_ErrorLog_mu);
	run mutexMonitor(upstream_Config_nextProtoOnce_m);
	run mutexMonitor(upstream_Config_mu);
	run wgMonitor(upstream_wg);
	run mutexMonitor(upstream_mu);
	run mutexMonitor(e_startupMutex);
	run mutexMonitor(e_StdLogger_mu);
	run mutexMonitor(e_Server_TLSConfig_mutex);
	run mutexMonitor(e_Server_ErrorLog_mu);
	run mutexMonitor(e_Server_nextProtoOnce_m);
	run mutexMonitor(e_Server_mu);
	run mutexMonitor(e_TLSServer_TLSConfig_mutex);
	run mutexMonitor(e_TLSServer_ErrorLog_mu);
	run mutexMonitor(e_TLSServer_nextProtoOnce_m);
	run mutexMonitor(e_TLSServer_mu);
	run mutexMonitor(e_AutoTLSManager_Client_cacheMu);
	run mutexMonitor(e_AutoTLSManager_Client_noncesMu);
	run mutexMonitor(e_AutoTLSManager_clientMu);
	run mutexMonitor(e_AutoTLSManager_client_cacheMu);
	run mutexMonitor(e_AutoTLSManager_client_noncesMu);
	run mutexMonitor(e_AutoTLSManager_stateMu);
	run mutexMonitor(e_AutoTLSManager_renewalMu);
	run mutexMonitor(e_AutoTLSManager_challengeMu);
	stop_process: skip;
		run Close101(upstream_wg,upstream_TLS_mutex,upstream_Config_TLSConfig_mutex,upstream_Config_ErrorLog_mu,upstream_Config_nextProtoOnce_m,upstream_Config_mu,upstream_mu,child_Close1010);
	child_Close1010?0;
	child!0
}
proctype Close101(Wgdef r_wg;Mutexdef r_TLS_mutex;Mutexdef r_Config_TLSConfig_mutex;Mutexdef r_Config_ErrorLog_mu;Mutexdef r_Config_nextProtoOnce_m;Mutexdef r_Config_mu;Mutexdef r_mu;chan child) {
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

