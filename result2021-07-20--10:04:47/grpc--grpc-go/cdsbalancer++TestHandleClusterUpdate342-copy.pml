// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob/ebd6aba6754d073a696e5727158cd0c917ce1019/xds/internal/balancer/cdsbalancer/cdsbalancer_test.go#L342
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHandleClusterUpdate3420 = [1] of {int};
	run TestHandleClusterUpdate342(child_TestHandleClusterUpdate3420);
	run receiver(child_TestHandleClusterUpdate3420)
stop_process:skip
}

proctype TestHandleClusterUpdate342(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close4950 = [1] of {int};
	Mutexdef cdsB_xdsHI_mu;
	Mutexdef cdsB_updateCh_mu;
	Mutexdef xdsC_loadStore_mu;
	int var_teststests = -2; // opt var_teststests
	run mutexMonitor(xdsC_loadStore_mu);
	run mutexMonitor(cdsB_updateCh_mu);
	run mutexMonitor(cdsB_xdsHI_mu);
		defer1: skip;
	run Close495(cdsB_updateCh_mu,cdsB_xdsHI_mu,child_Close4950);
	child_Close4950?0;
	stop_process: skip;
	child!0
}
proctype Close495(Mutexdef b_updateCh_mu;Mutexdef b_xdsHI_mu;chan child) {
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

