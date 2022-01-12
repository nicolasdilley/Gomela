// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//gossip/election/adapter_test.go#L327
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestReportMetrics3270 = [1] of {int};
	run TestReportMetrics327(child_TestReportMetrics3270);
	run receiver(child_TestReportMetrics3270)
stop_process:skip
}

proctype TestReportMetrics327(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetArgsForCall914 = [1] of {int};
	chan child_WithArgsForCall1283 = [1] of {int};
	chan child_SetArgsForCall912 = [1] of {int};
	chan child_WithArgsForCall1281 = [1] of {int};
	chan child_NewAdapter800 = [1] of {int};
	Mutexdef mockGossip_clusterLock;
	Mutexdef mockGossip_acceptorLock;
	Mutexdef mockGossip_cluster_peersLock;
	Mutexdef testMetricProvider_FakeRetrieveDuration_invocationsMutex;
	Mutexdef testMetricProvider_FakeRetrieveDuration_withMutex;
	Mutexdef testMetricProvider_FakeRetrieveDuration_observeMutex;
	Mutexdef testMetricProvider_FakePullDuration_invocationsMutex;
	Mutexdef testMetricProvider_FakePullDuration_withMutex;
	Mutexdef testMetricProvider_FakePullDuration_observeMutex;
	Mutexdef testMetricProvider_FakeReconciliationDuration_invocationsMutex;
	Mutexdef testMetricProvider_FakeReconciliationDuration_withMutex;
	Mutexdef testMetricProvider_FakeReconciliationDuration_observeMutex;
	Mutexdef testMetricProvider_FakeSendDuration_invocationsMutex;
	Mutexdef testMetricProvider_FakeSendDuration_withMutex;
	Mutexdef testMetricProvider_FakeSendDuration_observeMutex;
	Mutexdef testMetricProvider_FakePurgeDuration_invocationsMutex;
	Mutexdef testMetricProvider_FakePurgeDuration_withMutex;
	Mutexdef testMetricProvider_FakePurgeDuration_observeMutex;
	Mutexdef testMetricProvider_FakeCommitPrivateDataDuration_invocationsMutex;
	Mutexdef testMetricProvider_FakeCommitPrivateDataDuration_withMutex;
	Mutexdef testMetricProvider_FakeCommitPrivateDataDuration_observeMutex;
	Mutexdef testMetricProvider_FakeFetchDuration_invocationsMutex;
	Mutexdef testMetricProvider_FakeFetchDuration_withMutex;
	Mutexdef testMetricProvider_FakeFetchDuration_observeMutex;
	Mutexdef testMetricProvider_FakeListMissingPrivateDataDuration_invocationsMutex;
	Mutexdef testMetricProvider_FakeListMissingPrivateDataDuration_withMutex;
	Mutexdef testMetricProvider_FakeListMissingPrivateDataDuration_observeMutex;
	Mutexdef testMetricProvider_FakeValidationDuration_invocationsMutex;
	Mutexdef testMetricProvider_FakeValidationDuration_withMutex;
	Mutexdef testMetricProvider_FakeValidationDuration_observeMutex;
	Mutexdef testMetricProvider_FakeTotalGauge_invocationsMutex;
	Mutexdef testMetricProvider_FakeTotalGauge_withMutex;
	Mutexdef testMetricProvider_FakeTotalGauge_setMutex;
	Mutexdef testMetricProvider_FakeTotalGauge_addMutex;
	Mutexdef testMetricProvider_FakeReceivedMessages_invocationsMutex;
	Mutexdef testMetricProvider_FakeReceivedMessages_withMutex;
	Mutexdef testMetricProvider_FakeReceivedMessages_addMutex;
	Mutexdef testMetricProvider_FakeBufferOverflow_invocationsMutex;
	Mutexdef testMetricProvider_FakeBufferOverflow_withMutex;
	Mutexdef testMetricProvider_FakeBufferOverflow_addMutex;
	Mutexdef testMetricProvider_FakeSentMessages_invocationsMutex;
	Mutexdef testMetricProvider_FakeSentMessages_withMutex;
	Mutexdef testMetricProvider_FakeSentMessages_addMutex;
	Mutexdef testMetricProvider_FakeDeclarationGauge_invocationsMutex;
	Mutexdef testMetricProvider_FakeDeclarationGauge_withMutex;
	Mutexdef testMetricProvider_FakeDeclarationGauge_setMutex;
	Mutexdef testMetricProvider_FakeDeclarationGauge_addMutex;
	Mutexdef testMetricProvider_FakePayloadBufferSizeGauge_invocationsMutex;
	Mutexdef testMetricProvider_FakePayloadBufferSizeGauge_withMutex;
	Mutexdef testMetricProvider_FakePayloadBufferSizeGauge_setMutex;
	Mutexdef testMetricProvider_FakePayloadBufferSizeGauge_addMutex;
	Mutexdef testMetricProvider_FakeCommitDurationHist_invocationsMutex;
	Mutexdef testMetricProvider_FakeCommitDurationHist_withMutex;
	Mutexdef testMetricProvider_FakeCommitDurationHist_observeMutex;
	Mutexdef testMetricProvider_FakeHeightGauge_invocationsMutex;
	Mutexdef testMetricProvider_FakeHeightGauge_withMutex;
	Mutexdef testMetricProvider_FakeHeightGauge_setMutex;
	Mutexdef testMetricProvider_FakeHeightGauge_addMutex;
	Mutexdef testMetricProvider_FakeProvider_invocationsMutex;
	Mutexdef testMetricProvider_FakeProvider_newHistogramMutex;
	Mutexdef testMetricProvider_FakeProvider_newGaugeMutex;
	Mutexdef testMetricProvider_FakeProvider_newCounterMutex;
	run mutexMonitor(testMetricProvider_FakeProvider_newCounterMutex);
	run mutexMonitor(testMetricProvider_FakeProvider_newGaugeMutex);
	run mutexMonitor(testMetricProvider_FakeProvider_newHistogramMutex);
	run mutexMonitor(testMetricProvider_FakeProvider_invocationsMutex);
	run mutexMonitor(testMetricProvider_FakeHeightGauge_addMutex);
	run mutexMonitor(testMetricProvider_FakeHeightGauge_setMutex);
	run mutexMonitor(testMetricProvider_FakeHeightGauge_withMutex);
	run mutexMonitor(testMetricProvider_FakeHeightGauge_invocationsMutex);
	run mutexMonitor(testMetricProvider_FakeCommitDurationHist_observeMutex);
	run mutexMonitor(testMetricProvider_FakeCommitDurationHist_withMutex);
	run mutexMonitor(testMetricProvider_FakeCommitDurationHist_invocationsMutex);
	run mutexMonitor(testMetricProvider_FakePayloadBufferSizeGauge_addMutex);
	run mutexMonitor(testMetricProvider_FakePayloadBufferSizeGauge_setMutex);
	run mutexMonitor(testMetricProvider_FakePayloadBufferSizeGauge_withMutex);
	run mutexMonitor(testMetricProvider_FakePayloadBufferSizeGauge_invocationsMutex);
	run mutexMonitor(testMetricProvider_FakeDeclarationGauge_addMutex);
	run mutexMonitor(testMetricProvider_FakeDeclarationGauge_setMutex);
	run mutexMonitor(testMetricProvider_FakeDeclarationGauge_withMutex);
	run mutexMonitor(testMetricProvider_FakeDeclarationGauge_invocationsMutex);
	run mutexMonitor(testMetricProvider_FakeSentMessages_addMutex);
	run mutexMonitor(testMetricProvider_FakeSentMessages_withMutex);
	run mutexMonitor(testMetricProvider_FakeSentMessages_invocationsMutex);
	run mutexMonitor(testMetricProvider_FakeBufferOverflow_addMutex);
	run mutexMonitor(testMetricProvider_FakeBufferOverflow_withMutex);
	run mutexMonitor(testMetricProvider_FakeBufferOverflow_invocationsMutex);
	run mutexMonitor(testMetricProvider_FakeReceivedMessages_addMutex);
	run mutexMonitor(testMetricProvider_FakeReceivedMessages_withMutex);
	run mutexMonitor(testMetricProvider_FakeReceivedMessages_invocationsMutex);
	run mutexMonitor(testMetricProvider_FakeTotalGauge_addMutex);
	run mutexMonitor(testMetricProvider_FakeTotalGauge_setMutex);
	run mutexMonitor(testMetricProvider_FakeTotalGauge_withMutex);
	run mutexMonitor(testMetricProvider_FakeTotalGauge_invocationsMutex);
	run mutexMonitor(testMetricProvider_FakeValidationDuration_observeMutex);
	run mutexMonitor(testMetricProvider_FakeValidationDuration_withMutex);
	run mutexMonitor(testMetricProvider_FakeValidationDuration_invocationsMutex);
	run mutexMonitor(testMetricProvider_FakeListMissingPrivateDataDuration_observeMutex);
	run mutexMonitor(testMetricProvider_FakeListMissingPrivateDataDuration_withMutex);
	run mutexMonitor(testMetricProvider_FakeListMissingPrivateDataDuration_invocationsMutex);
	run mutexMonitor(testMetricProvider_FakeFetchDuration_observeMutex);
	run mutexMonitor(testMetricProvider_FakeFetchDuration_withMutex);
	run mutexMonitor(testMetricProvider_FakeFetchDuration_invocationsMutex);
	run mutexMonitor(testMetricProvider_FakeCommitPrivateDataDuration_observeMutex);
	run mutexMonitor(testMetricProvider_FakeCommitPrivateDataDuration_withMutex);
	run mutexMonitor(testMetricProvider_FakeCommitPrivateDataDuration_invocationsMutex);
	run mutexMonitor(testMetricProvider_FakePurgeDuration_observeMutex);
	run mutexMonitor(testMetricProvider_FakePurgeDuration_withMutex);
	run mutexMonitor(testMetricProvider_FakePurgeDuration_invocationsMutex);
	run mutexMonitor(testMetricProvider_FakeSendDuration_observeMutex);
	run mutexMonitor(testMetricProvider_FakeSendDuration_withMutex);
	run mutexMonitor(testMetricProvider_FakeSendDuration_invocationsMutex);
	run mutexMonitor(testMetricProvider_FakeReconciliationDuration_observeMutex);
	run mutexMonitor(testMetricProvider_FakeReconciliationDuration_withMutex);
	run mutexMonitor(testMetricProvider_FakeReconciliationDuration_invocationsMutex);
	run mutexMonitor(testMetricProvider_FakePullDuration_observeMutex);
	run mutexMonitor(testMetricProvider_FakePullDuration_withMutex);
	run mutexMonitor(testMetricProvider_FakePullDuration_invocationsMutex);
	run mutexMonitor(testMetricProvider_FakeRetrieveDuration_observeMutex);
	run mutexMonitor(testMetricProvider_FakeRetrieveDuration_withMutex);
	run mutexMonitor(testMetricProvider_FakeRetrieveDuration_invocationsMutex);
	run mutexMonitor(mockGossip_cluster_peersLock);
	run mutexMonitor(mockGossip_acceptorLock);
	run mutexMonitor(mockGossip_clusterLock);
	run NewAdapter80(mockGossip_acceptorLock,mockGossip_cluster_peersLock,mockGossip_clusterLock,child_NewAdapter800);
	child_NewAdapter800?0;
	run WithArgsForCall128(testMetricProvider_FakeDeclarationGauge_addMutex,testMetricProvider_FakeDeclarationGauge_invocationsMutex,testMetricProvider_FakeDeclarationGauge_setMutex,testMetricProvider_FakeDeclarationGauge_withMutex,child_WithArgsForCall1281);
	child_WithArgsForCall1281?0;
	run SetArgsForCall91(testMetricProvider_FakeDeclarationGauge_addMutex,testMetricProvider_FakeDeclarationGauge_invocationsMutex,testMetricProvider_FakeDeclarationGauge_setMutex,testMetricProvider_FakeDeclarationGauge_withMutex,child_SetArgsForCall912);
	child_SetArgsForCall912?0;
	run WithArgsForCall128(testMetricProvider_FakeDeclarationGauge_addMutex,testMetricProvider_FakeDeclarationGauge_invocationsMutex,testMetricProvider_FakeDeclarationGauge_setMutex,testMetricProvider_FakeDeclarationGauge_withMutex,child_WithArgsForCall1283);
	child_WithArgsForCall1283?0;
	run SetArgsForCall91(testMetricProvider_FakeDeclarationGauge_addMutex,testMetricProvider_FakeDeclarationGauge_invocationsMutex,testMetricProvider_FakeDeclarationGauge_setMutex,testMetricProvider_FakeDeclarationGauge_withMutex,child_SetArgsForCall914);
	child_SetArgsForCall914?0;
	stop_process: skip;
	child!0
}
proctype NewAdapter80(Mutexdef gossip_acceptorLock;Mutexdef gossip_cluster_peersLock;Mutexdef gossip_clusterLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype WithArgsForCall128(Mutexdef fake_addMutex;Mutexdef fake_invocationsMutex;Mutexdef fake_setMutex;Mutexdef fake_withMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	fake_withMutex.RLock!false;
	goto defer1;
		defer1: skip;
	fake_withMutex.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype SetArgsForCall91(Mutexdef fake_addMutex;Mutexdef fake_invocationsMutex;Mutexdef fake_setMutex;Mutexdef fake_withMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	fake_setMutex.RLock!false;
	goto defer1;
		defer1: skip;
	fake_setMutex.RUnlock!false;
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

