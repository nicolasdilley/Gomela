// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/view/log.go#L48
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewLog480 = [1] of {int};
	run NewLog48(child_NewLog480);
	run receiver(child_NewLog480)
stop_process:skip
}

proctype NewLog48(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef l_model_mx;
	Mutexdef l_model_items_mx;
	Mutexdef l_logs_app_factory_mx;
	Mutexdef l_logs_app_command_mx;
	Mutexdef l_app_clusterModel_cache_lock;
	Mutexdef l_app_factory_mx;
	Mutexdef l_app_command_mx;
	run mutexMonitor(l_app_command_mx);
	run mutexMonitor(l_app_factory_mx);
	run mutexMonitor(l_app_clusterModel_cache_lock);
	run mutexMonitor(l_logs_app_command_mx);
	run mutexMonitor(l_logs_app_factory_mx);
	run mutexMonitor(l_model_items_mx);
	run mutexMonitor(l_model_mx);
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

