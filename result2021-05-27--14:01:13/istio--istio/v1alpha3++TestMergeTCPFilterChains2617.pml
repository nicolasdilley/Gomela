// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pilot/pkg/networking/core/v1alpha3/listener_test.go#L2617
#define not_found_2722  -2 // opt not_found_2722
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMergeTCPFilterChains26170 = [1] of {int};
	run TestMergeTCPFilterChains2617(child_TestMergeTCPFilterChains26170);
	run receiver(child_TestMergeTCPFilterChains26170)
stop_process:skip
}

proctype TestMergeTCPFilterChains2617(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_mergeTCPFilterChains15770 = [1] of {int};
	Mutexdef opts_service_Mutex;
	Mutexdef opts_push_initializeMutex;
	Mutexdef opts_push_networksMu;
	Mutexdef opts_push_proxyStatusMutex;
	Mutexdef svc_Mutex;
	Mutexdef push_initializeMutex;
	Mutexdef push_networksMu;
	Mutexdef push_proxyStatusMutex;
	run mutexMonitor(push_proxyStatusMutex);
	run mutexMonitor(push_networksMu);
	run mutexMonitor(push_initializeMutex);
	run mutexMonitor(svc_Mutex);
	run mutexMonitor(opts_push_proxyStatusMutex);
	run mutexMonitor(opts_push_networksMu);
	run mutexMonitor(opts_push_initializeMutex);
	run mutexMonitor(opts_service_Mutex);
	run mergeTCPFilterChains1577(opts_push_initializeMutex,opts_push_networksMu,opts_push_proxyStatusMutex,opts_service_Mutex,not_found_2722,child_mergeTCPFilterChains15770);
	child_mergeTCPFilterChains15770?0;
	stop_process: skip;
	child!0
}
proctype mergeTCPFilterChains1577(Mutexdef listenerOpts_push_initializeMutex;Mutexdef listenerOpts_push_networksMu;Mutexdef listenerOpts_push_proxyStatusMutex;Mutexdef listenerOpts_service_Mutex;int incoming;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int mergedFilterChains = -2; // opt mergedFilterChains
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

