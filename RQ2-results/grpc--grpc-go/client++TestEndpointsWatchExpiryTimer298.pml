
// https://github.com/grpc/grpc-go/blob/master/xds/internal/client/watchers_endpoints_test.go#L298
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEndpointsWatchExpiryTimer2980 = [1] of {int};
	run TestEndpointsWatchExpiryTimer298(child_TestEndpointsWatchExpiryTimer2980)
stop_process:skip
}

proctype TestEndpointsWatchExpiryTimer298(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close6210 = [1] of {int};
	Mutexdef gotUpdate_u_Raw_state_atomicMessageInfo_initMu;
	chan child_WatchEndpoints2871 = [1] of {int};
	Mutexdef apiClient_done_o_m;
	Mutexdef client_lrsMu;
	Mutexdef client_mu;
	Mutexdef client_updateCh_mu;
	Mutexdef client_cc_lceMu;
	Mutexdef client_cc_firstResolveEvent_o_m;
	Mutexdef client_cc_balancerWrapper_mu;
	Mutexdef client_cc_balancerWrapper_done_o_m;
	Mutexdef client_cc_balancerWrapper_scBuffer_mu;
	Mutexdef client_cc_balancerWrapper_balancerMu;
	Mutexdef client_cc_resolverWrapper_pollingMu;
	Mutexdef client_cc_resolverWrapper_done_o_m;
	Mutexdef client_cc_resolverWrapper_resolverMu;
	Mutexdef client_cc_mu;
	Mutexdef client_cc_safeConfigSelector_mu;
	Mutexdef client_cc_blockingpicker_mu;
	Mutexdef client_cc_csMgr_mu;
	Mutexdef client_done_o_m;
	run mutexMonitor(client_done_o_m);
	run mutexMonitor(client_cc_csMgr_mu);
	run mutexMonitor(client_cc_blockingpicker_mu);
	run mutexMonitor(client_cc_safeConfigSelector_mu);
	run mutexMonitor(client_cc_mu);
	run mutexMonitor(client_cc_resolverWrapper_resolverMu);
	run mutexMonitor(client_cc_resolverWrapper_done_o_m);
	run mutexMonitor(client_cc_resolverWrapper_pollingMu);
	run mutexMonitor(client_cc_balancerWrapper_balancerMu);
	run mutexMonitor(client_cc_balancerWrapper_scBuffer_mu);
	run mutexMonitor(client_cc_balancerWrapper_done_o_m);
	run mutexMonitor(client_cc_balancerWrapper_mu);
	run mutexMonitor(client_cc_firstResolveEvent_o_m);
	run mutexMonitor(client_cc_lceMu);
	run mutexMonitor(client_updateCh_mu);
	run mutexMonitor(client_mu);
	run mutexMonitor(client_lrsMu);
	run mutexMonitor(apiClient_done_o_m);
	run WatchEndpoints287(client_done_o_m,client_cc_csMgr_mu,client_cc_blockingpicker_mu,client_cc_safeConfigSelector_mu,client_cc_mu,client_cc_resolverWrapper_resolverMu,client_cc_resolverWrapper_done_o_m,client_cc_resolverWrapper_pollingMu,client_cc_balancerWrapper_balancerMu,client_cc_balancerWrapper_scBuffer_mu,client_cc_balancerWrapper_done_o_m,client_cc_balancerWrapper_mu,client_cc_firstResolveEvent_o_m,client_cc_lceMu,client_updateCh_mu,client_mu,client_lrsMu,child_WatchEndpoints2871);
	child_WatchEndpoints2871?0;
	run mutexMonitor(gotUpdate_u_Raw_state_atomicMessageInfo_initMu);
	stop_process: skip;
		run Close621(client_done_o_m,client_cc_csMgr_mu,client_cc_blockingpicker_mu,client_cc_safeConfigSelector_mu,client_cc_mu,client_cc_resolverWrapper_resolverMu,client_cc_resolverWrapper_done_o_m,client_cc_resolverWrapper_pollingMu,client_cc_balancerWrapper_balancerMu,client_cc_balancerWrapper_scBuffer_mu,client_cc_balancerWrapper_done_o_m,client_cc_balancerWrapper_mu,client_cc_firstResolveEvent_o_m,client_cc_lceMu,client_updateCh_mu,client_mu,client_lrsMu,child_Close6210);
	child_Close6210?0;
	child!0
}
proctype Close621(Mutexdef c_done_o_m;Mutexdef c_cc_csMgr_mu;Mutexdef c_cc_blockingpicker_mu;Mutexdef c_cc_safeConfigSelector_mu;Mutexdef c_cc_mu;Mutexdef c_cc_resolverWrapper_resolverMu;Mutexdef c_cc_resolverWrapper_done_o_m;Mutexdef c_cc_resolverWrapper_pollingMu;Mutexdef c_cc_balancerWrapper_balancerMu;Mutexdef c_cc_balancerWrapper_scBuffer_mu;Mutexdef c_cc_balancerWrapper_done_o_m;Mutexdef c_cc_balancerWrapper_mu;Mutexdef c_cc_firstResolveEvent_o_m;Mutexdef c_cc_lceMu;Mutexdef c_updateCh_mu;Mutexdef c_mu;Mutexdef c_lrsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close6210 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Close621(c_cc_csMgr_mu,c_cc_blockingpicker_mu,c_cc_safeConfigSelector_mu,c_cc_mu,c_cc_resolverWrapper_resolverMu,c_cc_resolverWrapper_done_o_m,c_cc_resolverWrapper_pollingMu,c_cc_balancerWrapper_balancerMu,c_cc_balancerWrapper_scBuffer_mu,c_cc_balancerWrapper_done_o_m,c_cc_balancerWrapper_mu,c_cc_firstResolveEvent_o_m,c_cc_lceMu,child_Close6210);
	child_Close6210?0;
	stop_process: skip;
	child!0
}
proctype WatchEndpoints287(Mutexdef c_done_o_m;Mutexdef c_cc_csMgr_mu;Mutexdef c_cc_blockingpicker_mu;Mutexdef c_cc_safeConfigSelector_mu;Mutexdef c_cc_mu;Mutexdef c_cc_resolverWrapper_resolverMu;Mutexdef c_cc_resolverWrapper_done_o_m;Mutexdef c_cc_resolverWrapper_pollingMu;Mutexdef c_cc_balancerWrapper_balancerMu;Mutexdef c_cc_balancerWrapper_scBuffer_mu;Mutexdef c_cc_balancerWrapper_done_o_m;Mutexdef c_cc_balancerWrapper_mu;Mutexdef c_cc_firstResolveEvent_o_m;Mutexdef c_cc_lceMu;Mutexdef c_updateCh_mu;Mutexdef c_mu;Mutexdef c_lrsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_watch1161 = [1] of {int};
	Mutexdef wi_mu;
	Mutexdef wi_c_lrsMu;
	Mutexdef wi_c_mu;
	Mutexdef wi_c_updateCh_mu;
	Mutexdef wi_c_cc_lceMu;
	Mutexdef wi_c_cc_firstResolveEvent_o_m;
	Mutexdef wi_c_cc_balancerWrapper_mu;
	Mutexdef wi_c_cc_balancerWrapper_done_o_m;
	Mutexdef wi_c_cc_balancerWrapper_scBuffer_mu;
	Mutexdef wi_c_cc_balancerWrapper_balancerMu;
	Mutexdef wi_c_cc_resolverWrapper_pollingMu;
	Mutexdef wi_c_cc_resolverWrapper_done_o_m;
	Mutexdef wi_c_cc_resolverWrapper_resolverMu;
	Mutexdef wi_c_cc_mu;
	Mutexdef wi_c_cc_safeConfigSelector_mu;
	Mutexdef wi_c_cc_blockingpicker_mu;
	Mutexdef wi_c_cc_csMgr_mu;
	Mutexdef wi_c_done_o_m;
	run mutexMonitor(wi_c_done_o_m);
	run mutexMonitor(wi_c_cc_csMgr_mu);
	run mutexMonitor(wi_c_cc_blockingpicker_mu);
	run mutexMonitor(wi_c_cc_safeConfigSelector_mu);
	run mutexMonitor(wi_c_cc_mu);
	run mutexMonitor(wi_c_cc_resolverWrapper_resolverMu);
	run mutexMonitor(wi_c_cc_resolverWrapper_done_o_m);
	run mutexMonitor(wi_c_cc_resolverWrapper_pollingMu);
	run mutexMonitor(wi_c_cc_balancerWrapper_balancerMu);
	run mutexMonitor(wi_c_cc_balancerWrapper_scBuffer_mu);
	run mutexMonitor(wi_c_cc_balancerWrapper_done_o_m);
	run mutexMonitor(wi_c_cc_balancerWrapper_mu);
	run mutexMonitor(wi_c_cc_firstResolveEvent_o_m);
	run mutexMonitor(wi_c_cc_lceMu);
	run mutexMonitor(wi_c_updateCh_mu);
	run mutexMonitor(wi_c_mu);
	run mutexMonitor(wi_c_lrsMu);
	run mutexMonitor(wi_mu);
	run watch116(c_done_o_m,c_cc_csMgr_mu,c_cc_blockingpicker_mu,c_cc_safeConfigSelector_mu,c_cc_mu,c_cc_resolverWrapper_resolverMu,c_cc_resolverWrapper_done_o_m,c_cc_resolverWrapper_pollingMu,c_cc_balancerWrapper_balancerMu,c_cc_balancerWrapper_scBuffer_mu,c_cc_balancerWrapper_done_o_m,c_cc_balancerWrapper_mu,c_cc_firstResolveEvent_o_m,c_cc_lceMu,c_updateCh_mu,c_mu,c_lrsMu,wi_c_done_o_m,wi_c_cc_csMgr_mu,wi_c_cc_blockingpicker_mu,wi_c_cc_safeConfigSelector_mu,wi_c_cc_mu,wi_c_cc_resolverWrapper_resolverMu,wi_c_cc_resolverWrapper_done_o_m,wi_c_cc_resolverWrapper_pollingMu,wi_c_cc_balancerWrapper_balancerMu,wi_c_cc_balancerWrapper_scBuffer_mu,wi_c_cc_balancerWrapper_done_o_m,wi_c_cc_balancerWrapper_mu,wi_c_cc_firstResolveEvent_o_m,wi_c_cc_lceMu,wi_c_updateCh_mu,wi_c_mu,wi_c_lrsMu,wi_mu,child_watch1161);
	child_watch1161?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype watch116(Mutexdef c_done_o_m;Mutexdef c_cc_csMgr_mu;Mutexdef c_cc_blockingpicker_mu;Mutexdef c_cc_safeConfigSelector_mu;Mutexdef c_cc_mu;Mutexdef c_cc_resolverWrapper_resolverMu;Mutexdef c_cc_resolverWrapper_done_o_m;Mutexdef c_cc_resolverWrapper_pollingMu;Mutexdef c_cc_balancerWrapper_balancerMu;Mutexdef c_cc_balancerWrapper_scBuffer_mu;Mutexdef c_cc_balancerWrapper_done_o_m;Mutexdef c_cc_balancerWrapper_mu;Mutexdef c_cc_firstResolveEvent_o_m;Mutexdef c_cc_lceMu;Mutexdef c_updateCh_mu;Mutexdef c_mu;Mutexdef c_lrsMu;Mutexdef wi_c_done_o_m;Mutexdef wi_c_cc_csMgr_mu;Mutexdef wi_c_cc_blockingpicker_mu;Mutexdef wi_c_cc_safeConfigSelector_mu;Mutexdef wi_c_cc_mu;Mutexdef wi_c_cc_resolverWrapper_resolverMu;Mutexdef wi_c_cc_resolverWrapper_done_o_m;Mutexdef wi_c_cc_resolverWrapper_pollingMu;Mutexdef wi_c_cc_balancerWrapper_balancerMu;Mutexdef wi_c_cc_balancerWrapper_scBuffer_mu;Mutexdef wi_c_cc_balancerWrapper_done_o_m;Mutexdef wi_c_cc_balancerWrapper_mu;Mutexdef wi_c_cc_firstResolveEvent_o_m;Mutexdef wi_c_cc_lceMu;Mutexdef wi_c_updateCh_mu;Mutexdef wi_c_mu;Mutexdef wi_c_lrsMu;Mutexdef wi_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newUpdate561 = [1] of {int};
	Mutexdef v_Raw_state_atomicMessageInfo_initMu;
	chan child_newUpdate562 = [1] of {int};
	chan child_newUpdate563 = [1] of {int};
	chan child_newUpdate564 = [1] of {int};
	c_mu.Lock!false;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	:: true -> 
		goto stop_process
	fi;
	

	if
	:: true -> 
		run mutexMonitor(v_Raw_state_atomicMessageInfo_initMu);
		

		if
		:: true -> 
			run newUpdate56(wi_c_done_o_m,wi_c_cc_csMgr_mu,wi_c_cc_blockingpicker_mu,wi_c_cc_safeConfigSelector_mu,wi_c_cc_mu,wi_c_cc_resolverWrapper_resolverMu,wi_c_cc_resolverWrapper_done_o_m,wi_c_cc_resolverWrapper_pollingMu,wi_c_cc_balancerWrapper_balancerMu,wi_c_cc_balancerWrapper_scBuffer_mu,wi_c_cc_balancerWrapper_done_o_m,wi_c_cc_balancerWrapper_mu,wi_c_cc_firstResolveEvent_o_m,wi_c_cc_lceMu,wi_c_updateCh_mu,wi_c_mu,wi_c_lrsMu,wi_mu,v_Raw_state_atomicMessageInfo_initMu,child_newUpdate561);
			child_newUpdate561?0
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			run newUpdate56(wi_c_done_o_m,wi_c_cc_csMgr_mu,wi_c_cc_blockingpicker_mu,wi_c_cc_safeConfigSelector_mu,wi_c_cc_mu,wi_c_cc_resolverWrapper_resolverMu,wi_c_cc_resolverWrapper_done_o_m,wi_c_cc_resolverWrapper_pollingMu,wi_c_cc_balancerWrapper_balancerMu,wi_c_cc_balancerWrapper_scBuffer_mu,wi_c_cc_balancerWrapper_done_o_m,wi_c_cc_balancerWrapper_mu,wi_c_cc_firstResolveEvent_o_m,wi_c_cc_lceMu,wi_c_updateCh_mu,wi_c_mu,wi_c_lrsMu,wi_mu,v_Raw_state_atomicMessageInfo_initMu,child_newUpdate562);
			child_newUpdate562?0
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			run newUpdate56(wi_c_done_o_m,wi_c_cc_csMgr_mu,wi_c_cc_blockingpicker_mu,wi_c_cc_safeConfigSelector_mu,wi_c_cc_mu,wi_c_cc_resolverWrapper_resolverMu,wi_c_cc_resolverWrapper_done_o_m,wi_c_cc_resolverWrapper_pollingMu,wi_c_cc_balancerWrapper_balancerMu,wi_c_cc_balancerWrapper_scBuffer_mu,wi_c_cc_balancerWrapper_done_o_m,wi_c_cc_balancerWrapper_mu,wi_c_cc_firstResolveEvent_o_m,wi_c_cc_lceMu,wi_c_updateCh_mu,wi_c_mu,wi_c_lrsMu,wi_mu,v_Raw_state_atomicMessageInfo_initMu,child_newUpdate563);
			child_newUpdate563?0
		:: true;
		fi
	:: true -> 
		

		if
		:: true -> 
			run newUpdate56(wi_c_done_o_m,wi_c_cc_csMgr_mu,wi_c_cc_blockingpicker_mu,wi_c_cc_safeConfigSelector_mu,wi_c_cc_mu,wi_c_cc_resolverWrapper_resolverMu,wi_c_cc_resolverWrapper_done_o_m,wi_c_cc_resolverWrapper_pollingMu,wi_c_cc_balancerWrapper_balancerMu,wi_c_cc_balancerWrapper_scBuffer_mu,wi_c_cc_balancerWrapper_done_o_m,wi_c_cc_balancerWrapper_mu,wi_c_cc_firstResolveEvent_o_m,wi_c_cc_lceMu,wi_c_updateCh_mu,wi_c_mu,wi_c_lrsMu,wi_mu,v_Raw_state_atomicMessageInfo_initMu,child_newUpdate564);
			child_newUpdate564?0
		:: true;
		fi
	fi;
	goto stop_process;
	stop_process: skip;
		c_mu.Unlock!false;
	child!0
}
proctype newUpdate56(Mutexdef wi_c_done_o_m;Mutexdef wi_c_cc_csMgr_mu;Mutexdef wi_c_cc_blockingpicker_mu;Mutexdef wi_c_cc_safeConfigSelector_mu;Mutexdef wi_c_cc_mu;Mutexdef wi_c_cc_resolverWrapper_resolverMu;Mutexdef wi_c_cc_resolverWrapper_done_o_m;Mutexdef wi_c_cc_resolverWrapper_pollingMu;Mutexdef wi_c_cc_balancerWrapper_balancerMu;Mutexdef wi_c_cc_balancerWrapper_scBuffer_mu;Mutexdef wi_c_cc_balancerWrapper_done_o_m;Mutexdef wi_c_cc_balancerWrapper_mu;Mutexdef wi_c_cc_firstResolveEvent_o_m;Mutexdef wi_c_cc_lceMu;Mutexdef wi_c_updateCh_mu;Mutexdef wi_c_mu;Mutexdef wi_c_lrsMu;Mutexdef wi_mu;Mutexdef update_Raw_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_scheduleCallback291 = [1] of {int};
	wi_mu.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run scheduleCallback29(wi_c_done_o_m,wi_c_cc_csMgr_mu,wi_c_cc_blockingpicker_mu,wi_c_cc_safeConfigSelector_mu,wi_c_cc_mu,wi_c_cc_resolverWrapper_resolverMu,wi_c_cc_resolverWrapper_done_o_m,wi_c_cc_resolverWrapper_pollingMu,wi_c_cc_balancerWrapper_balancerMu,wi_c_cc_balancerWrapper_scBuffer_mu,wi_c_cc_balancerWrapper_done_o_m,wi_c_cc_balancerWrapper_mu,wi_c_cc_firstResolveEvent_o_m,wi_c_cc_lceMu,wi_c_updateCh_mu,wi_c_mu,wi_c_lrsMu,wi_c_done_o_m,wi_c_cc_csMgr_mu,wi_c_cc_blockingpicker_mu,wi_c_cc_safeConfigSelector_mu,wi_c_cc_mu,wi_c_cc_resolverWrapper_resolverMu,wi_c_cc_resolverWrapper_done_o_m,wi_c_cc_resolverWrapper_pollingMu,wi_c_cc_balancerWrapper_balancerMu,wi_c_cc_balancerWrapper_scBuffer_mu,wi_c_cc_balancerWrapper_done_o_m,wi_c_cc_balancerWrapper_mu,wi_c_cc_firstResolveEvent_o_m,wi_c_cc_lceMu,wi_c_updateCh_mu,wi_c_mu,wi_c_lrsMu,wi_mu,update_Raw_state_atomicMessageInfo_initMu,child_scheduleCallback291);
	child_scheduleCallback291?0;
	stop_process: skip;
		wi_mu.Unlock!false;
	child!0
}
proctype scheduleCallback29(Mutexdef c_done_o_m;Mutexdef c_cc_csMgr_mu;Mutexdef c_cc_blockingpicker_mu;Mutexdef c_cc_safeConfigSelector_mu;Mutexdef c_cc_mu;Mutexdef c_cc_resolverWrapper_resolverMu;Mutexdef c_cc_resolverWrapper_done_o_m;Mutexdef c_cc_resolverWrapper_pollingMu;Mutexdef c_cc_balancerWrapper_balancerMu;Mutexdef c_cc_balancerWrapper_scBuffer_mu;Mutexdef c_cc_balancerWrapper_done_o_m;Mutexdef c_cc_balancerWrapper_mu;Mutexdef c_cc_firstResolveEvent_o_m;Mutexdef c_cc_lceMu;Mutexdef c_updateCh_mu;Mutexdef c_mu;Mutexdef c_lrsMu;Mutexdef wi_c_done_o_m;Mutexdef wi_c_cc_csMgr_mu;Mutexdef wi_c_cc_blockingpicker_mu;Mutexdef wi_c_cc_safeConfigSelector_mu;Mutexdef wi_c_cc_mu;Mutexdef wi_c_cc_resolverWrapper_resolverMu;Mutexdef wi_c_cc_resolverWrapper_done_o_m;Mutexdef wi_c_cc_resolverWrapper_pollingMu;Mutexdef wi_c_cc_balancerWrapper_balancerMu;Mutexdef wi_c_cc_balancerWrapper_scBuffer_mu;Mutexdef wi_c_cc_balancerWrapper_done_o_m;Mutexdef wi_c_cc_balancerWrapper_mu;Mutexdef wi_c_cc_firstResolveEvent_o_m;Mutexdef wi_c_cc_lceMu;Mutexdef wi_c_updateCh_mu;Mutexdef wi_c_mu;Mutexdef wi_c_lrsMu;Mutexdef wi_mu;Mutexdef update_Raw_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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

