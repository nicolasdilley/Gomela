
// https://github.com/istio/istio/blob/master/pilot/pkg/networking/core/v1alpha3/name_table_test.go#L42
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNameTable420 = [1] of {int};
	run TestNameTable42(child_TestNameTable420)
stop_process:skip
}

proctype TestNameTable42(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_makeServiceInstances311 = [1] of {int};
	chan child_makeServiceInstances310 = [1] of {int};
	Mutexdef push_initializeMutex;
	Mutexdef push_networksMu;
	Mutexdef push_JwtKeyResolver_keyEntries_mu;
	Mutexdef push_proxyStatusMutex;
	Mutexdef headlessService_Mutex;
	Mutexdef pod2_Locality_state_atomicMessageInfo_initMu;
	Mutexdef pod1_Locality_state_atomicMessageInfo_initMu;
	Mutexdef proxy_Locality_state_atomicMessageInfo_initMu;
	run mutexMonitor(proxy_Locality_state_atomicMessageInfo_initMu);
	run mutexMonitor(pod1_Locality_state_atomicMessageInfo_initMu);
	run mutexMonitor(pod2_Locality_state_atomicMessageInfo_initMu);
	run mutexMonitor(headlessService_Mutex);
	run mutexMonitor(push_proxyStatusMutex);
	run mutexMonitor(push_JwtKeyResolver_keyEntries_mu);
	run mutexMonitor(push_networksMu);
	run mutexMonitor(push_initializeMutex);
	run makeServiceInstances31(pod1_Locality_state_atomicMessageInfo_initMu,headlessService_Mutex,child_makeServiceInstances310);
	child_makeServiceInstances310?0;
	run makeServiceInstances31(pod2_Locality_state_atomicMessageInfo_initMu,headlessService_Mutex,child_makeServiceInstances311);
	child_makeServiceInstances311?0;
	stop_process: skip;
	child!0
}
proctype makeServiceInstances31(Mutexdef proxy_Locality_state_atomicMessageInfo_initMu;Mutexdef service_Mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_makeInstances540 = [1] of {int};
	chan child_makeInstances541 = [1] of {int};
	int service_Ports = -2;
	

	if
	:: service_Ports-1 != -3 -> 
				for(i : 0.. service_Ports-1) {
			for10: skip;
			run makeInstances54(proxy_Locality_state_atomicMessageInfo_initMu,service_Mutex,child_makeInstances540);
			child_makeInstances540?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			run makeInstances54(proxy_Locality_state_atomicMessageInfo_initMu,service_Mutex,child_makeInstances541);
			child_makeInstances541?0;
			for13_end: skip
		:: true -> 
			break
		od;
		for13_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype makeInstances54(Mutexdef proxy_Locality_state_atomicMessageInfo_initMu;Mutexdef svc_Mutex;chan child) {
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

