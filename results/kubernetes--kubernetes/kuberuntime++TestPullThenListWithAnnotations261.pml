
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/kuberuntime/kuberuntime_image_test.go#L261
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPullThenListWithAnnotations2610 = [1] of {int};
	run TestPullThenListWithAnnotations261(child_TestPullThenListWithAnnotations2610)
stop_process:skip
}

proctype TestPullThenListWithAnnotations261(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ListImages961 = [1] of {int};
	chan child_PullImage310 = [1] of {int};
	Mutexdef fakeManager_logReduction_errorMapLock;
	run mutexMonitor(fakeManager_logReduction_errorMapLock);
	run PullImage31(fakeManager_logReduction_errorMapLock,child_PullImage310);
	child_PullImage310?0;
	run ListImages96(fakeManager_logReduction_errorMapLock,child_ListImages961);
	child_ListImages961?0;
	stop_process: skip;
	child!0
}
proctype PullImage31(Mutexdef m_logReduction_errorMapLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
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

