
// https://github.com/kubernetes/kubernetes/blob/master/pkg/kubelet/volumemanager/populator/desired_state_of_world_populator_test.go#L481
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEphemeralVolumeOwnerCheck4810 = [1] of {int};
	run TestEphemeralVolumeOwnerCheck481(child_TestEphemeralVolumeOwnerCheck4810)
stop_process:skip
}

proctype TestEphemeralVolumeOwnerCheck481(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_findAndAddNewPods1900 = [1] of {int};
	Mutexdef __T_context_mu;
	Mutexdef __T_context_match_mu;
	Mutexdef dswp_volumePluginMgr_mutex;
	Mutexdef dswp_hasAddedPodsLock;
	run mutexMonitor(dswp_hasAddedPodsLock);
	run mutexMonitor(dswp_volumePluginMgr_mutex);
	run mutexMonitor(__T_context_match_mu);
	run mutexMonitor(__T_context_mu);
	run findAndAddNewPods190(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_findAndAddNewPods1900);
	child_findAndAddNewPods1900?0;
	stop_process: skip;
	child!0
}
proctype findAndAddNewPods190(Mutexdef dswp_hasAddedPodsLock;Mutexdef dswp_volumePluginMgr_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_processPodVolumes3071 = [1] of {int};
	chan child_isPodTerminated1800 = [1] of {int};
	chan child_processPodVolumes3073 = [1] of {int};
	chan child_isPodTerminated1802 = [1] of {int};
	int dswp_podManager_GetPods__ = -2;
	

	if
	:: dswp_podManager_GetPods__-1 != -3 -> 
				for(i : 0.. dswp_podManager_GetPods__-1) {
			for20: skip;
			run isPodTerminated180(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_isPodTerminated1800);
			child_isPodTerminated1800?0;
			

			if
			:: true -> 
				goto for20_end
			:: true;
			fi;
			run processPodVolumes307(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_processPodVolumes3071);
			child_processPodVolumes3071?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for23: skip;
			run isPodTerminated180(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_isPodTerminated1802);
			child_isPodTerminated1802?0;
			

			if
			:: true -> 
				goto for23_end
			:: true;
			fi;
			run processPodVolumes307(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_processPodVolumes3073);
			child_processPodVolumes3073?0;
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
	chan child_markPodProcessed4736 = [1] of {int};
	chan child_markPodProcessed4738 = [1] of {int};
	chan child_podHasBeenSeenOnce4637 = [1] of {int};
	chan child_checkVolumeFSResize3833 = [1] of {int};
	chan child_createVolumeSpec4932 = [1] of {int};
	chan child_checkVolumeFSResize3835 = [1] of {int};
	chan child_createVolumeSpec4934 = [1] of {int};
	chan child_podPreviouslyProcessed4451 = [1] of {int};
	int pod_Spec_Volumes = -2;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run podPreviouslyProcessed445(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_podPreviouslyProcessed4451);
	child_podPreviouslyProcessed4451?0;
	

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
			run createVolumeSpec493(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_createVolumeSpec4932);
			child_createVolumeSpec4932?0;
			

			if
			:: true -> 
				goto for21_end
			:: true;
			fi;
			

			if
			:: true -> 
				run checkVolumeFSResize383(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_checkVolumeFSResize3833);
				child_checkVolumeFSResize3833?0
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
			run createVolumeSpec493(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_createVolumeSpec4934);
			child_createVolumeSpec4934?0;
			

			if
			:: true -> 
				goto for22_end
			:: true;
			fi;
			

			if
			:: true -> 
				run checkVolumeFSResize383(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_checkVolumeFSResize3835);
				child_checkVolumeFSResize3835?0
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
		run markPodProcessed473(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_markPodProcessed4736);
		child_markPodProcessed4736?0
	:: true -> 
		run podHasBeenSeenOnce463(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_podHasBeenSeenOnce4637);
		child_podHasBeenSeenOnce4637?0;
		

		if
		:: true -> 
			run markPodProcessed473(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_markPodProcessed4738);
			child_markPodProcessed4738?0
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
	chan child_getPVSpec6453 = [1] of {int};
	chan child_getPVCExtractPV6102 = [1] of {int};
	

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
		run getPVCExtractPV610(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_getPVCExtractPV6102);
		child_getPVCExtractPV6102?0;
		

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
		run getPVSpec645(dswp_hasAddedPodsLock,dswp_volumePluginMgr_mutex,child_getPVSpec6453);
		child_getPVSpec6453?0;
		

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

