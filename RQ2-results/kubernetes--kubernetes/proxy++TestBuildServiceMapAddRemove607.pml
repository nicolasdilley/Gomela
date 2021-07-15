#define not_found_654  -2
#define not_found_687  -2

// https://github.com/kubernetes/kubernetes/blob/master/pkg/proxy/service_test.go#L607
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBuildServiceMapAddRemove6070 = [1] of {int};
	run TestBuildServiceMapAddRemove607(child_TestBuildServiceMapAddRemove6070)
stop_process:skip
}

proctype TestBuildServiceMapAddRemove607(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Update3237 = [1] of {int};
	chan child_deleteService5476 = [1] of {int};
	chan child_deleteService5475 = [1] of {int};
	chan child_deleteService5474 = [1] of {int};
	chan child_updateService5433 = [1] of {int};
	chan child_Update3232 = [1] of {int};
	chan child_addService5390 = [1] of {int};
	chan child_addService5391 = [1] of {int};
	Mutexdef fp_serviceChanges_lock;
	Mutexdef fp_endpointsChanges_endpointSliceCache_lock;
	Mutexdef fp_endpointsChanges_lock;
	int services = -2;
	run mutexMonitor(fp_endpointsChanges_lock);
	run mutexMonitor(fp_endpointsChanges_endpointSliceCache_lock);
	run mutexMonitor(fp_serviceChanges_lock);
	

	if
	:: services-1 != -3 -> 
				for(i : 0.. services-1) {
			for10: skip;
			run addService539(fp_endpointsChanges_lock,fp_endpointsChanges_endpointSliceCache_lock,fp_serviceChanges_lock,child_addService5390);
			child_addService5390?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for19: skip;
			run addService539(fp_endpointsChanges_lock,fp_endpointsChanges_endpointSliceCache_lock,fp_serviceChanges_lock,child_addService5391);
			child_addService5391?0;
			for19_end: skip
		:: true -> 
			break
		od;
		for19_exit: skip
	fi;
	run Update323(fp_serviceChanges_lock,not_found_654,child_Update3232);
	child_Update3232?0;
	run updateService543(fp_endpointsChanges_lock,fp_endpointsChanges_endpointSliceCache_lock,fp_serviceChanges_lock,child_updateService5433);
	child_updateService5433?0;
	run deleteService547(fp_endpointsChanges_lock,fp_endpointsChanges_endpointSliceCache_lock,fp_serviceChanges_lock,child_deleteService5474);
	child_deleteService5474?0;
	run deleteService547(fp_endpointsChanges_lock,fp_endpointsChanges_endpointSliceCache_lock,fp_serviceChanges_lock,child_deleteService5475);
	child_deleteService5475?0;
	run deleteService547(fp_endpointsChanges_lock,fp_endpointsChanges_endpointSliceCache_lock,fp_serviceChanges_lock,child_deleteService5476);
	child_deleteService5476?0;
	run Update323(fp_serviceChanges_lock,not_found_687,child_Update3237);
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
			for11: skip;
			run newBaseServiceInfo147(sct_lock,child_newBaseServiceInfo1470);
			child_newBaseServiceInfo1470?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for18: skip;
			run newBaseServiceInfo147(sct_lock,child_newBaseServiceInfo1471);
			child_newBaseServiceInfo1471?0;
			for18_end: skip
		:: true -> 
			break
		od;
		for18_exit: skip
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
	chan child_apply3772 = [1] of {int};
	run apply377(changes_lock,child_apply3772);
	child_apply3772?0;
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
	chan child_Update2803 = [1] of {int};
	run Update280(fake_serviceChanges_lock,child_Update2803);
	child_Update2803?0;
	stop_process: skip;
	child!0
}
proctype deleteService547(Mutexdef fake_endpointsChanges_lock;Mutexdef fake_endpointsChanges_endpointSliceCache_lock;Mutexdef fake_serviceChanges_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Update2804 = [1] of {int};
	run Update280(fake_serviceChanges_lock,child_Update2804);
	child_Update2804?0;
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

