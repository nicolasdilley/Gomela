// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/view/helpers_test.go#L119
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestK8sEnv1190 = [1] of {int};
	run TestK8sEnv119(child_TestK8sEnv1190);
	run receiver(child_TestK8sEnv1190)
stop_process:skip
}

proctype TestK8sEnv119(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_k8sEnv290 = [1] of {int};
	Mutexdef c_mutex;
	Mutexdef c_flags_lock;
	Mutexdef flags_lock;
	run mutexMonitor(flags_lock);
	run mutexMonitor(c_flags_lock);
	run mutexMonitor(c_mutex);
	run k8sEnv29(c_flags_lock,c_mutex,child_k8sEnv290);
	child_k8sEnv290?0;
	stop_process: skip;
	child!0
}
proctype k8sEnv29(Mutexdef c_flags_lock;Mutexdef c_mutex;chan child) {
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

