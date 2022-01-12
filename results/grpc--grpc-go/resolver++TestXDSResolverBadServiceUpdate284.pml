// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob//xds/internal/resolver/xds_resolver_test.go#L284
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestXDSResolverBadServiceUpdate2840 = [1] of {int};
	run TestXDSResolverBadServiceUpdate284(child_TestXDSResolverBadServiceUpdate2840);
	run receiver(child_TestXDSResolverBadServiceUpdate2840)
stop_process:skip
}

proctype TestXDSResolverBadServiceUpdate284(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close2620 = [1] of {int};
	chan child_InvokeWatchRouteConfigCallback1114 = [1] of {int};
	chan child_waitForWatchRouteConfig2383 = [1] of {int};
	chan child_InvokeWatchListenerCallback772 = [1] of {int};
	chan child_waitForWatchListener2231 = [1] of {int};
	Mutexdef xdsR_closed_o_m;
	Mutexdef xdsC_loadStore_mu;
	run mutexMonitor(xdsC_loadStore_mu);
	run mutexMonitor(xdsR_closed_o_m);
	run waitForWatchListener223(xdsC_loadStore_mu,child_waitForWatchListener2231);
	child_waitForWatchListener2231?0;
	run InvokeWatchListenerCallback77(xdsC_loadStore_mu,child_InvokeWatchListenerCallback772);
	child_InvokeWatchListenerCallback772?0;
	run waitForWatchRouteConfig238(xdsC_loadStore_mu,child_waitForWatchRouteConfig2383);
	child_waitForWatchRouteConfig2383?0;
	run InvokeWatchRouteConfigCallback111(xdsC_loadStore_mu,child_InvokeWatchRouteConfigCallback1114);
	child_InvokeWatchRouteConfigCallback1114?0;
		defer1: skip;
	run Close262(xdsR_closed_o_m,child_Close2620);
	child_Close2620?0;
	stop_process: skip;
	child!0
}
proctype Close262(Mutexdef r_closed_o_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype waitForWatchListener223(Mutexdef xdsC_loadStore_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WaitForWatchListener651 = [1] of {int};
	run WaitForWatchListener65(xdsC_loadStore_mu,child_WaitForWatchListener651);
	child_WaitForWatchListener651?0;
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
	chan child_WaitForWatchRouteConfig993 = [1] of {int};
	run WaitForWatchRouteConfig99(xdsC_loadStore_mu,child_WaitForWatchRouteConfig993);
	child_WaitForWatchRouteConfig993?0;
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

