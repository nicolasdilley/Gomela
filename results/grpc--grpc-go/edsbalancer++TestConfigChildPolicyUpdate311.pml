// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob//xds/internal/balancer/edsbalancer/eds_test.go#L311
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfigChildPolicyUpdate3110 = [1] of {int};
	run TestConfigChildPolicyUpdate311(child_TestConfigChildPolicyUpdate3110);
	run receiver(child_TestConfigChildPolicyUpdate3110)
stop_process:skip
}

proctype TestConfigChildPolicyUpdate311(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_InvokeWatchEDSCallback1791 = [1] of {int};
	chan child_WaitForWatchEDS1670 = [1] of {int};
	Mutexdef xdsC_loadStore_mu;
	run mutexMonitor(xdsC_loadStore_mu);
	run WaitForWatchEDS167(xdsC_loadStore_mu,child_WaitForWatchEDS1670);
	child_WaitForWatchEDS1670?0;
	run InvokeWatchEDSCallback179(xdsC_loadStore_mu,child_InvokeWatchEDSCallback1791);
	child_InvokeWatchEDSCallback1791?0;
	stop_process: skip;
	child!0
}
proctype WaitForWatchEDS167(Mutexdef xdsC_loadStore_mu;chan child) {
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
proctype InvokeWatchEDSCallback179(Mutexdef xdsC_loadStore_mu;chan child) {
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

