// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/volume/awsebs/aws_util.go#L76
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_CreateVolume760 = [1] of {int};
	run CreateVolume76(child_CreateVolume760);
	run receiver(child_CreateVolume760)
stop_process:skip
}

proctype CreateVolume76(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetVolumeLabels2782 = [1] of {int};
	chan child_CreateDisk2701 = [1] of {int};
	chan child_getCandidateZones1330 = [1] of {int};
	Mutexdef cloud_attachingMutex;
	Mutexdef cloud_instanceCache_mutex;
	int var_c_options_Parametersc_options_Parameters = -2; // opt var_c_options_Parametersc_options_Parameters
	run mutexMonitor(cloud_instanceCache_mutex);
	run mutexMonitor(cloud_attachingMutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run getCandidateZones133(cloud_attachingMutex,cloud_instanceCache_mutex,child_getCandidateZones1330);
	child_getCandidateZones1330?0;
	

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
		goto stop_process
	:: true;
	fi;
	run CreateDisk270(cloud_attachingMutex,cloud_instanceCache_mutex,child_CreateDisk2701);
	child_CreateDisk2701?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run GetVolumeLabels278(cloud_attachingMutex,cloud_instanceCache_mutex,child_GetVolumeLabels2782);
	child_GetVolumeLabels2782?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getCandidateZones133(Mutexdef cloud_attachingMutex;Mutexdef cloud_instanceCache_mutex;chan child) {
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
proctype CreateDisk270(Mutexdef testcase_attachingMutex;Mutexdef testcase_instanceCache_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetVolumeLabels278(Mutexdef testcase_attachingMutex;Mutexdef testcase_instanceCache_mutex;chan child) {
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

