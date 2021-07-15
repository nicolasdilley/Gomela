
// https://github.com/hashicorp/consul/blob/master/agent/consul/acl_test.go#L752
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestACLResolver_ResolveRootACL7520 = [1] of {int};
	run TestACLResolver_ResolveRootACL752(child_TestACLResolver_ResolveRootACL7520)
stop_process:skip
}

proctype TestACLResolver_ResolveRootACL752(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef r_disabledLock;
	Mutexdef r_legacyGroup_mu;
	Mutexdef r_roleGroup_mu;
	Mutexdef r_policyGroup_mu;
	Mutexdef r_identityGroup_mu;
	Mutexdef r_cache_roles_lock;
	Mutexdef r_cache_authorizers_lock;
	Mutexdef r_cache_policies_lock;
	Mutexdef r_cache_parsedPolicies_lock;
	Mutexdef r_cache_identities_lock;
	Mutexdef r_tokens_persistenceLock;
	Mutexdef r_tokens_l;
	Mutexdef r_config_SerfWANConfig_Logger_mu;
	Mutexdef r_config_SerfWANConfig_MemberlistConfig_Logger_mu;
	Mutexdef r_config_SerfWANConfig_MemberlistConfig_Keyring_l;
	Mutexdef r_config_SerfLANConfig_Logger_mu;
	Mutexdef r_config_SerfLANConfig_MemberlistConfig_Logger_mu;
	Mutexdef r_config_SerfLANConfig_MemberlistConfig_Keyring_l;
	run mutexMonitor(r_config_SerfLANConfig_MemberlistConfig_Keyring_l);
	run mutexMonitor(r_config_SerfLANConfig_MemberlistConfig_Logger_mu);
	run mutexMonitor(r_config_SerfLANConfig_Logger_mu);
	run mutexMonitor(r_config_SerfWANConfig_MemberlistConfig_Keyring_l);
	run mutexMonitor(r_config_SerfWANConfig_MemberlistConfig_Logger_mu);
	run mutexMonitor(r_config_SerfWANConfig_Logger_mu);
	run mutexMonitor(r_tokens_l);
	run mutexMonitor(r_tokens_persistenceLock);
	run mutexMonitor(r_cache_identities_lock);
	run mutexMonitor(r_cache_parsedPolicies_lock);
	run mutexMonitor(r_cache_policies_lock);
	run mutexMonitor(r_cache_authorizers_lock);
	run mutexMonitor(r_cache_roles_lock);
	run mutexMonitor(r_identityGroup_mu);
	run mutexMonitor(r_policyGroup_mu);
	run mutexMonitor(r_roleGroup_mu);
	run mutexMonitor(r_legacyGroup_mu);
	run mutexMonitor(r_disabledLock);
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

