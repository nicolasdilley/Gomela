
// https://github.com/syncthing/syncthing/blob/master/lib/api/api_test.go#L1099
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEventMasks10990 = [1] of {int};
	run TestEventMasks1099(child_TestEventMasks10990)
stop_process:skip
}

proctype TestEventMasks1099(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_New1030 = [1] of {int};
	Mutexdef diskSub_invocationsMutex;
	Mutexdef diskSub_sinceMutex;
	Mutexdef diskSub_maskMutex;
	Mutexdef defSub_invocationsMutex;
	Mutexdef defSub_sinceMutex;
	Mutexdef defSub_maskMutex;
	Mutexdef cfg_invocationsMutex;
	Mutexdef cfg_unsubscribeMutex;
	Mutexdef cfg_subscribeMutex;
	Mutexdef cfg_serveMutex;
	Mutexdef cfg_saveMutex;
	Mutexdef cfg_requiresRestartMutex;
	Mutexdef cfg_removeFolderMutex;
	Mutexdef cfg_removeDeviceMutex;
	Mutexdef cfg_rawCopyMutex;
	Mutexdef cfg_optionsMutex;
	Mutexdef cfg_myIDMutex;
	Mutexdef cfg_modifyMutex;
	Mutexdef cfg_lDAPMutex;
	Mutexdef cfg_ignoredFolderMutex;
	Mutexdef cfg_ignoredDevicesMutex;
	Mutexdef cfg_ignoredDeviceMutex;
	Mutexdef cfg_gUIMutex;
	Mutexdef cfg_foldersMutex;
	Mutexdef cfg_folderPasswordsMutex;
	Mutexdef cfg_folderListMutex;
	Mutexdef cfg_folderMutex;
	Mutexdef cfg_devicesMutex;
	Mutexdef cfg_deviceListMutex;
	Mutexdef cfg_deviceMutex;
	Mutexdef cfg_defaultFolderMutex;
	Mutexdef cfg_defaultDeviceMutex;
	Mutexdef cfg_configPathMutex;
	run mutexMonitor(cfg_configPathMutex);
	run mutexMonitor(cfg_defaultDeviceMutex);
	run mutexMonitor(cfg_defaultFolderMutex);
	run mutexMonitor(cfg_deviceMutex);
	run mutexMonitor(cfg_deviceListMutex);
	run mutexMonitor(cfg_devicesMutex);
	run mutexMonitor(cfg_folderMutex);
	run mutexMonitor(cfg_folderListMutex);
	run mutexMonitor(cfg_folderPasswordsMutex);
	run mutexMonitor(cfg_foldersMutex);
	run mutexMonitor(cfg_gUIMutex);
	run mutexMonitor(cfg_ignoredDeviceMutex);
	run mutexMonitor(cfg_ignoredDevicesMutex);
	run mutexMonitor(cfg_ignoredFolderMutex);
	run mutexMonitor(cfg_lDAPMutex);
	run mutexMonitor(cfg_modifyMutex);
	run mutexMonitor(cfg_myIDMutex);
	run mutexMonitor(cfg_optionsMutex);
	run mutexMonitor(cfg_rawCopyMutex);
	run mutexMonitor(cfg_removeDeviceMutex);
	run mutexMonitor(cfg_removeFolderMutex);
	run mutexMonitor(cfg_requiresRestartMutex);
	run mutexMonitor(cfg_saveMutex);
	run mutexMonitor(cfg_serveMutex);
	run mutexMonitor(cfg_subscribeMutex);
	run mutexMonitor(cfg_unsubscribeMutex);
	run mutexMonitor(cfg_invocationsMutex);
	run mutexMonitor(defSub_maskMutex);
	run mutexMonitor(defSub_sinceMutex);
	run mutexMonitor(defSub_invocationsMutex);
	run mutexMonitor(diskSub_maskMutex);
	run mutexMonitor(diskSub_sinceMutex);
	run mutexMonitor(diskSub_invocationsMutex);
	run New103(cfg_configPathMutex,cfg_defaultDeviceMutex,cfg_defaultFolderMutex,cfg_deviceMutex,cfg_deviceListMutex,cfg_devicesMutex,cfg_folderMutex,cfg_folderListMutex,cfg_folderPasswordsMutex,cfg_foldersMutex,cfg_gUIMutex,cfg_ignoredDeviceMutex,cfg_ignoredDevicesMutex,cfg_ignoredFolderMutex,cfg_lDAPMutex,cfg_modifyMutex,cfg_myIDMutex,cfg_optionsMutex,cfg_rawCopyMutex,cfg_removeDeviceMutex,cfg_removeFolderMutex,cfg_requiresRestartMutex,cfg_saveMutex,cfg_serveMutex,cfg_subscribeMutex,cfg_unsubscribeMutex,cfg_invocationsMutex,defSub_maskMutex,defSub_sinceMutex,defSub_invocationsMutex,defSub_maskMutex,defSub_sinceMutex,defSub_invocationsMutex,child_New1030);
	child_New1030?0;
	stop_process: skip;
	child!0
}
proctype New103(Mutexdef cfg_configPathMutex;Mutexdef cfg_defaultDeviceMutex;Mutexdef cfg_defaultFolderMutex;Mutexdef cfg_deviceMutex;Mutexdef cfg_deviceListMutex;Mutexdef cfg_devicesMutex;Mutexdef cfg_folderMutex;Mutexdef cfg_folderListMutex;Mutexdef cfg_folderPasswordsMutex;Mutexdef cfg_foldersMutex;Mutexdef cfg_gUIMutex;Mutexdef cfg_ignoredDeviceMutex;Mutexdef cfg_ignoredDevicesMutex;Mutexdef cfg_ignoredFolderMutex;Mutexdef cfg_lDAPMutex;Mutexdef cfg_modifyMutex;Mutexdef cfg_myIDMutex;Mutexdef cfg_optionsMutex;Mutexdef cfg_rawCopyMutex;Mutexdef cfg_removeDeviceMutex;Mutexdef cfg_removeFolderMutex;Mutexdef cfg_requiresRestartMutex;Mutexdef cfg_saveMutex;Mutexdef cfg_serveMutex;Mutexdef cfg_subscribeMutex;Mutexdef cfg_unsubscribeMutex;Mutexdef cfg_invocationsMutex;Mutexdef defaultSub_maskMutex;Mutexdef defaultSub_sinceMutex;Mutexdef defaultSub_invocationsMutex;Mutexdef diskSub_maskMutex;Mutexdef diskSub_sinceMutex;Mutexdef diskSub_invocationsMutex;chan child) {
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

