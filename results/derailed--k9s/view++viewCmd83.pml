// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/view/dir.go#L83
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_viewCmd830 = [1] of {int};
	run viewCmd83(child_viewCmd830);
	run receiver(child_viewCmd830)
stop_process:skip
}

proctype viewCmd83(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_inject6330 = [1] of {int};
	Mutexdef details_app_clusterModel_cache_lock;
	Mutexdef details_app_factory_mx;
	Mutexdef details_app_command_mx;
	

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
	run mutexMonitor(details_app_command_mx);
	run mutexMonitor(details_app_factory_mx);
	run mutexMonitor(details_app_clusterModel_cache_lock);
	run inject633(details_app_clusterModel_cache_lock,details_app_command_mx,details_app_factory_mx,child_inject6330);
	child_inject6330?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype inject633(Mutexdef c_app_clusterModel_cache_lock;Mutexdef c_app_command_mx;Mutexdef c_app_factory_mx;chan child) {
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

proctype receiver(chan c) {
c?0
}

