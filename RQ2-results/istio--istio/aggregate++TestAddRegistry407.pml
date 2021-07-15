
// https://github.com/istio/istio/blob/master/pilot/pkg/serviceregistry/aggregate/controller_test.go#L407
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAddRegistry4070 = [1] of {int};
	run TestAddRegistry407(child_TestAddRegistry4070)
stop_process:skip
}

proctype TestAddRegistry407(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AddRegistry620 = [1] of {int};
	chan child_AddRegistry621 = [1] of {int};
	Mutexdef ctrl_storeLock;
	int registries = -2;
	run mutexMonitor(ctrl_storeLock);
	

	if
	:: registries-1 != -3 -> 
				for(i : 0.. registries-1) {
			for10: skip;
			run AddRegistry62(ctrl_storeLock,child_AddRegistry620);
			child_AddRegistry620?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run AddRegistry62(ctrl_storeLock,child_AddRegistry621);
			child_AddRegistry621?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype AddRegistry62(Mutexdef c_storeLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_storeLock.Lock!false;
	stop_process: skip;
		c_storeLock.Unlock!false;
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

