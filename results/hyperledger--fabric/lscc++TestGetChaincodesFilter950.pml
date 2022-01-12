// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/scc/lscc/lscc_test.go#L950
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetChaincodesFilter9500 = [1] of {int};
	run TestGetChaincodesFilter950(child_TestGetChaincodesFilter9500);
	run receiver(child_TestGetChaincodesFilter9500)
stop_process:skip
}

proctype TestGetChaincodesFilter950(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getChaincodes5580 = [1] of {int};
	Mutexdef stub_invocationsMutex;
	Mutexdef stub_splitCompositeKeyMutex;
	Mutexdef stub_setStateValidationParameterMutex;
	Mutexdef stub_setPrivateDataValidationParameterMutex;
	Mutexdef stub_setEventMutex;
	Mutexdef stub_putStateMutex;
	Mutexdef stub_putPrivateDataMutex;
	Mutexdef stub_invokeChaincodeMutex;
	Mutexdef stub_getTxTimestampMutex;
	Mutexdef stub_getTxIDMutex;
	Mutexdef stub_getTransientMutex;
	Mutexdef stub_getStringArgsMutex;
	Mutexdef stub_getStateValidationParameterMutex;
	Mutexdef stub_getStateByRangeWithPaginationMutex;
	Mutexdef stub_getStateByRangeMutex;
	Mutexdef stub_getStateByPartialCompositeKeyWithPaginationMutex;
	Mutexdef stub_getStateByPartialCompositeKeyMutex;
	Mutexdef stub_getStateMutex;
	Mutexdef stub_getSignedProposalMutex;
	Mutexdef stub_getQueryResultWithPaginationMutex;
	Mutexdef stub_getQueryResultMutex;
	Mutexdef stub_getPrivateDataValidationParameterMutex;
	Mutexdef stub_getPrivateDataQueryResultMutex;
	Mutexdef stub_getPrivateDataHashMutex;
	Mutexdef stub_getPrivateDataByRangeMutex;
	Mutexdef stub_getPrivateDataByPartialCompositeKeyMutex;
	Mutexdef stub_getPrivateDataMutex;
	Mutexdef stub_getHistoryForKeyMutex;
	Mutexdef stub_getFunctionAndParametersMutex;
	Mutexdef stub_getDecorationsMutex;
	Mutexdef stub_getCreatorMutex;
	Mutexdef stub_getChannelIDMutex;
	Mutexdef stub_getBindingMutex;
	Mutexdef stub_getArgsSliceMutex;
	Mutexdef stub_getArgsMutex;
	Mutexdef stub_delStateMutex;
	Mutexdef stub_delPrivateDataMutex;
	Mutexdef stub_createCompositeKeyMutex;
	Mutexdef sqi_invocationsMutex;
	Mutexdef sqi_nextMutex;
	Mutexdef sqi_hasNextMutex;
	Mutexdef sqi_closeMutex;
	Mutexdef scc_PackageCache_Mutex;
	Mutexdef scc_BuildRegistry_mutex;
	int var_results = -2; // opt var_results
	run mutexMonitor(scc_BuildRegistry_mutex);
	run mutexMonitor(scc_PackageCache_Mutex);
	run mutexMonitor(sqi_closeMutex);
	run mutexMonitor(sqi_hasNextMutex);
	run mutexMonitor(sqi_nextMutex);
	run mutexMonitor(sqi_invocationsMutex);
	run mutexMonitor(stub_createCompositeKeyMutex);
	run mutexMonitor(stub_delPrivateDataMutex);
	run mutexMonitor(stub_delStateMutex);
	run mutexMonitor(stub_getArgsMutex);
	run mutexMonitor(stub_getArgsSliceMutex);
	run mutexMonitor(stub_getBindingMutex);
	run mutexMonitor(stub_getChannelIDMutex);
	run mutexMonitor(stub_getCreatorMutex);
	run mutexMonitor(stub_getDecorationsMutex);
	run mutexMonitor(stub_getFunctionAndParametersMutex);
	run mutexMonitor(stub_getHistoryForKeyMutex);
	run mutexMonitor(stub_getPrivateDataMutex);
	run mutexMonitor(stub_getPrivateDataByPartialCompositeKeyMutex);
	run mutexMonitor(stub_getPrivateDataByRangeMutex);
	run mutexMonitor(stub_getPrivateDataHashMutex);
	run mutexMonitor(stub_getPrivateDataQueryResultMutex);
	run mutexMonitor(stub_getPrivateDataValidationParameterMutex);
	run mutexMonitor(stub_getQueryResultMutex);
	run mutexMonitor(stub_getQueryResultWithPaginationMutex);
	run mutexMonitor(stub_getSignedProposalMutex);
	run mutexMonitor(stub_getStateMutex);
	run mutexMonitor(stub_getStateByPartialCompositeKeyMutex);
	run mutexMonitor(stub_getStateByPartialCompositeKeyWithPaginationMutex);
	run mutexMonitor(stub_getStateByRangeMutex);
	run mutexMonitor(stub_getStateByRangeWithPaginationMutex);
	run mutexMonitor(stub_getStateValidationParameterMutex);
	run mutexMonitor(stub_getStringArgsMutex);
	run mutexMonitor(stub_getTransientMutex);
	run mutexMonitor(stub_getTxIDMutex);
	run mutexMonitor(stub_getTxTimestampMutex);
	run mutexMonitor(stub_invokeChaincodeMutex);
	run mutexMonitor(stub_putPrivateDataMutex);
	run mutexMonitor(stub_putStateMutex);
	run mutexMonitor(stub_setEventMutex);
	run mutexMonitor(stub_setPrivateDataValidationParameterMutex);
	run mutexMonitor(stub_setStateValidationParameterMutex);
	run mutexMonitor(stub_splitCompositeKeyMutex);
	run mutexMonitor(stub_invocationsMutex);
	run getChaincodes558(scc_BuildRegistry_mutex,scc_PackageCache_Mutex,stub_createCompositeKeyMutex,stub_delPrivateDataMutex,stub_delStateMutex,stub_getArgsMutex,stub_getArgsSliceMutex,stub_getBindingMutex,stub_getChannelIDMutex,stub_getCreatorMutex,stub_getDecorationsMutex,stub_getFunctionAndParametersMutex,stub_getHistoryForKeyMutex,stub_getPrivateDataByPartialCompositeKeyMutex,stub_getPrivateDataByRangeMutex,stub_getPrivateDataHashMutex,stub_getPrivateDataMutex,stub_getPrivateDataQueryResultMutex,stub_getPrivateDataValidationParameterMutex,stub_getQueryResultMutex,stub_getQueryResultWithPaginationMutex,stub_getSignedProposalMutex,stub_getStateByPartialCompositeKeyMutex,stub_getStateByPartialCompositeKeyWithPaginationMutex,stub_getStateByRangeMutex,stub_getStateByRangeWithPaginationMutex,stub_getStateMutex,stub_getStateValidationParameterMutex,stub_getStringArgsMutex,stub_getTransientMutex,stub_getTxIDMutex,stub_getTxTimestampMutex,stub_invocationsMutex,stub_invokeChaincodeMutex,stub_putPrivateDataMutex,stub_putStateMutex,stub_setEventMutex,stub_setPrivateDataValidationParameterMutex,stub_setStateValidationParameterMutex,stub_splitCompositeKeyMutex,child_getChaincodes5580);
	child_getChaincodes5580?0;
	stop_process: skip;
	child!0
}
proctype getChaincodes558(Mutexdef lscc_BuildRegistry_mutex;Mutexdef lscc_PackageCache_Mutex;Mutexdef stub_createCompositeKeyMutex;Mutexdef stub_delPrivateDataMutex;Mutexdef stub_delStateMutex;Mutexdef stub_getArgsMutex;Mutexdef stub_getArgsSliceMutex;Mutexdef stub_getBindingMutex;Mutexdef stub_getChannelIDMutex;Mutexdef stub_getCreatorMutex;Mutexdef stub_getDecorationsMutex;Mutexdef stub_getFunctionAndParametersMutex;Mutexdef stub_getHistoryForKeyMutex;Mutexdef stub_getPrivateDataByPartialCompositeKeyMutex;Mutexdef stub_getPrivateDataByRangeMutex;Mutexdef stub_getPrivateDataHashMutex;Mutexdef stub_getPrivateDataMutex;Mutexdef stub_getPrivateDataQueryResultMutex;Mutexdef stub_getPrivateDataValidationParameterMutex;Mutexdef stub_getQueryResultMutex;Mutexdef stub_getQueryResultWithPaginationMutex;Mutexdef stub_getSignedProposalMutex;Mutexdef stub_getStateByPartialCompositeKeyMutex;Mutexdef stub_getStateByPartialCompositeKeyWithPaginationMutex;Mutexdef stub_getStateByRangeMutex;Mutexdef stub_getStateByRangeWithPaginationMutex;Mutexdef stub_getStateMutex;Mutexdef stub_getStateValidationParameterMutex;Mutexdef stub_getStringArgsMutex;Mutexdef stub_getTransientMutex;Mutexdef stub_getTxIDMutex;Mutexdef stub_getTxTimestampMutex;Mutexdef stub_invocationsMutex;Mutexdef stub_invokeChaincodeMutex;Mutexdef stub_putPrivateDataMutex;Mutexdef stub_putStateMutex;Mutexdef stub_setEventMutex;Mutexdef stub_setPrivateDataValidationParameterMutex;Mutexdef stub_setStateValidationParameterMutex;Mutexdef stub_splitCompositeKeyMutex;chan child) {
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

