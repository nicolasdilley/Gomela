
// https://github.com/syncthing/syncthing/blob/master/lib/api/api_test.go#L591
typedef Chandef {
	chan sync = [0] of {bool};
	chan enq = [0] of {int};
	chan deq = [0] of {bool,int};
	chan sending = [0] of {bool};
	chan rcving = [0] of {bool};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_startHTTP5910 = [1] of {int};
	run startHTTP591(child_startHTTP5910)
stop_process:skip
}

proctype startHTTP591(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef supervisor_m;
	Mutexdef supervisor_ctxMutex;
	chan child_New490 = [1] of {int};
	Mutexdef mockedSummary_invocationsMutex;
	Mutexdef mockedSummary_summaryMutex;
	Mutexdef mockedSummary_serveMutex;
	Mutexdef mockedSummary_onEventRequestMutex;
	Chandef addrChan;
	Mutexdef systemLog_invocationsMutex;
	Mutexdef systemLog_sinceMutex;
	Mutexdef systemLog_clearMutex;
	Mutexdef errorLog_invocationsMutex;
	Mutexdef errorLog_sinceMutex;
	Mutexdef errorLog_clearMutex;
	Mutexdef connections_invocationsMutex;
	Mutexdef connections_serveMutex;
	Mutexdef connections_nATTypeMutex;
	Mutexdef connections_listenerStatusMutex;
	Mutexdef connections_externalAddressesMutex;
	Mutexdef connections_connectionStatusMutex;
	Mutexdef connections_allAddressesMutex;
	Mutexdef discoverer_invocationsMutex;
	Mutexdef discoverer_stringMutex;
	Mutexdef discoverer_serveMutex;
	Mutexdef discoverer_lookupMutex;
	Mutexdef discoverer_errorMutex;
	Mutexdef discoverer_childErrorsMutex;
	Mutexdef discoverer_cacheMutex;
	Mutexdef diskEventSub_invocationsMutex;
	Mutexdef diskEventSub_sinceMutex;
	Mutexdef diskEventSub_maskMutex;
	Mutexdef eventSub_invocationsMutex;
	Mutexdef eventSub_sinceMutex;
	Mutexdef eventSub_maskMutex;
	Mutexdef m_invocationsMutex;
	Mutexdef m_watchErrorMutex;
	Mutexdef m_usageReportingStatsMutex;
	Mutexdef m_stateMutex;
	Mutexdef m_startDeadlockDetectorMutex;
	Mutexdef m_setIgnoresMutex;
	Mutexdef m_serveMutex;
	Mutexdef m_scanFoldersMutex;
	Mutexdef m_scanFolderSubdirsMutex;
	Mutexdef m_scanFolderMutex;
	Mutexdef m_revertMutex;
	Mutexdef m_restoreFolderVersionsMutex;
	Mutexdef m_resetFolderMutex;
	Mutexdef m_requestMutex;
	Mutexdef m_remoteNeedFolderFilesMutex;
	Mutexdef m_pendingFoldersMutex;
	Mutexdef m_pendingDevicesMutex;
	Mutexdef m_overrideMutex;
	Mutexdef m_onHelloMutex;
	Mutexdef m_numConnectionsMutex;
	Mutexdef m_needFolderFilesMutex;
	Mutexdef m_localChangedFolderFilesMutex;
	Mutexdef m_loadIgnoresMutex;
	Mutexdef m_indexUpdateMutex;
	Mutexdef m_indexMutex;
	Mutexdef m_globalDirectoryTreeMutex;
	Mutexdef m_getHelloMutex;
	Mutexdef m_getFolderVersionsMutex;
	Mutexdef m_folderStatisticsMutex;
	Mutexdef m_folderProgressBytesCompletedMutex;
	Mutexdef m_folderErrorsMutex;
	Mutexdef m_downloadProgressMutex;
	Mutexdef m_deviceStatisticsMutex;
	Mutexdef m_delayScanMutex;
	Mutexdef m_dBSnapshotMutex;
	Mutexdef m_currentIgnoresMutex;
	Mutexdef m_currentGlobalFileMutex;
	Mutexdef m_currentFolderFileMutex;
	Mutexdef m_connectionStatsMutex;
	Mutexdef m_connectionMutex;
	Mutexdef m_completionMutex;
	Mutexdef m_clusterConfigMutex;
	Mutexdef m_closedMutex;
	Mutexdef m_bringToFrontMutex;
	Mutexdef m_availabilityMutex;
	Mutexdef m_addConnectionMutex;
	run mutexMonitor(m_addConnectionMutex);
	run mutexMonitor(m_availabilityMutex);
	run mutexMonitor(m_bringToFrontMutex);
	run mutexMonitor(m_closedMutex);
	run mutexMonitor(m_clusterConfigMutex);
	run mutexMonitor(m_completionMutex);
	run mutexMonitor(m_connectionMutex);
	run mutexMonitor(m_connectionStatsMutex);
	run mutexMonitor(m_currentFolderFileMutex);
	run mutexMonitor(m_currentGlobalFileMutex);
	run mutexMonitor(m_currentIgnoresMutex);
	run mutexMonitor(m_dBSnapshotMutex);
	run mutexMonitor(m_delayScanMutex);
	run mutexMonitor(m_deviceStatisticsMutex);
	run mutexMonitor(m_downloadProgressMutex);
	run mutexMonitor(m_folderErrorsMutex);
	run mutexMonitor(m_folderProgressBytesCompletedMutex);
	run mutexMonitor(m_folderStatisticsMutex);
	run mutexMonitor(m_getFolderVersionsMutex);
	run mutexMonitor(m_getHelloMutex);
	run mutexMonitor(m_globalDirectoryTreeMutex);
	run mutexMonitor(m_indexMutex);
	run mutexMonitor(m_indexUpdateMutex);
	run mutexMonitor(m_loadIgnoresMutex);
	run mutexMonitor(m_localChangedFolderFilesMutex);
	run mutexMonitor(m_needFolderFilesMutex);
	run mutexMonitor(m_numConnectionsMutex);
	run mutexMonitor(m_onHelloMutex);
	run mutexMonitor(m_overrideMutex);
	run mutexMonitor(m_pendingDevicesMutex);
	run mutexMonitor(m_pendingFoldersMutex);
	run mutexMonitor(m_remoteNeedFolderFilesMutex);
	run mutexMonitor(m_requestMutex);
	run mutexMonitor(m_resetFolderMutex);
	run mutexMonitor(m_restoreFolderVersionsMutex);
	run mutexMonitor(m_revertMutex);
	run mutexMonitor(m_scanFolderMutex);
	run mutexMonitor(m_scanFolderSubdirsMutex);
	run mutexMonitor(m_scanFoldersMutex);
	run mutexMonitor(m_serveMutex);
	run mutexMonitor(m_setIgnoresMutex);
	run mutexMonitor(m_startDeadlockDetectorMutex);
	run mutexMonitor(m_stateMutex);
	run mutexMonitor(m_usageReportingStatsMutex);
	run mutexMonitor(m_watchErrorMutex);
	run mutexMonitor(m_invocationsMutex);
	run mutexMonitor(eventSub_maskMutex);
	run mutexMonitor(eventSub_sinceMutex);
	run mutexMonitor(eventSub_invocationsMutex);
	run mutexMonitor(diskEventSub_maskMutex);
	run mutexMonitor(diskEventSub_sinceMutex);
	run mutexMonitor(diskEventSub_invocationsMutex);
	run mutexMonitor(discoverer_cacheMutex);
	run mutexMonitor(discoverer_childErrorsMutex);
	run mutexMonitor(discoverer_errorMutex);
	run mutexMonitor(discoverer_lookupMutex);
	run mutexMonitor(discoverer_serveMutex);
	run mutexMonitor(discoverer_stringMutex);
	run mutexMonitor(discoverer_invocationsMutex);
	run mutexMonitor(connections_allAddressesMutex);
	run mutexMonitor(connections_connectionStatusMutex);
	run mutexMonitor(connections_externalAddressesMutex);
	run mutexMonitor(connections_listenerStatusMutex);
	run mutexMonitor(connections_nATTypeMutex);
	run mutexMonitor(connections_serveMutex);
	run mutexMonitor(connections_invocationsMutex);
	run mutexMonitor(errorLog_clearMutex);
	run mutexMonitor(errorLog_sinceMutex);
	run mutexMonitor(errorLog_invocationsMutex);
	run mutexMonitor(systemLog_clearMutex);
	run mutexMonitor(systemLog_sinceMutex);
	run mutexMonitor(systemLog_invocationsMutex);
	run sync_monitor(addrChan);
	run mutexMonitor(mockedSummary_onEventRequestMutex);
	run mutexMonitor(mockedSummary_serveMutex);
	run mutexMonitor(mockedSummary_summaryMutex);
	run mutexMonitor(mockedSummary_invocationsMutex);
	run New49(m_addConnectionMutex,m_availabilityMutex,m_bringToFrontMutex,m_closedMutex,m_clusterConfigMutex,m_completionMutex,m_connectionMutex,m_connectionStatsMutex,m_currentFolderFileMutex,m_currentGlobalFileMutex,m_currentIgnoresMutex,m_dBSnapshotMutex,m_delayScanMutex,m_deviceStatisticsMutex,m_downloadProgressMutex,m_folderErrorsMutex,m_folderProgressBytesCompletedMutex,m_folderStatisticsMutex,m_getFolderVersionsMutex,m_getHelloMutex,m_globalDirectoryTreeMutex,m_indexMutex,m_indexUpdateMutex,m_loadIgnoresMutex,m_localChangedFolderFilesMutex,m_needFolderFilesMutex,m_numConnectionsMutex,m_onHelloMutex,m_overrideMutex,m_pendingDevicesMutex,m_pendingFoldersMutex,m_remoteNeedFolderFilesMutex,m_requestMutex,m_resetFolderMutex,m_restoreFolderVersionsMutex,m_revertMutex,m_scanFolderMutex,m_scanFolderSubdirsMutex,m_scanFoldersMutex,m_serveMutex,m_setIgnoresMutex,m_startDeadlockDetectorMutex,m_stateMutex,m_usageReportingStatsMutex,m_watchErrorMutex,m_invocationsMutex,connections_allAddressesMutex,connections_connectionStatusMutex,connections_externalAddressesMutex,connections_listenerStatusMutex,connections_nATTypeMutex,connections_serveMutex,connections_invocationsMutex,child_New490);
	child_New490?0;
	run mutexMonitor(supervisor_ctxMutex);
	run mutexMonitor(supervisor_m);
	

	if
	:: addrChan.deq?state,num_msgs;
	:: addrChan.sync?state -> 
		addrChan.rcving!false
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
proctype New49(Mutexdef m_addConnectionMutex;Mutexdef m_availabilityMutex;Mutexdef m_bringToFrontMutex;Mutexdef m_closedMutex;Mutexdef m_clusterConfigMutex;Mutexdef m_completionMutex;Mutexdef m_connectionMutex;Mutexdef m_connectionStatsMutex;Mutexdef m_currentFolderFileMutex;Mutexdef m_currentGlobalFileMutex;Mutexdef m_currentIgnoresMutex;Mutexdef m_dBSnapshotMutex;Mutexdef m_delayScanMutex;Mutexdef m_deviceStatisticsMutex;Mutexdef m_downloadProgressMutex;Mutexdef m_folderErrorsMutex;Mutexdef m_folderProgressBytesCompletedMutex;Mutexdef m_folderStatisticsMutex;Mutexdef m_getFolderVersionsMutex;Mutexdef m_getHelloMutex;Mutexdef m_globalDirectoryTreeMutex;Mutexdef m_indexMutex;Mutexdef m_indexUpdateMutex;Mutexdef m_loadIgnoresMutex;Mutexdef m_localChangedFolderFilesMutex;Mutexdef m_needFolderFilesMutex;Mutexdef m_numConnectionsMutex;Mutexdef m_onHelloMutex;Mutexdef m_overrideMutex;Mutexdef m_pendingDevicesMutex;Mutexdef m_pendingFoldersMutex;Mutexdef m_remoteNeedFolderFilesMutex;Mutexdef m_requestMutex;Mutexdef m_resetFolderMutex;Mutexdef m_restoreFolderVersionsMutex;Mutexdef m_revertMutex;Mutexdef m_scanFolderMutex;Mutexdef m_scanFolderSubdirsMutex;Mutexdef m_scanFoldersMutex;Mutexdef m_serveMutex;Mutexdef m_setIgnoresMutex;Mutexdef m_startDeadlockDetectorMutex;Mutexdef m_stateMutex;Mutexdef m_usageReportingStatsMutex;Mutexdef m_watchErrorMutex;Mutexdef m_invocationsMutex;Mutexdef connectionsService_allAddressesMutex;Mutexdef connectionsService_connectionStatusMutex;Mutexdef connectionsService_externalAddressesMutex;Mutexdef connectionsService_listenerStatusMutex;Mutexdef connectionsService_nATTypeMutex;Mutexdef connectionsService_serveMutex;Mutexdef connectionsService_invocationsMutex;chan child) {
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
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.rcving?false;
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.sync!true -> 
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.deq!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		    ch.closed = true
		   :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.enq?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.rcving?false ->
 		    ch.sending?false;
		fi;
		:: else -> 
		end3: if
		  :: ch.enq?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.deq!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		     ch.closed = true
		  :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.rcving?false;
  :: ch.sync!true; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.rcving?false ->
       ch.sending?false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

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

