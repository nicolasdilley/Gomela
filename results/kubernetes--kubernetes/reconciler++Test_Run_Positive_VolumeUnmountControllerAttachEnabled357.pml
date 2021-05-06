
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/volumemanager/reconciler/reconciler_test.go#L357
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_Run_Positive_VolumeUnmountControllerAttachEnabled3570 = [1] of {int};
	run Test_Run_Positive_VolumeUnmountControllerAttachEnabled357(child_Test_Run_Positive_VolumeUnmountControllerAttachEnabled3570)
stop_process:skip
}

proctype Test_Run_Positive_VolumeUnmountControllerAttachEnabled357(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewReconciler961 = [1] of {int};
	chan child_NewOperationGenerator900 = [1] of {int};
	Mutexdef volumePluginMgr_mutex;
	run mutexMonitor(volumePluginMgr_mutex);
	run NewOperationGenerator90(volumePluginMgr_mutex,child_NewOperationGenerator900);
	child_NewOperationGenerator900?0;
	run NewReconciler96(volumePluginMgr_mutex,child_NewReconciler961);
	child_NewReconciler961?0;
	stop_process: skip;
	child!0
}
proctype NewOperationGenerator90(Mutexdef volumePluginMgr_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewReconciler96(Mutexdef volumePluginMgr_mutex;chan child) {
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

