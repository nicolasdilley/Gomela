
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/kuberuntime/kuberuntime_manager_test.go#L285
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContainerRuntimeType2850 = [1] of {int};
	run TestContainerRuntimeType285(child_TestContainerRuntimeType2850)
stop_process:skip
}

proctype TestContainerRuntimeType285(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Type2710 = [1] of {int};
	Mutexdef m_logReduction_errorMapLock;
	run mutexMonitor(m_logReduction_errorMapLock);
	run Type271(m_logReduction_errorMapLock,child_Type2710);
	child_Type2710?0;
	stop_process: skip;
	child!0
}
proctype Type271(Mutexdef m_logReduction_errorMapLock;chan child) {
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

