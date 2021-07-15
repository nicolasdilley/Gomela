
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/volumemanager/populator/desired_state_of_world_populator_test.go#L125
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFindAndAddNewPods_WithVolumeRetrievalError1250 = [1] of {int};
	run TestFindAndAddNewPods_WithVolumeRetrievalError125(child_TestFindAndAddNewPods_WithVolumeRetrievalError1250)
stop_process:skip
}

proctype TestFindAndAddNewPods_WithVolumeRetrievalError125(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_podHasBeenSeenOnce4633 = [1] of {int};
	chan child_podPreviouslyProcessed4452 = [1] of {int};
	chan child_findAndAddNewPods1901 = [1] of {int};
	chan child_pluginPVOmittingClient530 = [1] of {int};
	Mutexdef dswp_volumePluginMgr_mutex;
	Mutexdef dswp_hasAddedPodsLock;
	run mutexMonitor(dswp_hasAddedPodsLock);
	run mutexMonitor(dswp_volumePluginMgr_mutex);
	run pluginPVOmittingClient53(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_pluginPVOmittingClient530);
	child_pluginPVOmittingClient530?0;
	run findAndAddNewPods190(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_findAndAddNewPods1901);
	child_findAndAddNewPods1901?0;
	run podPreviouslyProcessed445(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_podPreviouslyProcessed4452);
	child_podPreviouslyProcessed4452?0;
	run podHasBeenSeenOnce463(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_podHasBeenSeenOnce4633);
	child_podHasBeenSeenOnce4633?0;
	stop_process: skip;
	child!0
}
proctype pluginPVOmittingClient53(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype findAndAddNewPods190(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_processPodVolumes3072 = [1] of {int};
	chan child_isPodTerminated1801 = [1] of {int};
	chan child_processPodVolumes3074 = [1] of {int};
	chan child_isPodTerminated1803 = [1] of {int};
	int dswp_podManager_GetPods__ = -2;
	

	if
	:: dswp_podManager_GetPods__-1 != -3 -> 
				for(i : 0.. dswp_podManager_GetPods__-1) {
			for20: skip;
			run isPodTerminated180(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_isPodTerminated1801);
			child_isPodTerminated1801?0;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			run processPodVolumes307(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_processPodVolumes3072);
			child_processPodVolumes3072?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for23: skip;
			run isPodTerminated180(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_isPodTerminated1803);
			child_isPodTerminated1803?0;
			

			if
			:: true -> 
				goto for23_end
			:: true;
			fi;
			run processPodVolumes307(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_processPodVolumes3074);
			child_processPodVolumes3074?0;
			for23_end: skip
		:: true -> 
			break
		od;
		for23_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype isPodTerminated180(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype processPodVolumes307(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_markPodProcessed4737 = [1] of {int};
	chan child_markPodProcessed4739 = [1] of {int};
	chan child_podHasBeenSeenOnce4638 = [1] of {int};
	chan child_checkVolumeFSResize3834 = [1] of {int};
	chan child_createVolumeSpec4933 = [1] of {int};
	chan child_checkVolumeFSResize3836 = [1] of {int};
	chan child_createVolumeSpec4935 = [1] of {int};
	chan child_podPreviouslyProcessed4452 = [1] of {int};
	int pod_Spec_Volumes = -2;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run podPreviouslyProcessed445(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_podPreviouslyProcessed4452);
	child_podPreviouslyProcessed4452?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: pod_Spec_Volumes-1 != -3 -> 
				for(i : 0.. pod_Spec_Volumes-1) {
			for21: skip;
			

			if
			:: true -> 
				goto for21_end
			:: true;
			fi;
			run createVolumeSpec493(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_createVolumeSpec4933);
			child_createVolumeSpec4933?0;
			

			if
			:: true -> 
				goto for21_end
			:: true;
			fi;
			

			if
			:: true -> 
				run checkVolumeFSResize383(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_checkVolumeFSResize3834);
				child_checkVolumeFSResize3834?0
			:: true;
			fi;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for22: skip;
			

			if
			:: true -> 
				goto for22_end
			:: true;
			fi;
			run createVolumeSpec493(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_createVolumeSpec4935);
			child_createVolumeSpec4935?0;
			

			if
			:: true -> 
				goto for22_end
			:: true;
			fi;
			

			if
			:: true -> 
				run checkVolumeFSResize383(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_checkVolumeFSResize3836);
				child_checkVolumeFSResize3836?0
			:: true;
			fi;
			for22_end: skip
		:: true -> 
			break
		od;
		for22_exit: skip
	fi;
	

	if
	:: true -> 
		run markPodProcessed473(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_markPodProcessed4737);
		child_markPodProcessed4737?0
	:: true -> 
		run podHasBeenSeenOnce463(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_podHasBeenSeenOnce4638);
		child_podHasBeenSeenOnce4638?0;
		

		if
		:: true -> 
			run markPodProcessed473(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_markPodProcessed4739);
			child_markPodProcessed4739?0
		:: true;
		fi
	fi;
	stop_process: skip;
	child!0
}
proctype podPreviouslyProcessed445(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype createVolumeSpec493(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getPVSpec6454 = [1] of {int};
	chan child_getPVCExtractPV6103 = [1] of {int};
	

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
		run getPVCExtractPV610(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_getPVCExtractPV6103);
		child_getPVCExtractPV6103?0;
		

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
		run getPVSpec645(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_getPVSpec6454);
		child_getPVSpec6454?0;
		

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
proctype checkVolumeFSResize383(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype markPodProcessed473(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype podHasBeenSeenOnce463(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
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

