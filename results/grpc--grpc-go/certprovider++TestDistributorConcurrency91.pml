// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob//credentials/tls/certprovider/distributor_test.go#L91
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDistributorConcurrency910 = [1] of {int};
	run TestDistributorConcurrency91(child_TestDistributorConcurrency910);
	run receiver(child_TestDistributorConcurrency910)
stop_process:skip
}

proctype TestDistributorConcurrency91(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_readAndVerifyKeyMaterial1481 = [1] of {int};
	chan child_AnonymousTestDistributorConcurrency102920 = [1] of {int};
	Mutexdef dist_closed_o_m;
	Mutexdef dist_ready_o_m;
	Mutexdef dist_mu;
	run mutexMonitor(dist_mu);
	run mutexMonitor(dist_ready_o_m);
	run mutexMonitor(dist_closed_o_m);
	run AnonymousTestDistributorConcurrency10292(dist_mu,dist_ready_o_m,dist_closed_o_m,child_AnonymousTestDistributorConcurrency102920);
	run receiver(child_AnonymousTestDistributorConcurrency102920);
	run readAndVerifyKeyMaterial148(dist_closed_o_m,dist_mu,dist_ready_o_m,child_readAndVerifyKeyMaterial1481);
	child_readAndVerifyKeyMaterial1481?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestDistributorConcurrency10292(Mutexdef dist_mu;Mutexdef dist_ready_o_m;Mutexdef dist_closed_o_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Set700 = [1] of {int};
	run Set70(dist_closed_o_m,dist_mu,dist_ready_o_m,child_Set700);
	child_Set700?0;
	stop_process: skip;
	child!0
}
proctype Set70(Mutexdef d_closed_o_m;Mutexdef d_mu;Mutexdef d_ready_o_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	d_mu.Lock!false;
	d_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype readAndVerifyKeyMaterial148(Mutexdef kmr_closed_o_m;Mutexdef kmr_mu;Mutexdef kmr_ready_o_m;chan child) {
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

