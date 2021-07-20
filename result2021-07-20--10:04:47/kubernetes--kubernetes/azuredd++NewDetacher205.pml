// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/volume/azuredd/azure_dd.go#L205
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewDetacher2050 = [1] of {int};
	run NewDetacher205(child_NewDetacher2050);
	run receiver(child_NewDetacher2050)
stop_process:skip
}

proctype NewDetacher205(chan child) {
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

proctype receiver(chan c) {
c?0
}
