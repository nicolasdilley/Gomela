
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/cloudresource/cloud_request_manager_test.go#L84
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNodeAddressesUsesLastSuccess840 = [1] of {int};
	run TestNodeAddressesUsesLastSuccess84(child_TestNodeAddressesUsesLastSuccess840)
stop_process:skip
}

proctype TestNodeAddressesUsesLastSuccess84(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewSyncManager560 = [1] of {int};
	Mutexdef cloud_addCallLock;
	Mutexdef cloud_Lock;
	Mutexdef cloud_addressesMux;
	run mutexMonitor(cloud_addressesMux);
	run mutexMonitor(cloud_Lock);
	run mutexMonitor(cloud_addCallLock);
	run NewSyncManager56(cloud_addressesMux,cloud_Lock,cloud_addCallLock,child_NewSyncManager560);
	child_NewSyncManager560?0;
	stop_process: skip;
	child!0
}
proctype NewSyncManager56(Mutexdef cloud_addressesMux;Mutexdef cloud_Lock;Mutexdef cloud_addCallLock;chan child) {
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

