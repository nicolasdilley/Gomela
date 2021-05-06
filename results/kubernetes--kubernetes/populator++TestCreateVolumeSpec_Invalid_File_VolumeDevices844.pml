
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/volumemanager/populator/desired_state_of_world_populator_test.go#L844
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCreateVolumeSpec_Invalid_File_VolumeDevices8440 = [1] of {int};
	run TestCreateVolumeSpec_Invalid_File_VolumeDevices844(child_TestCreateVolumeSpec_Invalid_File_VolumeDevices8440)
stop_process:skip
}

proctype TestCreateVolumeSpec_Invalid_File_VolumeDevices844(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_createVolumeSpec4930 = [1] of {int};
	Mutexdef __T_context_mu;
	Mutexdef __T_context_match_mu;
	Mutexdef dswp_volumePluginMgr_mutex;
	Mutexdef dswp_hasAddedPodsLock;
	run mutexMonitor(dswp_hasAddedPodsLock);
	run mutexMonitor(dswp_volumePluginMgr_mutex);
	run mutexMonitor(__T_context_match_mu);
	run mutexMonitor(__T_context_mu);
	run createVolumeSpec493(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_createVolumeSpec4930);
	child_createVolumeSpec4930?0;
	stop_process: skip;
	child!0
}
proctype createVolumeSpec493(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getPVSpec6451 = [1] of {int};
	chan child_getPVCExtractPV6100 = [1] of {int};
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		run getPVCExtractPV610(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_getPVCExtractPV6100);
		child_getPVCExtractPV6100?0;
		

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
		run getPVSpec645(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_getPVSpec6451);
		child_getPVSpec6451?0;
		

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
			fi
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
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getPVCExtractPV610(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getPVSpec645(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
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

