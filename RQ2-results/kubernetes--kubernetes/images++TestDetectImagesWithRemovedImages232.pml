
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/images/image_gc_manager_test.go#L232
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDetectImagesWithRemovedImages2320 = [1] of {int};
	run TestDetectImagesWithRemovedImages232(child_TestDetectImagesWithRemovedImages2320)
stop_process:skip
}

proctype TestDetectImagesWithRemovedImages232(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_imageRecordsLen523 = [1] of {int};
	chan child_detectImages2092 = [1] of {int};
	chan child_imageRecordsLen521 = [1] of {int};
	chan child_detectImages2090 = [1] of {int};
	Mutexdef fakeRuntime_T_context_mu;
	Mutexdef fakeRuntime_T_context_match_mu;
	Mutexdef manager_imageRecordsLock;
	run mutexMonitor(manager_imageRecordsLock);
	run mutexMonitor(fakeRuntime_T_context_match_mu);
	run mutexMonitor(fakeRuntime_T_context_mu);
	run detectImages209(manager_imageRecordsLock,child_detectImages2090);
	child_detectImages2090?0;
	run imageRecordsLen52(manager_imageRecordsLock,child_imageRecordsLen521);
	child_imageRecordsLen521?0;
	run detectImages209(manager_imageRecordsLock,child_detectImages2092);
	child_detectImages2092?0;
	run imageRecordsLen52(manager_imageRecordsLock,child_imageRecordsLen523);
	child_imageRecordsLen523?0;
	stop_process: skip;
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
proctype imageRecordsLen52(Mutexdef im_imageRecordsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

