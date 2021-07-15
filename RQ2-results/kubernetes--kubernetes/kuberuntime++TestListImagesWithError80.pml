
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/kuberuntime/kuberuntime_image_test.go#L80
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestListImagesWithError800 = [1] of {int};
	run TestListImagesWithError80(child_TestListImagesWithError800)
stop_process:skip
}

proctype TestListImagesWithError80(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ListImages960 = [1] of {int};
	Mutexdef fakeManager_logReduction_errorMapLock;
	run mutexMonitor(fakeManager_logReduction_errorMapLock);
	run ListImages96(fakeManager_logReduction_errorMapLock,child_ListImages960);
	child_ListImages960?0;
	stop_process: skip;
	child!0
}
proctype ListImages96(Mutexdef m_logReduction_errorMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

