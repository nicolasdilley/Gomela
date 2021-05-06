
// https://github.com/istio/istio/blob/master/pilot/pkg/serviceregistry/aggregate/controller_test.go#L318
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInstances3180 = [1] of {int};
	run TestInstances318(child_TestInstances3180)
stop_process:skip
}

proctype TestInstances318(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_InstancesByPort2001 = [1] of {int};
	chan child_InstancesByPort2000 = [1] of {int};
	Mutexdef aggregateCtl_storeLock;
	run mutexMonitor(aggregateCtl_storeLock);
	run InstancesByPort200(aggregateCtl_storeLock,child_InstancesByPort2000);
	child_InstancesByPort2000?0;
	run InstancesByPort200(aggregateCtl_storeLock,child_InstancesByPort2001);
	child_InstancesByPort2001?0;
	stop_process: skip;
	child!0
}
proctype InstancesByPort200(Mutexdef c_storeLock;chan child) {
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

