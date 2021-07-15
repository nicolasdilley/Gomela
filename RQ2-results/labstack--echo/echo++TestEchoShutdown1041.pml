
// https://github.com/labstack/echo/blob/master/echo_test.go#L1041
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
	chan child_TestEchoShutdown10410 = [1] of {int};
	run TestEchoShutdown1041(child_TestEchoShutdown10410)
stop_process:skip
}

proctype TestEchoShutdown1041(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Shutdown8533 = [1] of {int};
	chan child_Close8422 = [1] of {int};
	chan child_waitForServerStart6011 = [1] of {int};
	chan child_AnonymousTestEchoShutdown104510430 = [1] of {int};
	Chandef errCh;
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
	run sync_monitor(errCh);
	run AnonymousTestEchoShutdown10451043(errCh,e_startupMutex,e_StdLogger_mu,e_Server_TLSConfig_mutex,e_Server_ErrorLog_mu,e_Server_nextProtoOnce_m,e_Server_mu,e_TLSServer_TLSConfig_mutex,e_TLSServer_ErrorLog_mu,e_TLSServer_nextProtoOnce_m,e_TLSServer_mu,e_AutoTLSManager_Client_cacheMu,e_AutoTLSManager_Client_noncesMu,e_AutoTLSManager_clientMu,e_AutoTLSManager_client_cacheMu,e_AutoTLSManager_client_noncesMu,e_AutoTLSManager_stateMu,e_AutoTLSManager_renewalMu,e_AutoTLSManager_challengeMu,child_AnonymousTestEchoShutdown104510430);
	run waitForServerStart601(e_startupMutex,e_StdLogger_mu,e_Server_TLSConfig_mutex,e_Server_ErrorLog_mu,e_Server_nextProtoOnce_m,e_Server_mu,e_TLSServer_TLSConfig_mutex,e_TLSServer_ErrorLog_mu,e_TLSServer_nextProtoOnce_m,e_TLSServer_mu,e_AutoTLSManager_Client_cacheMu,e_AutoTLSManager_Client_noncesMu,e_AutoTLSManager_clientMu,e_AutoTLSManager_client_cacheMu,e_AutoTLSManager_client_noncesMu,e_AutoTLSManager_stateMu,e_AutoTLSManager_renewalMu,e_AutoTLSManager_challengeMu,errCh,child_waitForServerStart6011);
	child_waitForServerStart6011?0;
	run Close842(e_startupMutex,e_StdLogger_mu,e_Server_TLSConfig_mutex,e_Server_ErrorLog_mu,e_Server_nextProtoOnce_m,e_Server_mu,e_TLSServer_TLSConfig_mutex,e_TLSServer_ErrorLog_mu,e_TLSServer_nextProtoOnce_m,e_TLSServer_mu,e_AutoTLSManager_Client_cacheMu,e_AutoTLSManager_Client_noncesMu,e_AutoTLSManager_clientMu,e_AutoTLSManager_client_cacheMu,e_AutoTLSManager_client_noncesMu,e_AutoTLSManager_stateMu,e_AutoTLSManager_renewalMu,e_AutoTLSManager_challengeMu,child_Close8422);
	child_Close8422?0;
	run Shutdown853(e_startupMutex,e_StdLogger_mu,e_Server_TLSConfig_mutex,e_Server_ErrorLog_mu,e_Server_nextProtoOnce_m,e_Server_mu,e_TLSServer_TLSConfig_mutex,e_TLSServer_ErrorLog_mu,e_TLSServer_nextProtoOnce_m,e_TLSServer_mu,e_AutoTLSManager_Client_cacheMu,e_AutoTLSManager_Client_noncesMu,e_AutoTLSManager_clientMu,e_AutoTLSManager_client_cacheMu,e_AutoTLSManager_client_noncesMu,e_AutoTLSManager_stateMu,e_AutoTLSManager_renewalMu,e_AutoTLSManager_challengeMu,child_Shutdown8533);
	child_Shutdown8533?0;
	

	if
	:: errCh.deq?state,num_msgs;
	:: errCh.sync?state -> 
		errCh.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestEchoShutdown10451043(Chandef errCh;Mutexdef e_startupMutex;Mutexdef e_StdLogger_mu;Mutexdef e_Server_TLSConfig_mutex;Mutexdef e_Server_ErrorLog_mu;Mutexdef e_Server_nextProtoOnce_m;Mutexdef e_Server_mu;Mutexdef e_TLSServer_TLSConfig_mutex;Mutexdef e_TLSServer_ErrorLog_mu;Mutexdef e_TLSServer_nextProtoOnce_m;Mutexdef e_TLSServer_mu;Mutexdef e_AutoTLSManager_Client_cacheMu;Mutexdef e_AutoTLSManager_Client_noncesMu;Mutexdef e_AutoTLSManager_clientMu;Mutexdef e_AutoTLSManager_client_cacheMu;Mutexdef e_AutoTLSManager_client_noncesMu;Mutexdef e_AutoTLSManager_stateMu;Mutexdef e_AutoTLSManager_renewalMu;Mutexdef e_AutoTLSManager_challengeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Start6550 = [1] of {int};
	run Start655(e_startupMutex,e_StdLogger_mu,e_Server_TLSConfig_mutex,e_Server_ErrorLog_mu,e_Server_nextProtoOnce_m,e_Server_mu,e_TLSServer_TLSConfig_mutex,e_TLSServer_ErrorLog_mu,e_TLSServer_nextProtoOnce_m,e_TLSServer_mu,e_AutoTLSManager_Client_cacheMu,e_AutoTLSManager_Client_noncesMu,e_AutoTLSManager_clientMu,e_AutoTLSManager_client_cacheMu,e_AutoTLSManager_client_noncesMu,e_AutoTLSManager_stateMu,e_AutoTLSManager_renewalMu,e_AutoTLSManager_challengeMu,child_Start6550);
	child_Start6550?0;
	

	if
	:: errCh.enq!0;
	:: errCh.sync!false -> 
		errCh.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype Start655(Mutexdef e_startupMutex;Mutexdef e_StdLogger_mu;Mutexdef e_Server_TLSConfig_mutex;Mutexdef e_Server_ErrorLog_mu;Mutexdef e_Server_nextProtoOnce_m;Mutexdef e_Server_mu;Mutexdef e_TLSServer_TLSConfig_mutex;Mutexdef e_TLSServer_ErrorLog_mu;Mutexdef e_TLSServer_nextProtoOnce_m;Mutexdef e_TLSServer_mu;Mutexdef e_AutoTLSManager_Client_cacheMu;Mutexdef e_AutoTLSManager_Client_noncesMu;Mutexdef e_AutoTLSManager_clientMu;Mutexdef e_AutoTLSManager_client_cacheMu;Mutexdef e_AutoTLSManager_client_noncesMu;Mutexdef e_AutoTLSManager_stateMu;Mutexdef e_AutoTLSManager_renewalMu;Mutexdef e_AutoTLSManager_challengeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_configureServer7510 = [1] of {int};
	e_startupMutex.Lock!false;
	run configureServer751(e_startupMutex,e_StdLogger_mu,e_Server_TLSConfig_mutex,e_Server_ErrorLog_mu,e_Server_nextProtoOnce_m,e_Server_mu,e_TLSServer_TLSConfig_mutex,e_TLSServer_ErrorLog_mu,e_TLSServer_nextProtoOnce_m,e_TLSServer_mu,e_AutoTLSManager_Client_cacheMu,e_AutoTLSManager_Client_noncesMu,e_AutoTLSManager_clientMu,e_AutoTLSManager_client_cacheMu,e_AutoTLSManager_client_noncesMu,e_AutoTLSManager_stateMu,e_AutoTLSManager_renewalMu,e_AutoTLSManager_challengeMu,e_Server_TLSConfig_mutex,e_Server_ErrorLog_mu,e_Server_nextProtoOnce_m,e_Server_mu,child_configureServer7510);
	child_configureServer7510?0;
	

	if
	:: true -> 
		e_startupMutex.Unlock!false;
		goto stop_process
	:: true;
	fi;
	e_startupMutex.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype configureServer751(Mutexdef e_startupMutex;Mutexdef e_StdLogger_mu;Mutexdef e_Server_TLSConfig_mutex;Mutexdef e_Server_ErrorLog_mu;Mutexdef e_Server_nextProtoOnce_m;Mutexdef e_Server_mu;Mutexdef e_TLSServer_TLSConfig_mutex;Mutexdef e_TLSServer_ErrorLog_mu;Mutexdef e_TLSServer_nextProtoOnce_m;Mutexdef e_TLSServer_mu;Mutexdef e_AutoTLSManager_Client_cacheMu;Mutexdef e_AutoTLSManager_Client_noncesMu;Mutexdef e_AutoTLSManager_clientMu;Mutexdef e_AutoTLSManager_client_cacheMu;Mutexdef e_AutoTLSManager_client_noncesMu;Mutexdef e_AutoTLSManager_stateMu;Mutexdef e_AutoTLSManager_renewalMu;Mutexdef e_AutoTLSManager_challengeMu;Mutexdef s_TLSConfig_mutex;Mutexdef s_ErrorLog_mu;Mutexdef s_nextProtoOnce_m;Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype waitForServerStart601(Mutexdef e_startupMutex;Mutexdef e_StdLogger_mu;Mutexdef e_Server_TLSConfig_mutex;Mutexdef e_Server_ErrorLog_mu;Mutexdef e_Server_nextProtoOnce_m;Mutexdef e_Server_mu;Mutexdef e_TLSServer_TLSConfig_mutex;Mutexdef e_TLSServer_ErrorLog_mu;Mutexdef e_TLSServer_nextProtoOnce_m;Mutexdef e_TLSServer_mu;Mutexdef e_AutoTLSManager_Client_cacheMu;Mutexdef e_AutoTLSManager_Client_noncesMu;Mutexdef e_AutoTLSManager_clientMu;Mutexdef e_AutoTLSManager_client_cacheMu;Mutexdef e_AutoTLSManager_client_noncesMu;Mutexdef e_AutoTLSManager_stateMu;Mutexdef e_AutoTLSManager_renewalMu;Mutexdef e_AutoTLSManager_challengeMu;Chandef errChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TLSListenerAddr8001 = [1] of {int};
	chan child_ListenerAddr7902 = [1] of {int};
	do
	:: true -> 
		for10: skip;
		do
		:: true -> 
			goto stop_process
		:: true -> 
			

			if
			:: true -> 
				run TLSListenerAddr800(e_startupMutex,e_StdLogger_mu,e_Server_TLSConfig_mutex,e_Server_ErrorLog_mu,e_Server_nextProtoOnce_m,e_Server_mu,e_TLSServer_TLSConfig_mutex,e_TLSServer_ErrorLog_mu,e_TLSServer_nextProtoOnce_m,e_TLSServer_mu,e_AutoTLSManager_Client_cacheMu,e_AutoTLSManager_Client_noncesMu,e_AutoTLSManager_clientMu,e_AutoTLSManager_client_cacheMu,e_AutoTLSManager_client_noncesMu,e_AutoTLSManager_stateMu,e_AutoTLSManager_renewalMu,e_AutoTLSManager_challengeMu,child_TLSListenerAddr8001);
				child_TLSListenerAddr8001?0
			:: true -> 
				run ListenerAddr790(e_startupMutex,e_StdLogger_mu,e_Server_TLSConfig_mutex,e_Server_ErrorLog_mu,e_Server_nextProtoOnce_m,e_Server_mu,e_TLSServer_TLSConfig_mutex,e_TLSServer_ErrorLog_mu,e_TLSServer_nextProtoOnce_m,e_TLSServer_mu,e_AutoTLSManager_Client_cacheMu,e_AutoTLSManager_Client_noncesMu,e_AutoTLSManager_clientMu,e_AutoTLSManager_client_cacheMu,e_AutoTLSManager_client_noncesMu,e_AutoTLSManager_stateMu,e_AutoTLSManager_renewalMu,e_AutoTLSManager_challengeMu,child_ListenerAddr7902);
				child_ListenerAddr7902?0
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: errChan.deq?state,num_msgs -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto stop_process
		:: errChan.sync?state -> 
			errChan.rcving!false;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto stop_process
		od;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype TLSListenerAddr800(Mutexdef e_startupMutex;Mutexdef e_StdLogger_mu;Mutexdef e_Server_TLSConfig_mutex;Mutexdef e_Server_ErrorLog_mu;Mutexdef e_Server_nextProtoOnce_m;Mutexdef e_Server_mu;Mutexdef e_TLSServer_TLSConfig_mutex;Mutexdef e_TLSServer_ErrorLog_mu;Mutexdef e_TLSServer_nextProtoOnce_m;Mutexdef e_TLSServer_mu;Mutexdef e_AutoTLSManager_Client_cacheMu;Mutexdef e_AutoTLSManager_Client_noncesMu;Mutexdef e_AutoTLSManager_clientMu;Mutexdef e_AutoTLSManager_client_cacheMu;Mutexdef e_AutoTLSManager_client_noncesMu;Mutexdef e_AutoTLSManager_stateMu;Mutexdef e_AutoTLSManager_renewalMu;Mutexdef e_AutoTLSManager_challengeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	e_startupMutex.RLock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		e_startupMutex.RUnlock!false;
	child!0
}
proctype ListenerAddr790(Mutexdef e_startupMutex;Mutexdef e_StdLogger_mu;Mutexdef e_Server_TLSConfig_mutex;Mutexdef e_Server_ErrorLog_mu;Mutexdef e_Server_nextProtoOnce_m;Mutexdef e_Server_mu;Mutexdef e_TLSServer_TLSConfig_mutex;Mutexdef e_TLSServer_ErrorLog_mu;Mutexdef e_TLSServer_nextProtoOnce_m;Mutexdef e_TLSServer_mu;Mutexdef e_AutoTLSManager_Client_cacheMu;Mutexdef e_AutoTLSManager_Client_noncesMu;Mutexdef e_AutoTLSManager_clientMu;Mutexdef e_AutoTLSManager_client_cacheMu;Mutexdef e_AutoTLSManager_client_noncesMu;Mutexdef e_AutoTLSManager_stateMu;Mutexdef e_AutoTLSManager_renewalMu;Mutexdef e_AutoTLSManager_challengeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	e_startupMutex.RLock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		e_startupMutex.RUnlock!false;
	child!0
}
proctype Close842(Mutexdef e_startupMutex;Mutexdef e_StdLogger_mu;Mutexdef e_Server_TLSConfig_mutex;Mutexdef e_Server_ErrorLog_mu;Mutexdef e_Server_nextProtoOnce_m;Mutexdef e_Server_mu;Mutexdef e_TLSServer_TLSConfig_mutex;Mutexdef e_TLSServer_ErrorLog_mu;Mutexdef e_TLSServer_nextProtoOnce_m;Mutexdef e_TLSServer_mu;Mutexdef e_AutoTLSManager_Client_cacheMu;Mutexdef e_AutoTLSManager_Client_noncesMu;Mutexdef e_AutoTLSManager_clientMu;Mutexdef e_AutoTLSManager_client_cacheMu;Mutexdef e_AutoTLSManager_client_noncesMu;Mutexdef e_AutoTLSManager_stateMu;Mutexdef e_AutoTLSManager_renewalMu;Mutexdef e_AutoTLSManager_challengeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close8423 = [1] of {int};
	chan child_Close8422 = [1] of {int};
	e_startupMutex.Lock!false;
	run Close842(e_TLSServer_TLSConfig_mutex,e_TLSServer_ErrorLog_mu,e_TLSServer_nextProtoOnce_m,e_TLSServer_mu,child_Close8422);
	child_Close8422?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Close842(e_Server_TLSConfig_mutex,e_Server_ErrorLog_mu,e_Server_nextProtoOnce_m,e_Server_mu,child_Close8423);
	child_Close8423?0;
	goto stop_process;
	stop_process: skip;
		e_startupMutex.Unlock!false;
	child!0
}
proctype Shutdown853(Mutexdef e_startupMutex;Mutexdef e_StdLogger_mu;Mutexdef e_Server_TLSConfig_mutex;Mutexdef e_Server_ErrorLog_mu;Mutexdef e_Server_nextProtoOnce_m;Mutexdef e_Server_mu;Mutexdef e_TLSServer_TLSConfig_mutex;Mutexdef e_TLSServer_ErrorLog_mu;Mutexdef e_TLSServer_nextProtoOnce_m;Mutexdef e_TLSServer_mu;Mutexdef e_AutoTLSManager_Client_cacheMu;Mutexdef e_AutoTLSManager_Client_noncesMu;Mutexdef e_AutoTLSManager_clientMu;Mutexdef e_AutoTLSManager_client_cacheMu;Mutexdef e_AutoTLSManager_client_noncesMu;Mutexdef e_AutoTLSManager_stateMu;Mutexdef e_AutoTLSManager_renewalMu;Mutexdef e_AutoTLSManager_challengeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Shutdown8534 = [1] of {int};
	chan child_Shutdown8533 = [1] of {int};
	e_startupMutex.Lock!false;
	run Shutdown853(e_TLSServer_TLSConfig_mutex,e_TLSServer_ErrorLog_mu,e_TLSServer_nextProtoOnce_m,e_TLSServer_mu,child_Shutdown8533);
	child_Shutdown8533?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Shutdown853(e_Server_TLSConfig_mutex,e_Server_ErrorLog_mu,e_Server_nextProtoOnce_m,e_Server_mu,child_Shutdown8534);
	child_Shutdown8534?0;
	goto stop_process;
	stop_process: skip;
		e_startupMutex.Unlock!false;
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

