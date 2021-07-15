
// https://github.com/istio/istio/blob/master/pilot/pkg/serviceregistry/aggregate/controller_test.go#L284
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetProxyWorkloadLabels2840 = [1] of {int};
	run TestGetProxyWorkloadLabels284(child_TestGetProxyWorkloadLabels2840)
stop_process:skip
}

proctype TestGetProxyWorkloadLabels284(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetProxyWorkloadLabels2470 = [1] of {int};
	Mutexdef aggregateCtl_storeLock;
	run mutexMonitor(aggregateCtl_storeLock);
	run GetProxyWorkloadLabels247(aggregateCtl_storeLock,child_GetProxyWorkloadLabels2470);
	child_GetProxyWorkloadLabels2470?0;
	stop_process: skip;
	child!0
}
proctype GetProxyWorkloadLabels247(Mutexdef c_storeLock;chan child) {
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

