
// https://github.com/grpc/grpc-go/blob/master/xds/internal/balancer/cdsbalancer/cdsbalancer_test.go#L340
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHandleClusterUpdate3400 = [1] of {int};
	run TestHandleClusterUpdate340(child_TestHandleClusterUpdate3400)
stop_process:skip
}

proctype TestHandleClusterUpdate340(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close4940 = [1] of {int};
	Mutexdef cdsB_xdsHI_mu;
	Mutexdef cdsB_closed_o_m;
	Mutexdef cdsB_updateCh_mu;
	Mutexdef cdsB_ccw_xdsHI_mu;
	Mutexdef xdsC_loadStore_mu;
	run mutexMonitor(xdsC_loadStore_mu);
	run mutexMonitor(cdsB_ccw_xdsHI_mu);
	run mutexMonitor(cdsB_updateCh_mu);
	run mutexMonitor(cdsB_closed_o_m);
	run mutexMonitor(cdsB_xdsHI_mu);
	stop_process: skip;
		run Close494(cdsB_ccw_xdsHI_mu,cdsB_updateCh_mu,cdsB_closed_o_m,cdsB_xdsHI_mu,child_Close4940);
	child_Close4940?0;
	child!0
}
proctype Close494(Mutexdef b_ccw_xdsHI_mu;Mutexdef b_updateCh_mu;Mutexdef b_closed_o_m;Mutexdef b_xdsHI_mu;chan child) {
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

