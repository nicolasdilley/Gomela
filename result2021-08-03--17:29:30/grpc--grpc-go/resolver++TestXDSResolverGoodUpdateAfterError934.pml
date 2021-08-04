// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob/ebd6aba6754d073a696e5727158cd0c917ce1019/xds/internal/resolver/xds_resolver_test.go#L934
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestXDSResolverGoodUpdateAfterError9340 = [1] of {int};
	run TestXDSResolverGoodUpdateAfterError934(child_TestXDSResolverGoodUpdateAfterError9340);
	run receiver(child_TestXDSResolverGoodUpdateAfterError9340)
stop_process:skip
}

proctype TestXDSResolverGoodUpdateAfterError934(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_InvokeWatchRouteConfigCallback1115 = [1] of {int};
	chan child_InvokeWatchRouteConfigCallback1114 = [1] of {int};
	chan child_InvokeWatchRouteConfigCallback1113 = [1] of {int};
	chan child_waitForWatchRouteConfig2382 = [1] of {int};
	chan child_InvokeWatchListenerCallback771 = [1] of {int};
	chan child_waitForWatchListener2230 = [1] of {int};
	Mutexdef xdsC_loadStore_mu;
	run mutexMonitor(xdsC_loadStore_mu);
	run waitForWatchListener223(xdsC_loadStore_mu,child_waitForWatchListener2230);
	child_waitForWatchListener2230?0;
	run InvokeWatchListenerCallback77(xdsC_loadStore_mu,child_InvokeWatchListenerCallback771);
	child_InvokeWatchListenerCallback771?0;
	run waitForWatchRouteConfig238(xdsC_loadStore_mu,child_waitForWatchRouteConfig2382);
	child_waitForWatchRouteConfig2382?0;
	run InvokeWatchRouteConfigCallback111(xdsC_loadStore_mu,child_InvokeWatchRouteConfigCallback1113);
	child_InvokeWatchRouteConfigCallback1113?0;
	run InvokeWatchRouteConfigCallback111(xdsC_loadStore_mu,child_InvokeWatchRouteConfigCallback1114);
	child_InvokeWatchRouteConfigCallback1114?0;
	run InvokeWatchRouteConfigCallback111(xdsC_loadStore_mu,child_InvokeWatchRouteConfigCallback1115);
	child_InvokeWatchRouteConfigCallback1115?0;
	stop_process: skip;
	child!0
}
proctype waitForWatchListener223(Mutexdef xdsC_loadStore_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WaitForWatchListener650 = [1] of {int};
	run WaitForWatchListener65(xdsC_loadStore_mu,child_WaitForWatchListener650);
	child_WaitForWatchListener650?0;
	stop_process: skip;
	child!0
}
proctype WaitForWatchListener65(Mutexdef xdsC_loadStore_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype InvokeWatchListenerCallback77(Mutexdef xdsC_loadStore_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype waitForWatchRouteConfig238(Mutexdef xdsC_loadStore_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WaitForWatchRouteConfig992 = [1] of {int};
	run WaitForWatchRouteConfig99(xdsC_loadStore_mu,child_WaitForWatchRouteConfig992);
	child_WaitForWatchRouteConfig992?0;
	stop_process: skip;
	child!0
}
proctype WaitForWatchRouteConfig99(Mutexdef xdsC_loadStore_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype InvokeWatchRouteConfigCallback111(Mutexdef xdsC_loadStore_mu;chan child) {
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

proctype receiver(chan c) {
c?0
}

