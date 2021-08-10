// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob/ebd6aba6754d073a696e5727158cd0c917ce1019/xds/internal/balancer/cdsbalancer/cdsbalancer_test.go#L618
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestClose6180 = [1] of {int};
	run TestClose618(child_TestClose6180);
	run receiver(child_TestClose6180)
stop_process:skip
}

proctype TestClose618(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ResolverError4766 = [1] of {int};
	chan child_UpdateSubConnState4855 = [1] of {int};
	chan child_UpdateClientConnState4524 = [1] of {int};
	chan child_InvokeWatchClusterCallback1453 = [1] of {int};
	chan child_WaitForCancelClusterWatch1512 = [1] of {int};
	chan child_Close4941 = [1] of {int};
	chan child_invokeWatchCbAndWait670 = [1] of {int};
	Mutexdef cdsB_xdsHI_mu;
	Mutexdef cdsB_updateCh_mu;
	Mutexdef xdsC_loadStore_mu;
	run mutexMonitor(xdsC_loadStore_mu);
	run mutexMonitor(cdsB_updateCh_mu);
	run mutexMonitor(cdsB_xdsHI_mu);
	run invokeWatchCbAndWait67(xdsC_loadStore_mu,child_invokeWatchCbAndWait670);
	child_invokeWatchCbAndWait670?0;
	run Close494(cdsB_updateCh_mu,cdsB_xdsHI_mu,child_Close4941);
	child_Close4941?0;
	run WaitForCancelClusterWatch151(xdsC_loadStore_mu,child_WaitForCancelClusterWatch1512);
	child_WaitForCancelClusterWatch1512?0;
	run InvokeWatchClusterCallback145(xdsC_loadStore_mu,child_InvokeWatchClusterCallback1453);
	child_InvokeWatchClusterCallback1453?0;
	run UpdateClientConnState452(cdsB_updateCh_mu,cdsB_xdsHI_mu,child_UpdateClientConnState4524);
	child_UpdateClientConnState4524?0;
	run UpdateSubConnState485(cdsB_updateCh_mu,cdsB_xdsHI_mu,child_UpdateSubConnState4855);
	child_UpdateSubConnState4855?0;
	run ResolverError476(cdsB_updateCh_mu,cdsB_xdsHI_mu,child_ResolverError4766);
	child_ResolverError4766?0;
	stop_process: skip;
	child!0
}
proctype invokeWatchCbAndWait67(Mutexdef xdsC_loadStore_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_InvokeWatchClusterCallback1450 = [1] of {int};
	run InvokeWatchClusterCallback145(xdsC_loadStore_mu,child_InvokeWatchClusterCallback1450);
	child_InvokeWatchClusterCallback1450?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype InvokeWatchClusterCallback145(Mutexdef xdsC_loadStore_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Close494(Mutexdef b_updateCh_mu;Mutexdef b_xdsHI_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype WaitForCancelClusterWatch151(Mutexdef xdsC_loadStore_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype UpdateClientConnState452(Mutexdef b_updateCh_mu;Mutexdef b_xdsHI_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype UpdateSubConnState485(Mutexdef b_updateCh_mu;Mutexdef b_xdsHI_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype ResolverError476(Mutexdef b_updateCh_mu;Mutexdef b_xdsHI_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

