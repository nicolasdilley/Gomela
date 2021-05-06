
// https://github.com/kubernetes/kubernetes/blob/master/pkg/volume/azuredd/azure_dd.go#L192
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewAttacher1920 = [1] of {int};
	run NewAttacher192(child_NewAttacher1920)
stop_process:skip
}

proctype NewAttacher192(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef azure_rtCache_Lock;
	Mutexdef azure_nsgCache_Lock;
	Mutexdef azure_lbCache_Lock;
	Mutexdef azure_vmCache_Lock;
	Mutexdef azure_routeUpdater_lock;
	Mutexdef azure_routeCIDRsLock;
	Mutexdef azure_nodeCachesLock;
	Mutexdef azure_metadata_imsCache_Lock;
	run mutexMonitor(azure_metadata_imsCache_Lock);
	run mutexMonitor(azure_nodeCachesLock);
	run mutexMonitor(azure_routeCIDRsLock);
	run mutexMonitor(azure_routeUpdater_lock);
	run mutexMonitor(azure_vmCache_Lock);
	run mutexMonitor(azure_lbCache_Lock);
	run mutexMonitor(azure_nsgCache_Lock);
	run mutexMonitor(azure_rtCache_Lock);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

