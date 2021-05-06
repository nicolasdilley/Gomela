
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/images/image_gc_manager_test.go#L181
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDeleteUnusedImagesExemptSandboxImage1810 = [1] of {int};
	run TestDeleteUnusedImagesExemptSandboxImage181(child_TestDeleteUnusedImagesExemptSandboxImage1810)
stop_process:skip
}

proctype TestDeleteUnusedImagesExemptSandboxImage181(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DeleteUnusedImages3200 = [1] of {int};
	Mutexdef fakeRuntime_T_context_mu;
	Mutexdef fakeRuntime_T_context_match_mu;
	Mutexdef manager_imageRecordsLock;
	run mutexMonitor(manager_imageRecordsLock);
	run mutexMonitor(fakeRuntime_T_context_match_mu);
	run mutexMonitor(fakeRuntime_T_context_mu);
	run DeleteUnusedImages320(manager_imageRecordsLock,child_DeleteUnusedImages3200);
	child_DeleteUnusedImages3200?0;
	stop_process: skip;
	child!0
}
proctype DeleteUnusedImages320(Mutexdef im_imageRecordsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_freeSpace3320 = [1] of {int};
	run freeSpace332(im_imageRecordsLock,child_freeSpace3320);
	child_freeSpace3320?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype freeSpace332(Mutexdef im_imageRecordsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_detectImages2090 = [1] of {int};
	run detectImages209(im_imageRecordsLock,child_detectImages2090);
	child_detectImages2090?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	im_imageRecordsLock.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		im_imageRecordsLock.Unlock!false;
	child!0
}
proctype detectImages209(Mutexdef im_imageRecordsLock;chan child) {
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
	im_imageRecordsLock.Lock!false;
	goto stop_process;
	stop_process: skip;
		im_imageRecordsLock.Unlock!false;
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

