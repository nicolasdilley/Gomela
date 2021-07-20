// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/dapr/dapr/blob/ab83d3535478699a2f2707d9ed9008f78c155d6d/pkg/runtime/runtime_test.go#L220
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDoProcessComponent2200 = [1] of {int};
	run TestDoProcessComponent220(child_TestDoProcessComponent2200);
	run receiver(child_TestDoProcessComponent2200)
stop_process:skip
}

proctype TestDoProcessComponent220(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_stopRuntime27770 = [1] of {int};
	Mutexdef rt_grpc_lock;
	Mutexdef rt_componentsLock;
	run mutexMonitor(rt_componentsLock);
	run mutexMonitor(rt_grpc_lock);
		defer1: skip;
	run stopRuntime2777(rt_componentsLock,rt_grpc_lock,child_stopRuntime27770);
	child_stopRuntime27770?0;
	stop_process: skip;
	child!0
}
proctype stopRuntime2777(Mutexdef rt_componentsLock;Mutexdef rt_grpc_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_shutdownComponents15121 = [1] of {int};
	chan child_stopActor15040 = [1] of {int};
	run stopActor1504(rt_componentsLock,rt_grpc_lock,child_stopActor15040);
	child_stopActor15040?0;
	run shutdownComponents1512(rt_componentsLock,rt_grpc_lock,child_shutdownComponents15121);
	child_shutdownComponents15121?0;
	stop_process: skip;
	child!0
}
proctype stopActor1504(Mutexdef a_componentsLock;Mutexdef a_grpc_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

