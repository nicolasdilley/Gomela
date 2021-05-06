
// https://github.com/istio/istio/blob/master/pilot/pkg/serviceregistry/serviceentry/servicediscovery_test.go#L170
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestServiceDiscoveryGetService1700 = [1] of {int};
	run TestServiceDiscoveryGetService170(child_TestServiceDiscoveryGetService1700)
stop_process:skip
}

proctype TestServiceDiscoveryGetService170(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetService5061 = [1] of {int};
	chan child_GetService5060 = [1] of {int};
	Mutexdef service_Mutex;
	Mutexdef sd_storeMutex;
	run mutexMonitor(sd_storeMutex);
	sd_storeMutex.Lock!false;
	sd_storeMutex.Unlock!false;
	run mutexMonitor(service_Mutex);
	run GetService506(sd_storeMutex,child_GetService5060);
	child_GetService5060?0;
	run GetService506(sd_storeMutex,child_GetService5061);
	child_GetService5061?0;
	stop_process: skip;
	child!0
}
proctype GetService506(Mutexdef s_storeMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Services4940 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Services494(s_storeMutex,child_Services4940);
	child_Services4940?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Services494(Mutexdef s_storeMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_maybeRefreshIndexes6390 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run maybeRefreshIndexes639(s_storeMutex,child_maybeRefreshIndexes6390);
	child_maybeRefreshIndexes6390?0;
	s_storeMutex.RLock!false;
	goto stop_process;
	stop_process: skip;
		s_storeMutex.RUnlock!false;
	child!0
}
proctype maybeRefreshIndexes639(Mutexdef s_storeMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_storeMutex.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
		s_storeMutex.Unlock!false;
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

