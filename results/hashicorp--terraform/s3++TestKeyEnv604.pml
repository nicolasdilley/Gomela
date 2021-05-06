
// https://github.com/hashicorp/terraform/blob/master/backend/remote-state/s3/backend_test.go#L604
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestKeyEnv6040 = [1] of {int};
	run TestKeyEnv604(child_TestKeyEnv6040)
stop_process:skip
}

proctype TestKeyEnv604(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TestBackendStates747 = [1] of {int};
	chan child_TestBackendStates746 = [1] of {int};
	chan child_TestBackendStates745 = [1] of {int};
	chan child_testGetWorkspaceForKey6654 = [1] of {int};
	chan child_testGetWorkspaceForKey6653 = [1] of {int};
	chan child_testGetWorkspaceForKey6652 = [1] of {int};
	chan child_testGetWorkspaceForKey6651 = [1] of {int};
	chan child_testGetWorkspaceForKey6650 = [1] of {int};
	Mutexdef b2_dynClient_endpointCache_endpoints_mu;
	Mutexdef b1_dynClient_endpointCache_endpoints_mu;
	Mutexdef b0_dynClient_endpointCache_endpoints_mu;
	run mutexMonitor(b0_dynClient_endpointCache_endpoints_mu);
	run mutexMonitor(b1_dynClient_endpointCache_endpoints_mu);
	run mutexMonitor(b2_dynClient_endpointCache_endpoints_mu);
	run testGetWorkspaceForKey665(b0_dynClient_endpointCache_endpoints_mu,child_testGetWorkspaceForKey6650);
	child_testGetWorkspaceForKey6650?0;
	run testGetWorkspaceForKey665(b0_dynClient_endpointCache_endpoints_mu,child_testGetWorkspaceForKey6651);
	child_testGetWorkspaceForKey6651?0;
	run testGetWorkspaceForKey665(b1_dynClient_endpointCache_endpoints_mu,child_testGetWorkspaceForKey6652);
	child_testGetWorkspaceForKey6652?0;
	run testGetWorkspaceForKey665(b1_dynClient_endpointCache_endpoints_mu,child_testGetWorkspaceForKey6653);
	child_testGetWorkspaceForKey6653?0;
	run testGetWorkspaceForKey665(b2_dynClient_endpointCache_endpoints_mu,child_testGetWorkspaceForKey6654);
	child_testGetWorkspaceForKey6654?0;
	run TestBackendStates74(b0_dynClient_endpointCache_endpoints_mu,child_TestBackendStates745);
	child_TestBackendStates745?0;
	run TestBackendStates74(b1_dynClient_endpointCache_endpoints_mu,child_TestBackendStates746);
	child_TestBackendStates746?0;
	run TestBackendStates74(b2_dynClient_endpointCache_endpoints_mu,child_TestBackendStates747);
	child_TestBackendStates747?0;
	stop_process: skip;
	child!0
}
proctype testGetWorkspaceForKey665(Mutexdef b_dynClient_endpointCache_endpoints_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_keyEnv540 = [1] of {int};
	run keyEnv54(b_dynClient_endpointCache_endpoints_mu,child_keyEnv540);
	child_keyEnv540?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype keyEnv54(Mutexdef b_dynClient_endpointCache_endpoints_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
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

