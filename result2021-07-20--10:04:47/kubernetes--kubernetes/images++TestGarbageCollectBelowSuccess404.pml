// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/kubelet/images/image_gc_manager_test.go#L404
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGarbageCollectBelowSuccess4040 = [1] of {int};
	run TestGarbageCollectBelowSuccess404(child_TestGarbageCollectBelowSuccess4040);
	run receiver(child_TestGarbageCollectBelowSuccess4040)
stop_process:skip
}

proctype TestGarbageCollectBelowSuccess404(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GarbageCollect2730 = [1] of {int};
	Mutexdef manager_imageRecordsLock;
	run mutexMonitor(manager_imageRecordsLock);
	run GarbageCollect273(manager_imageRecordsLock,child_GarbageCollect2730);
	child_GarbageCollect2730?0;
	stop_process: skip;
	child!0
}
proctype GarbageCollect273(Mutexdef im_imageRecordsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_freeSpace3320 = [1] of {int};
	

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
		run freeSpace332(im_imageRecordsLock,child_freeSpace3320);
		child_freeSpace3320?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

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
proctype freeSpace332(Mutexdef im_imageRecordsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_detectImages2090 = [1] of {int};
	int var_imagesimages = -2; // opt var_imagesimages
	int var_im_imageRecordsim_imageRecords = -2; // opt var_im_imageRecordsim_imageRecords
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
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	im_imageRecordsLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype detectImages209(Mutexdef im_imageRecordsLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_im_imageRecordsim_imageRecords = -2; // opt var_im_imageRecordsim_imageRecords
	int var_imagesimages = -2; // opt var_imagesimages
	int var_pod_Containerspod_Containers = -2; // opt var_pod_Containerspod_Containers
	int var_podspods = -2; // opt var_podspods
	

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
	goto defer1;
		defer1: skip;
	im_imageRecordsLock.Unlock!false;
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

