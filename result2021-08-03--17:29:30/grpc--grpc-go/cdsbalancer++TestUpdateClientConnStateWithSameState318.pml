// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob/ebd6aba6754d073a696e5727158cd0c917ce1019/xds/internal/balancer/cdsbalancer/cdsbalancer_test.go#L318
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUpdateClientConnStateWithSameState3180 = [1] of {int};
	run TestUpdateClientConnStateWithSameState318(child_TestUpdateClientConnStateWithSameState3180);
	run receiver(child_TestUpdateClientConnStateWithSameState3180)
stop_process:skip
}

proctype TestUpdateClientConnStateWithSameState318(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close4940 = [1] of {int};
	chan child_WaitForWatchCluster1332 = [1] of {int};
	chan child_UpdateClientConnState4521 = [1] of {int};
	Mutexdef cdsB_xdsHI_mu;
	Mutexdef cdsB_updateCh_mu;
	Mutexdef xdsC_loadStore_mu;
	run mutexMonitor(xdsC_loadStore_mu);
	run mutexMonitor(cdsB_updateCh_mu);
	run mutexMonitor(cdsB_xdsHI_mu);
	run UpdateClientConnState452(cdsB_updateCh_mu,cdsB_xdsHI_mu,child_UpdateClientConnState4521);
	child_UpdateClientConnState4521?0;
	run WaitForWatchCluster133(xdsC_loadStore_mu,child_WaitForWatchCluster1332);
	child_WaitForWatchCluster1332?0;
		defer1: skip;
	run Close494(cdsB_updateCh_mu,cdsB_xdsHI_mu,child_Close4940);
	child_Close4940?0;
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
proctype WaitForWatchCluster133(Mutexdef xdsC_loadStore_mu;chan child) {
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

