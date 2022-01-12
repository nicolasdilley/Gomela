// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/derailed/k9s/blob//internal/view/helpers_test.go#L138
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestK9sEnv1380 = [1] of {int};
	run TestK9sEnv138(child_TestK9sEnv1380);
	run receiver(child_TestK9sEnv1380)
stop_process:skip
}

proctype TestK9sEnv138(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_defaultEnv620 = [1] of {int};
	Mutexdef c_mutex;
	Mutexdef c_flags_lock;
	Mutexdef flags_lock;
	run mutexMonitor(flags_lock);
	run mutexMonitor(c_flags_lock);
	run mutexMonitor(c_mutex);
	run defaultEnv62(c_flags_lock,c_mutex,child_defaultEnv620);
	child_defaultEnv620?0;
	stop_process: skip;
	child!0
}
proctype defaultEnv62(Mutexdef c_flags_lock;Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_k8sEnv290 = [1] of {int};
	int var_header_Columns = -2; // opt var_header_Columns
	run k8sEnv29(c_flags_lock,c_mutex,child_k8sEnv290);
	child_k8sEnv290?0;
	goto stop_process;
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

