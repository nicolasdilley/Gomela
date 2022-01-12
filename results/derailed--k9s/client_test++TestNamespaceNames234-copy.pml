// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/derailed/k9s/blob//internal/client/config_test.go#L234
#define def_var_nn  -2 // opt nns line 267
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNamespaceNames2340 = [1] of {int};
	run TestNamespaceNames234(child_TestNamespaceNames2340);
	run receiver(child_TestNamespaceNames2340)
stop_process:skip
}

proctype TestNamespaceNames234(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NamespaceNames2670 = [1] of {int};
	int var_nn = def_var_nn;
	Mutexdef cfg_mutex;
	Mutexdef cfg_flags_lock;
	Mutexdef flags_lock;
	run mutexMonitor(flags_lock);
	run mutexMonitor(cfg_flags_lock);
	run mutexMonitor(cfg_mutex);
	run NamespaceNames267(cfg_flags_lock,cfg_mutex,var_nn,child_NamespaceNames2670);
	child_NamespaceNames2670?0;
	stop_process: skip;
	child!0
}
proctype NamespaceNames267(Mutexdef c_flags_lock;Mutexdef c_mutex;int var_nns;chan child) {
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

