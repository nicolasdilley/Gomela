
// https://github.com/hashicorp/consul/blob/master/agent/rpc/subscribe/subscribe_test.go#L375
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
	chan child_TestServer_Subscribe_IntegrationWithBackend_ForwardToDC3750 = [1] of {int};
	run TestServer_Subscribe_IntegrationWithBackend_ForwardToDC375(child_TestServer_Subscribe_IntegrationWithBackend_ForwardToDC3750)
stop_process:skip
}

proctype TestServer_Subscribe_IntegrationWithBackend_ForwardToDC375(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef chEvents;
	Mutexdef connLocal_firstResolveEvent_o_m;
	Mutexdef connLocal_balancerWrapper_mu;
	Mutexdef connLocal_balancerWrapper_done_o_m;
	Mutexdef connLocal_balancerWrapper_scBuffer_mu;
	Mutexdef connLocal_balancerWrapper_balancerMu;
	Mutexdef connLocal_resolverWrapper_pollingMu;
	Mutexdef connLocal_resolverWrapper_done_o_m;
	Mutexdef connLocal_resolverWrapper_resolverMu;
	Mutexdef connLocal_mu;
	Mutexdef connLocal_blockingpicker_connErrMu;
	Mutexdef connLocal_blockingpicker_mu;
	Mutexdef connLocal_csMgr_mu;
	Mutexdef connRemoteDC_firstResolveEvent_o_m;
	Mutexdef connRemoteDC_balancerWrapper_mu;
	Mutexdef connRemoteDC_balancerWrapper_done_o_m;
	Mutexdef connRemoteDC_balancerWrapper_scBuffer_mu;
	Mutexdef connRemoteDC_balancerWrapper_balancerMu;
	Mutexdef connRemoteDC_resolverWrapper_pollingMu;
	Mutexdef connRemoteDC_resolverWrapper_done_o_m;
	Mutexdef connRemoteDC_resolverWrapper_resolverMu;
	Mutexdef connRemoteDC_mu;
	Mutexdef connRemoteDC_blockingpicker_connErrMu;
	Mutexdef connRemoteDC_blockingpicker_mu;
	Mutexdef connRemoteDC_csMgr_mu;
	chan child_NewServer271 = [1] of {int};
	Mutexdef backendRemoteDC_forwardConn_firstResolveEvent_o_m;
	Mutexdef backendRemoteDC_forwardConn_balancerWrapper_mu;
	Mutexdef backendRemoteDC_forwardConn_balancerWrapper_done_o_m;
	Mutexdef backendRemoteDC_forwardConn_balancerWrapper_scBuffer_mu;
	Mutexdef backendRemoteDC_forwardConn_balancerWrapper_balancerMu;
	Mutexdef backendRemoteDC_forwardConn_resolverWrapper_pollingMu;
	Mutexdef backendRemoteDC_forwardConn_resolverWrapper_done_o_m;
	Mutexdef backendRemoteDC_forwardConn_resolverWrapper_resolverMu;
	Mutexdef backendRemoteDC_forwardConn_mu;
	Mutexdef backendRemoteDC_forwardConn_blockingpicker_connErrMu;
	Mutexdef backendRemoteDC_forwardConn_blockingpicker_mu;
	Mutexdef backendRemoteDC_forwardConn_csMgr_mu;
	Mutexdef backendRemoteDC_store_lockDelay_lock;
	Mutexdef backendRemoteDC_store_db_db_writer;
	chan child_NewServer270 = [1] of {int};
	Mutexdef backendLocal_forwardConn_firstResolveEvent_o_m;
	Mutexdef backendLocal_forwardConn_balancerWrapper_mu;
	Mutexdef backendLocal_forwardConn_balancerWrapper_done_o_m;
	Mutexdef backendLocal_forwardConn_balancerWrapper_scBuffer_mu;
	Mutexdef backendLocal_forwardConn_balancerWrapper_balancerMu;
	Mutexdef backendLocal_forwardConn_resolverWrapper_pollingMu;
	Mutexdef backendLocal_forwardConn_resolverWrapper_done_o_m;
	Mutexdef backendLocal_forwardConn_resolverWrapper_resolverMu;
	Mutexdef backendLocal_forwardConn_mu;
	Mutexdef backendLocal_forwardConn_blockingpicker_connErrMu;
	Mutexdef backendLocal_forwardConn_blockingpicker_mu;
	Mutexdef backendLocal_forwardConn_csMgr_mu;
	Mutexdef backendLocal_store_lockDelay_lock;
	Mutexdef backendLocal_store_db_db_writer;
	run mutexMonitor(backendLocal_store_db_db_writer);
	run mutexMonitor(backendLocal_store_lockDelay_lock);
	run mutexMonitor(backendLocal_forwardConn_csMgr_mu);
	run mutexMonitor(backendLocal_forwardConn_blockingpicker_mu);
	run mutexMonitor(backendLocal_forwardConn_blockingpicker_connErrMu);
	run mutexMonitor(backendLocal_forwardConn_mu);
	run mutexMonitor(backendLocal_forwardConn_resolverWrapper_resolverMu);
	run mutexMonitor(backendLocal_forwardConn_resolverWrapper_done_o_m);
	run mutexMonitor(backendLocal_forwardConn_resolverWrapper_pollingMu);
	run mutexMonitor(backendLocal_forwardConn_balancerWrapper_balancerMu);
	run mutexMonitor(backendLocal_forwardConn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(backendLocal_forwardConn_balancerWrapper_done_o_m);
	run mutexMonitor(backendLocal_forwardConn_balancerWrapper_mu);
	run mutexMonitor(backendLocal_forwardConn_firstResolveEvent_o_m);
	run NewServer27(backendLocal_store_db_db_writer,backendLocal_store_lockDelay_lock,backendLocal_forwardConn_csMgr_mu,backendLocal_forwardConn_blockingpicker_mu,backendLocal_forwardConn_blockingpicker_connErrMu,backendLocal_forwardConn_mu,backendLocal_forwardConn_resolverWrapper_resolverMu,backendLocal_forwardConn_resolverWrapper_done_o_m,backendLocal_forwardConn_resolverWrapper_pollingMu,backendLocal_forwardConn_balancerWrapper_balancerMu,backendLocal_forwardConn_balancerWrapper_scBuffer_mu,backendLocal_forwardConn_balancerWrapper_done_o_m,backendLocal_forwardConn_balancerWrapper_mu,backendLocal_forwardConn_firstResolveEvent_o_m,child_NewServer270);
	child_NewServer270?0;
	run mutexMonitor(backendRemoteDC_store_db_db_writer);
	run mutexMonitor(backendRemoteDC_store_lockDelay_lock);
	run mutexMonitor(backendRemoteDC_forwardConn_csMgr_mu);
	run mutexMonitor(backendRemoteDC_forwardConn_blockingpicker_mu);
	run mutexMonitor(backendRemoteDC_forwardConn_blockingpicker_connErrMu);
	run mutexMonitor(backendRemoteDC_forwardConn_mu);
	run mutexMonitor(backendRemoteDC_forwardConn_resolverWrapper_resolverMu);
	run mutexMonitor(backendRemoteDC_forwardConn_resolverWrapper_done_o_m);
	run mutexMonitor(backendRemoteDC_forwardConn_resolverWrapper_pollingMu);
	run mutexMonitor(backendRemoteDC_forwardConn_balancerWrapper_balancerMu);
	run mutexMonitor(backendRemoteDC_forwardConn_balancerWrapper_scBuffer_mu);
	run mutexMonitor(backendRemoteDC_forwardConn_balancerWrapper_done_o_m);
	run mutexMonitor(backendRemoteDC_forwardConn_balancerWrapper_mu);
	run mutexMonitor(backendRemoteDC_forwardConn_firstResolveEvent_o_m);
	run NewServer27(backendRemoteDC_store_db_db_writer,backendRemoteDC_store_lockDelay_lock,backendRemoteDC_forwardConn_csMgr_mu,backendRemoteDC_forwardConn_blockingpicker_mu,backendRemoteDC_forwardConn_blockingpicker_connErrMu,backendRemoteDC_forwardConn_mu,backendRemoteDC_forwardConn_resolverWrapper_resolverMu,backendRemoteDC_forwardConn_resolverWrapper_done_o_m,backendRemoteDC_forwardConn_resolverWrapper_pollingMu,backendRemoteDC_forwardConn_balancerWrapper_balancerMu,backendRemoteDC_forwardConn_balancerWrapper_scBuffer_mu,backendRemoteDC_forwardConn_balancerWrapper_done_o_m,backendRemoteDC_forwardConn_balancerWrapper_mu,backendRemoteDC_forwardConn_firstResolveEvent_o_m,child_NewServer271);
	child_NewServer271?0;
	run mutexMonitor(connRemoteDC_csMgr_mu);
	run mutexMonitor(connRemoteDC_blockingpicker_mu);
	run mutexMonitor(connRemoteDC_blockingpicker_connErrMu);
	run mutexMonitor(connRemoteDC_mu);
	run mutexMonitor(connRemoteDC_resolverWrapper_resolverMu);
	run mutexMonitor(connRemoteDC_resolverWrapper_done_o_m);
	run mutexMonitor(connRemoteDC_resolverWrapper_pollingMu);
	run mutexMonitor(connRemoteDC_balancerWrapper_balancerMu);
	run mutexMonitor(connRemoteDC_balancerWrapper_scBuffer_mu);
	run mutexMonitor(connRemoteDC_balancerWrapper_done_o_m);
	run mutexMonitor(connRemoteDC_balancerWrapper_mu);
	run mutexMonitor(connRemoteDC_firstResolveEvent_o_m);
	run mutexMonitor(connLocal_csMgr_mu);
	run mutexMonitor(connLocal_blockingpicker_mu);
	run mutexMonitor(connLocal_blockingpicker_connErrMu);
	run mutexMonitor(connLocal_mu);
	run mutexMonitor(connLocal_resolverWrapper_resolverMu);
	run mutexMonitor(connLocal_resolverWrapper_done_o_m);
	run mutexMonitor(connLocal_resolverWrapper_pollingMu);
	run mutexMonitor(connLocal_balancerWrapper_balancerMu);
	run mutexMonitor(connLocal_balancerWrapper_scBuffer_mu);
	run mutexMonitor(connLocal_balancerWrapper_done_o_m);
	run mutexMonitor(connLocal_balancerWrapper_mu);
	run mutexMonitor(connLocal_firstResolveEvent_o_m);
	

	if
	:: 0 > 0 -> 
		chEvents.size = 0;
		run AsyncChan(chEvents)
	:: else -> 
		run sync_monitor(chEvents)
	fi;
	stop_process: skip;
	child!0
}
proctype NewServer27(Mutexdef backend_store_db_db_writer;Mutexdef backend_store_lockDelay_lock;Mutexdef backend_forwardConn_csMgr_mu;Mutexdef backend_forwardConn_blockingpicker_mu;Mutexdef backend_forwardConn_blockingpicker_connErrMu;Mutexdef backend_forwardConn_mu;Mutexdef backend_forwardConn_resolverWrapper_resolverMu;Mutexdef backend_forwardConn_resolverWrapper_done_o_m;Mutexdef backend_forwardConn_resolverWrapper_pollingMu;Mutexdef backend_forwardConn_balancerWrapper_balancerMu;Mutexdef backend_forwardConn_balancerWrapper_scBuffer_mu;Mutexdef backend_forwardConn_balancerWrapper_done_o_m;Mutexdef backend_forwardConn_balancerWrapper_mu;Mutexdef backend_forwardConn_firstResolveEvent_o_m;chan child) {
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

