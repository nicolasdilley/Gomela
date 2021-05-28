// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/volume/awsebs/aws_util.go#L53
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_DeleteVolume530 = [1] of {int};
	run DeleteVolume53(child_DeleteVolume530);
	run receiver(child_DeleteVolume530)
stop_process:skip
}

proctype DeleteVolume53(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DeleteDisk2740 = [1] of {int};
	Mutexdef cloud_attachingMutex;
	Mutexdef cloud_instanceCache_mutex;
	run mutexMonitor(cloud_instanceCache_mutex);
	run mutexMonitor(cloud_attachingMutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run DeleteDisk274(cloud_attachingMutex,cloud_instanceCache_mutex,child_DeleteDisk2740);
	child_DeleteDisk2740?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DeleteDisk274(Mutexdef testcase_attachingMutex;Mutexdef testcase_instanceCache_mutex;chan child) {
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

