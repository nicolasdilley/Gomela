
// https://github.com/hashicorp/terraform/blob/master/backend/remote-state/s3/backend_test.go#L430
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBackendSSECustomerKey4300 = [1] of {int};
	run TestBackendSSECustomerKey430(child_TestBackendSSECustomerKey4300)
stop_process:skip
}

proctype TestBackendSSECustomerKey430(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TestBackendStates740 = [1] of {int};
	Mutexdef b_dynClient_endpointCache_endpoints_mu;
	run mutexMonitor(b_dynClient_endpointCache_endpoints_mu);
	run TestBackendStates74(b_dynClient_endpointCache_endpoints_mu,child_TestBackendStates740);
	child_TestBackendStates740?0;
	stop_process: skip;
	child!0
}
proctype TestBackendStates74(Mutexdef b_dynClient_endpointCache_endpoints_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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

