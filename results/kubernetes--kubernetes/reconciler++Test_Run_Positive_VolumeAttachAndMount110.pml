// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob//pkg/kubelet/volumemanager/reconciler/reconciler_test.go#L110
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_Run_Positive_VolumeAttachAndMount1100 = [1] of {int};
	run Test_Run_Positive_VolumeAttachAndMount110(child_Test_Run_Positive_VolumeAttachAndMount1100);
	run receiver(child_Test_Run_Positive_VolumeAttachAndMount1100)
stop_process:skip
}

proctype Test_Run_Positive_VolumeAttachAndMount110(chan child) {
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

proctype receiver(chan c) {
c?0
}

