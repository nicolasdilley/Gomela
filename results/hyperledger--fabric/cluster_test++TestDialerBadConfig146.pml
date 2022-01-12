// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//orderer/common/cluster/util_test.go#L146
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDialerBadConfig1460 = [1] of {int};
	run TestDialerBadConfig146(child_TestDialerBadConfig1460);
	run receiver(child_TestDialerBadConfig1460)
stop_process:skip
}

proctype TestDialerBadConfig146(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Dial1460 = [1] of {int};
	Mutexdef __lceMu;
	Mutexdef __firstResolveEvent_o_m;
	Mutexdef __balancerWrapper_mu;
	Mutexdef __balancerWrapper_done_o_m;
	Mutexdef __balancerWrapper_scBuffer_mu;
	Mutexdef __balancerWrapper_balancerMu;
	Mutexdef __resolverWrapper_pollingMu;
	Mutexdef __resolverWrapper_done_o_m;
	Mutexdef __resolverWrapper_resolverMu;
	Mutexdef __mu;
	Mutexdef __blockingpicker_mu;
	Mutexdef __csMgr_mu;
	Mutexdef dialer_lock;
	run mutexMonitor(dialer_lock);
	run mutexMonitor(__csMgr_mu);
	run mutexMonitor(__blockingpicker_mu);
	run mutexMonitor(__mu);
	run mutexMonitor(__resolverWrapper_resolverMu);
	run mutexMonitor(__resolverWrapper_done_o_m);
	run mutexMonitor(__resolverWrapper_pollingMu);
	run mutexMonitor(__balancerWrapper_balancerMu);
	run mutexMonitor(__balancerWrapper_scBuffer_mu);
	run mutexMonitor(__balancerWrapper_done_o_m);
	run mutexMonitor(__balancerWrapper_mu);
	run mutexMonitor(__firstResolveEvent_o_m);
	run mutexMonitor(__lceMu);
	run Dial146(dialer_lock,child_Dial1460);
	child_Dial1460?0;
	stop_process: skip;
	child!0
}
proctype Dial146(Mutexdef dialer_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	dialer_lock.RLock!false;
	dialer_lock.RUnlock!false;
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

