// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/valyala/fasthttp/blob//client_example_test.go#L9
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ExampleHostClient90 = [1] of {int};
	run ExampleHostClient9(child_ExampleHostClient90);
	run receiver(child_ExampleHostClient90)
stop_process:skip
}

proctype ExampleHostClient9(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get7951 = [1] of {int};
	chan child_Get7950 = [1] of {int};
	Mutexdef c_tlsConfigMapLock;
	Mutexdef c_addrsLock;
	Mutexdef c_connsLock;
	Mutexdef c_TLSConfig_mutex;
	run mutexMonitor(c_TLSConfig_mutex);
	run mutexMonitor(c_connsLock);
	run mutexMonitor(c_addrsLock);
	run mutexMonitor(c_tlsConfigMapLock);
	run Get795(c_addrsLock,c_connsLock,c_TLSConfig_mutex,c_tlsConfigMapLock,child_Get7950);
	child_Get7950?0;
	run Get795(c_addrsLock,c_connsLock,c_TLSConfig_mutex,c_tlsConfigMapLock,child_Get7951);
	child_Get7951?0;
	stop_process: skip;
	child!0
}
proctype Get795(Mutexdef c_addrsLock;Mutexdef c_connsLock;Mutexdef c_TLSConfig_mutex;Mutexdef c_tlsConfigMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_clientGetURL8410 = [1] of {int};
	run clientGetURL841(c_addrsLock,c_connsLock,c_TLSConfig_mutex,c_tlsConfigMapLock,child_clientGetURL8410);
	child_clientGetURL8410?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype clientGetURL841(Mutexdef c_addrsLock;Mutexdef c_connsLock;Mutexdef c_TLSConfig_mutex;Mutexdef c_tlsConfigMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_doRequestFollowRedirectsBuffer9660 = [1] of {int};
	run doRequestFollowRedirectsBuffer966(c_addrsLock,c_connsLock,c_TLSConfig_mutex,c_tlsConfigMapLock,child_doRequestFollowRedirectsBuffer9660);
	child_doRequestFollowRedirectsBuffer9660?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype doRequestFollowRedirectsBuffer966(Mutexdef c_addrsLock;Mutexdef c_connsLock;Mutexdef c_TLSConfig_mutex;Mutexdef c_tlsConfigMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_doRequestFollowRedirects9830 = [1] of {int};
	run doRequestFollowRedirects983(c_addrsLock,c_connsLock,c_TLSConfig_mutex,c_tlsConfigMapLock,child_doRequestFollowRedirects9830);
	child_doRequestFollowRedirects9830?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype doRequestFollowRedirects983(Mutexdef c_addrsLock;Mutexdef c_connsLock;Mutexdef c_TLSConfig_mutex;Mutexdef c_tlsConfigMapLock;chan child) {
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

