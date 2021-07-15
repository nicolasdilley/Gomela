
// https://github.com/kubernetes/kubernetes/blob/master/pkg/controller/namespace/deletion/namespaced_resources_deleter_test.go#L60
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFinalizeNamespaceFunc600 = [1] of {int};
	run TestFinalizeNamespaceFunc60(child_TestFinalizeNamespaceFunc600)
stop_process:skip
}

proctype TestFinalizeNamespaceFunc60(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_finalizeNamespace2790 = [1] of {int};
	Mutexdef d_opCache_lock;
	run mutexMonitor(d_opCache_lock);
	run finalizeNamespace279(d_opCache_lock,child_finalizeNamespace2790);
	child_finalizeNamespace2790?0;
	stop_process: skip;
	child!0
}
proctype finalizeNamespace279(Mutexdef d_opCache_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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

