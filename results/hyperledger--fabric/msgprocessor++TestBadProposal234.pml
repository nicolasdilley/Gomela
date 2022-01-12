// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//orderer/common/msgprocessor/systemchannelfilter_test.go#L234
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBadProposal2340 = [1] of {int};
	run TestBadProposal234(child_TestBadProposal2340);
	run receiver(child_TestBadProposal2340)
stop_process:skip
}

proctype TestBadProposal234(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewSystemChannelFilter430 = [1] of {int};
	Mutexdef mv_invocationsMutex;
	Mutexdef mv_validateConsensusMetadataMutex;
	Mutexdef mcc_ms_msc_invocationsMutex;
	Mutexdef mcc_ms_msc_organizationsMutex;
	Mutexdef mcc_ms_msc_maxChannelsCountMutex;
	Mutexdef mcc_ms_msc_kafkaBrokersMutex;
	Mutexdef mcc_ms_msc_consensusTypeMutex;
	Mutexdef mcc_ms_msc_consensusStateMutex;
	Mutexdef mcc_ms_msc_consensusMetadataMutex;
	Mutexdef mcc_ms_msc_capabilitiesMutex;
	Mutexdef mcc_ms_msc_batchTimeoutMutex;
	Mutexdef mcc_ms_msc_batchSizeMutex;
	run mutexMonitor(mcc_ms_msc_batchSizeMutex);
	run mutexMonitor(mcc_ms_msc_batchTimeoutMutex);
	run mutexMonitor(mcc_ms_msc_capabilitiesMutex);
	run mutexMonitor(mcc_ms_msc_consensusMetadataMutex);
	run mutexMonitor(mcc_ms_msc_consensusStateMutex);
	run mutexMonitor(mcc_ms_msc_consensusTypeMutex);
	run mutexMonitor(mcc_ms_msc_kafkaBrokersMutex);
	run mutexMonitor(mcc_ms_msc_maxChannelsCountMutex);
	run mutexMonitor(mcc_ms_msc_organizationsMutex);
	run mutexMonitor(mcc_ms_msc_invocationsMutex);
	run mutexMonitor(mv_validateConsensusMetadataMutex);
	run mutexMonitor(mv_invocationsMutex);
	run NewSystemChannelFilter43(mcc_ms_msc_batchSizeMutex,mcc_ms_msc_batchTimeoutMutex,mcc_ms_msc_capabilitiesMutex,mcc_ms_msc_consensusMetadataMutex,mcc_ms_msc_consensusStateMutex,mcc_ms_msc_consensusTypeMutex,mcc_ms_msc_invocationsMutex,mcc_ms_msc_kafkaBrokersMutex,mcc_ms_msc_maxChannelsCountMutex,mcc_ms_msc_organizationsMutex,mcc_ms_msc_batchSizeMutex,mcc_ms_msc_batchTimeoutMutex,mcc_ms_msc_capabilitiesMutex,mcc_ms_msc_consensusMetadataMutex,mcc_ms_msc_consensusStateMutex,mcc_ms_msc_consensusTypeMutex,mcc_ms_msc_invocationsMutex,mcc_ms_msc_kafkaBrokersMutex,mcc_ms_msc_maxChannelsCountMutex,mcc_ms_msc_organizationsMutex,mv_invocationsMutex,mv_validateConsensusMetadataMutex,child_NewSystemChannelFilter430);
	child_NewSystemChannelFilter430?0;
	stop_process: skip;
	child!0
}
proctype NewSystemChannelFilter43(Mutexdef ls_msc_batchSizeMutex;Mutexdef ls_msc_batchTimeoutMutex;Mutexdef ls_msc_capabilitiesMutex;Mutexdef ls_msc_consensusMetadataMutex;Mutexdef ls_msc_consensusStateMutex;Mutexdef ls_msc_consensusTypeMutex;Mutexdef ls_msc_invocationsMutex;Mutexdef ls_msc_kafkaBrokersMutex;Mutexdef ls_msc_maxChannelsCountMutex;Mutexdef ls_msc_organizationsMutex;Mutexdef cc_ms_msc_batchSizeMutex;Mutexdef cc_ms_msc_batchTimeoutMutex;Mutexdef cc_ms_msc_capabilitiesMutex;Mutexdef cc_ms_msc_consensusMetadataMutex;Mutexdef cc_ms_msc_consensusStateMutex;Mutexdef cc_ms_msc_consensusTypeMutex;Mutexdef cc_ms_msc_invocationsMutex;Mutexdef cc_ms_msc_kafkaBrokersMutex;Mutexdef cc_ms_msc_maxChannelsCountMutex;Mutexdef cc_ms_msc_organizationsMutex;Mutexdef validator_invocationsMutex;Mutexdef validator_validateConsensusMetadataMutex;chan child) {
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

