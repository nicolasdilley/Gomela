// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob//pilot/pkg/serviceregistry/aggregate/controller_test.go#L427
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetDeleteRegistry4270 = [1] of {int};
	run TestGetDeleteRegistry427(child_TestGetDeleteRegistry4270);
	run receiver(child_TestGetDeleteRegistry4270)
stop_process:skip
}

proctype TestGetDeleteRegistry427(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetRegistries884 = [1] of {int};
	chan child_DeleteRegistry703 = [1] of {int};
	chan child_GetRegistries882 = [1] of {int};
	chan child_AddRegistry620 = [1] of {int};
	chan child_AddRegistry621 = [1] of {int};
	Mutexdef ctrl_storeLock;
	int var_registries = -2; // opt var_registries
	run mutexMonitor(ctrl_storeLock);
	

	if
	:: var_registries-1 != -3 -> 
				for(i : 0.. var_registries-1) {
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
	run GetRegistries88(ctrl_storeLock,child_GetRegistries882);
	child_GetRegistries882?0;
	run DeleteRegistry70(ctrl_storeLock,child_DeleteRegistry703);
	child_DeleteRegistry703?0;
	run GetRegistries88(ctrl_storeLock,child_GetRegistries884);
	child_GetRegistries884?0;
	stop_process: skip;
	child!0
}
proctype AddRegistry62(Mutexdef c_storeLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_storeLock.Lock!false;
		defer1: skip;
	c_storeLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype GetRegistries88(Mutexdef c_storeLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_c_registries = -2; // opt var_c_registries
	c_storeLock.RLock!false;
	goto defer1;
		defer1: skip;
	c_storeLock.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype DeleteRegistry70(Mutexdef c_storeLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getRegistryIndex1003 = [1] of {int};
	c_storeLock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run getRegistryIndex100(c_storeLock,child_getRegistryIndex1003);
	child_getRegistryIndex1003?0;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
		defer1: skip;
	c_storeLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype getRegistryIndex100(Mutexdef c_storeLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_c_registries = -2; // opt var_c_registries
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

