#define not_found_736  -2
#define not_found_750  -2
#define not_found_764  -2
#define not_found_777  -2

// https://github.com/kubernetes/kubernetes/blob/master/pkg/proxy/service_test.go#L710
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBuildServiceMapServiceUpdate7100 = [1] of {int};
	run TestBuildServiceMapServiceUpdate710(child_TestBuildServiceMapServiceUpdate7100)
stop_process:skip
}

proctype TestBuildServiceMapServiceUpdate710(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Update3237 = [1] of {int};
	chan child_updateService5436 = [1] of {int};
	chan child_Update3235 = [1] of {int};
	chan child_updateService5434 = [1] of {int};
	chan child_Update3233 = [1] of {int};
	chan child_updateService5432 = [1] of {int};
	chan child_Update3231 = [1] of {int};
	chan child_addService5390 = [1] of {int};
	Mutexdef fp_serviceChanges_lock;
	Mutexdef fp_endpointsChanges_endpointSliceCache_lock;
	Mutexdef fp_endpointsChanges_lock;
	run mutexMonitor(fp_endpointsChanges_lock);
	run mutexMonitor(fp_endpointsChanges_endpointSliceCache_lock);
	run mutexMonitor(fp_serviceChanges_lock);
	run addService539(fp_endpointsChanges_lock,fp_endpointsChanges_endpointSliceCache_lock,fp_serviceChanges_lock,child_addService5390);
	child_addService5390?0;
	run Update323(fp_serviceChanges_lock,not_found_736,child_Update3231);
	child_Update3231?0;
	run updateService543(fp_endpointsChanges_lock,fp_endpointsChanges_endpointSliceCache_lock,fp_serviceChanges_lock,child_updateService5432);
	child_updateService5432?0;
	run Update323(fp_serviceChanges_lock,not_found_750,child_Update3233);
	child_Update3233?0;
	run updateService543(fp_endpointsChanges_lock,fp_endpointsChanges_endpointSliceCache_lock,fp_serviceChanges_lock,child_updateService5434);
	child_updateService5434?0;
	run Update323(fp_serviceChanges_lock,not_found_764,child_Update3235);
	child_Update3235?0;
	run updateService543(fp_endpointsChanges_lock,fp_endpointsChanges_endpointSliceCache_lock,fp_serviceChanges_lock,child_updateService5436);
	child_updateService5436?0;
	run Update323(fp_serviceChanges_lock,not_found_777,child_Update3237);
	child_Update3237?0;
	stop_process: skip;
	child!0
}
proctype addService539(Mutexdef fake_endpointsChanges_lock;Mutexdef fake_endpointsChanges_endpointSliceCache_lock;Mutexdef fake_serviceChanges_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Update2800 = [1] of {int};
	run Update280(fake_serviceChanges_lock,child_Update2800);
	child_Update2800?0;
	stop_process: skip;
	child!0
}
proctype Update280(Mutexdef sct_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_serviceToServiceMap3451 = [1] of {int};
	chan child_serviceToServiceMap3450 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	sct_lock.Lock!false;
	

	if
	:: true -> 
		run serviceToServiceMap345(sct_lock,child_serviceToServiceMap3450);
		child_serviceToServiceMap3450?0
	:: true;
	fi;
	run serviceToServiceMap345(sct_lock,child_serviceToServiceMap3451);
	child_serviceToServiceMap3451?0;
	goto stop_process;
	stop_process: skip;
		sct_lock.Unlock!false;
	child!0
}
proctype serviceToServiceMap345(Mutexdef sct_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newBaseServiceInfo1470 = [1] of {int};
	chan child_newBaseServiceInfo1471 = [1] of {int};
	int service_Spec_Ports = -2;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: service_Spec_Ports-1 != -3 -> 
				for(i : 0.. service_Spec_Ports-1) {
			for10: skip;
			run newBaseServiceInfo147(sct_lock,child_newBaseServiceInfo1470);
			child_newBaseServiceInfo1470?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for17: skip;
			run newBaseServiceInfo147(sct_lock,child_newBaseServiceInfo1471);
			child_newBaseServiceInfo1471?0;
			for17_end: skip
		:: true -> 
			break
		od;
		for17_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newBaseServiceInfo147(Mutexdef sct_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Update323(Mutexdef changes_lock;int sm;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_apply3771 = [1] of {int};
	run apply377(changes_lock,child_apply3771);
	child_apply3771?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype apply377(Mutexdef changes_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	changes_lock.Lock!false;
	stop_process: skip;
		changes_lock.Unlock!false;
	child!0
}
proctype updateService543(Mutexdef fake_endpointsChanges_lock;Mutexdef fake_endpointsChanges_endpointSliceCache_lock;Mutexdef fake_serviceChanges_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Update2802 = [1] of {int};
	run Update280(fake_serviceChanges_lock,child_Update2802);
	child_Update2802?0;
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

