// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//discovery/support/acl/support_test.go#L107
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSatisfiesPrincipal1070 = [1] of {int};
	run TestSatisfiesPrincipal107(child_TestSatisfiesPrincipal1070);
	run receiver(child_TestSatisfiesPrincipal1070)
stop_process:skip
}

proctype TestSatisfiesPrincipal107(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewDiscoverySupport580 = [1] of {int};
	Mutexdef idThatSatisfiesPrincipal_invocationsMutex;
	Mutexdef idThatSatisfiesPrincipal_verifyMutex;
	Mutexdef idThatSatisfiesPrincipal_validateMutex;
	Mutexdef idThatSatisfiesPrincipal_serializeMutex;
	Mutexdef idThatSatisfiesPrincipal_satisfiesPrincipalMutex;
	Mutexdef idThatSatisfiesPrincipal_getOrganizationalUnitsMutex;
	Mutexdef idThatSatisfiesPrincipal_getMSPIdentifierMutex;
	Mutexdef idThatSatisfiesPrincipal_getIdentifierMutex;
	Mutexdef idThatSatisfiesPrincipal_expiresAtMutex;
	Mutexdef idThatSatisfiesPrincipal_anonymousMutex;
	Mutexdef idThatDoesNotSatisfyPrincipal_invocationsMutex;
	Mutexdef idThatDoesNotSatisfyPrincipal_verifyMutex;
	Mutexdef idThatDoesNotSatisfyPrincipal_validateMutex;
	Mutexdef idThatDoesNotSatisfyPrincipal_serializeMutex;
	Mutexdef idThatDoesNotSatisfyPrincipal_satisfiesPrincipalMutex;
	Mutexdef idThatDoesNotSatisfyPrincipal_getOrganizationalUnitsMutex;
	Mutexdef idThatDoesNotSatisfyPrincipal_getMSPIdentifierMutex;
	Mutexdef idThatDoesNotSatisfyPrincipal_getIdentifierMutex;
	Mutexdef idThatDoesNotSatisfyPrincipal_expiresAtMutex;
	Mutexdef idThatDoesNotSatisfyPrincipal_anonymousMutex;
	Mutexdef mgr_invocationsMutex;
	Mutexdef mgr_setupMutex;
	Mutexdef mgr_isWellFormedMutex;
	Mutexdef mgr_getMSPsMutex;
	Mutexdef mgr_deserializeIdentityMutex;
	Mutexdef resources_invocationsMutex;
	Mutexdef resources_validateNewMutex;
	Mutexdef resources_policyManagerMutex;
	Mutexdef resources_ordererConfigMutex;
	Mutexdef resources_mSPManagerMutex;
	Mutexdef resources_consortiumsConfigMutex;
	Mutexdef resources_configtxValidatorMutex;
	Mutexdef resources_channelConfigMutex;
	Mutexdef resources_applicationConfigMutex;
	Mutexdef chConfig_invocationsMutex;
	Mutexdef chConfig_getChannelConfigMutex;
	int var_tests = -2; // opt var_tests
	run mutexMonitor(chConfig_getChannelConfigMutex);
	run mutexMonitor(chConfig_invocationsMutex);
	run mutexMonitor(resources_applicationConfigMutex);
	run mutexMonitor(resources_channelConfigMutex);
	run mutexMonitor(resources_configtxValidatorMutex);
	run mutexMonitor(resources_consortiumsConfigMutex);
	run mutexMonitor(resources_mSPManagerMutex);
	run mutexMonitor(resources_ordererConfigMutex);
	run mutexMonitor(resources_policyManagerMutex);
	run mutexMonitor(resources_validateNewMutex);
	run mutexMonitor(resources_invocationsMutex);
	run mutexMonitor(mgr_deserializeIdentityMutex);
	run mutexMonitor(mgr_getMSPsMutex);
	run mutexMonitor(mgr_isWellFormedMutex);
	run mutexMonitor(mgr_setupMutex);
	run mutexMonitor(mgr_invocationsMutex);
	run mutexMonitor(idThatDoesNotSatisfyPrincipal_anonymousMutex);
	run mutexMonitor(idThatDoesNotSatisfyPrincipal_expiresAtMutex);
	run mutexMonitor(idThatDoesNotSatisfyPrincipal_getIdentifierMutex);
	run mutexMonitor(idThatDoesNotSatisfyPrincipal_getMSPIdentifierMutex);
	run mutexMonitor(idThatDoesNotSatisfyPrincipal_getOrganizationalUnitsMutex);
	run mutexMonitor(idThatDoesNotSatisfyPrincipal_satisfiesPrincipalMutex);
	run mutexMonitor(idThatDoesNotSatisfyPrincipal_serializeMutex);
	run mutexMonitor(idThatDoesNotSatisfyPrincipal_validateMutex);
	run mutexMonitor(idThatDoesNotSatisfyPrincipal_verifyMutex);
	run mutexMonitor(idThatDoesNotSatisfyPrincipal_invocationsMutex);
	run mutexMonitor(idThatSatisfiesPrincipal_anonymousMutex);
	run mutexMonitor(idThatSatisfiesPrincipal_expiresAtMutex);
	run mutexMonitor(idThatSatisfiesPrincipal_getIdentifierMutex);
	run mutexMonitor(idThatSatisfiesPrincipal_getMSPIdentifierMutex);
	run mutexMonitor(idThatSatisfiesPrincipal_getOrganizationalUnitsMutex);
	run mutexMonitor(idThatSatisfiesPrincipal_satisfiesPrincipalMutex);
	run mutexMonitor(idThatSatisfiesPrincipal_serializeMutex);
	run mutexMonitor(idThatSatisfiesPrincipal_validateMutex);
	run mutexMonitor(idThatSatisfiesPrincipal_verifyMutex);
	run mutexMonitor(idThatSatisfiesPrincipal_invocationsMutex);
	run NewDiscoverySupport58(chConfig_getChannelConfigMutex,chConfig_invocationsMutex,child_NewDiscoverySupport580);
	child_NewDiscoverySupport580?0;
	stop_process: skip;
	child!0
}
proctype NewDiscoverySupport58(Mutexdef chanConf_getChannelConfigMutex;Mutexdef chanConf_invocationsMutex;chan child) {
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

