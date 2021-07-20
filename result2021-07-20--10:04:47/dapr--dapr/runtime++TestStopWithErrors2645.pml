// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/dapr/dapr/blob/ab83d3535478699a2f2707d9ed9008f78c155d6d/pkg/runtime/runtime_test.go#L2645
#define not_found_992  -2 // opt items line 1755
#define not_found_855  -2 // opt items line 1755
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStopWithErrors26450 = [1] of {int};
	run TestStopWithErrors2645(child_TestStopWithErrors26450);
	run receiver(child_TestStopWithErrors26450)
stop_process:skip
}

proctype TestStopWithErrors2645(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_shutdownComponents15125 = [1] of {int};
	chan child_initSecretStore17334 = [1] of {int};
	chan child_initState8473 = [1] of {int};
	chan child_initPubSub9842 = [1] of {int};
	chan child_initOutputBinding8211 = [1] of {int};
	chan child_initInputBinding7980 = [1] of {int};
	Mutexdef rt_grpc_lock;
	Mutexdef rt_componentsLock;
	run mutexMonitor(rt_componentsLock);
	run mutexMonitor(rt_grpc_lock);
	run initInputBinding798(rt_componentsLock,rt_grpc_lock,child_initInputBinding7980);
	child_initInputBinding7980?0;
	run initOutputBinding821(rt_componentsLock,rt_grpc_lock,child_initOutputBinding8211);
	child_initOutputBinding8211?0;
	run initPubSub984(rt_componentsLock,rt_grpc_lock,child_initPubSub9842);
	child_initPubSub9842?0;
	run initState847(rt_componentsLock,rt_grpc_lock,child_initState8473);
	child_initState8473?0;
	run initSecretStore1733(rt_componentsLock,rt_grpc_lock,child_initSecretStore17334);
	child_initSecretStore17334?0;
	run shutdownComponents1512(rt_componentsLock,rt_grpc_lock,child_shutdownComponents15125);
	child_shutdownComponents15125?0;
	stop_process: skip;
	child!0
}
proctype initInputBinding798(Mutexdef a_componentsLock;Mutexdef a_grpc_lock;chan child) {
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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype initOutputBinding821(Mutexdef a_componentsLock;Mutexdef a_grpc_lock;chan child) {
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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype initPubSub984(Mutexdef a_componentsLock;Mutexdef a_grpc_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_convertMetadataItemsToProperties17552 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run convertMetadataItemsToProperties1755(a_componentsLock,a_grpc_lock,not_found_992,child_convertMetadataItemsToProperties17552);
	child_convertMetadataItemsToProperties17552?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype convertMetadataItemsToProperties1755(Mutexdef a_componentsLock;Mutexdef a_grpc_lock;int items;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype initState847(Mutexdef a_componentsLock;Mutexdef a_grpc_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_hostingActors13104 = [1] of {int};
	chan child_convertMetadataItemsToProperties17553 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run convertMetadataItemsToProperties1755(a_componentsLock,a_grpc_lock,not_found_855,child_convertMetadataItemsToProperties17553);
		child_convertMetadataItemsToProperties17553?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run hostingActors1310(a_componentsLock,a_grpc_lock,child_hostingActors13104);
	child_hostingActors13104?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype hostingActors1310(Mutexdef a_componentsLock;Mutexdef a_grpc_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype initSecretStore1733(Mutexdef a_componentsLock;Mutexdef a_grpc_lock;chan child) {
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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype shutdownComponents1512(Mutexdef a_componentsLock;Mutexdef a_grpc_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_a_stateStoresa_stateStores = -2; // opt var_a_stateStoresa_stateStores
	int var_a_pubSubsa_pubSubs = -2; // opt var_a_pubSubsa_pubSubs
	int var_a_secretStoresa_secretStores = -2; // opt var_a_secretStoresa_secretStores
	int var_a_outputBindingsa_outputBindings = -2; // opt var_a_outputBindingsa_outputBindings
	int var_a_inputBindingsa_inputBindings = -2; // opt var_a_inputBindingsa_inputBindings
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

