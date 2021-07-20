// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/consul/blob/8d6cbe72813779f60ac24d119cc311c21003f4ce/connect/example_test.go#L35
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ExampleService_ServerTLSConfig_tLS350 = [1] of {int};
	run ExampleService_ServerTLSConfig_tLS35(child_ExampleService_ServerTLSConfig_tLS350);
	run receiver(child_ExampleService_ServerTLSConfig_tLS350)
stop_process:skip
}

proctype ExampleService_ServerTLSConfig_tLS35(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ServerTLSConfig1781 = [1] of {int};
	chan child_NewService1190 = [1] of {int};
	Mutexdef svc_leafWatch_stopLock;
	Mutexdef svc_rootsWatch_stopLock;
	Mutexdef svc_client_modifyLock;
	Mutexdef client_modifyLock;
	run mutexMonitor(client_modifyLock);
	run mutexMonitor(svc_client_modifyLock);
	run mutexMonitor(svc_rootsWatch_stopLock);
	run mutexMonitor(svc_leafWatch_stopLock);
	run NewService119(client_modifyLock,child_NewService1190);
	child_NewService1190?0;
	run ServerTLSConfig178(svc_client_modifyLock,svc_leafWatch_stopLock,svc_rootsWatch_stopLock,child_ServerTLSConfig1781);
	child_ServerTLSConfig1781?0;
	stop_process: skip;
	child!0
}
proctype NewService119(Mutexdef client_modifyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ServerTLSConfig178(Mutexdef s_client_modifyLock;Mutexdef s_leafWatch_stopLock;Mutexdef s_rootsWatch_stopLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newServerSideVerifier2071 = [1] of {int};
	run newServerSideVerifier207(s_client_modifyLock,child_newServerSideVerifier2071);
	child_newServerSideVerifier2071?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newServerSideVerifier207(Mutexdef client_modifyLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

