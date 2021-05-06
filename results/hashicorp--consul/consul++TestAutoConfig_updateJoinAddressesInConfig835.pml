
// https://github.com/hashicorp/consul/blob/master/agent/consul/auto_config_endpoint_test.go#L835
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAutoConfig_updateJoinAddressesInConfig8350 = [1] of {int};
	run TestAutoConfig_updateJoinAddressesInConfig835(child_TestAutoConfig_updateJoinAddressesInConfig8350)
stop_process:skip
}

proctype TestAutoConfig_updateJoinAddressesInConfig835(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_updateJoinAddressesInConfig2290 = [1] of {int};
	Mutexdef ac_config_SerfWANConfig_Logger_mu;
	Mutexdef ac_config_SerfWANConfig_MemberlistConfig_Logger_mu;
	Mutexdef ac_config_SerfWANConfig_MemberlistConfig_Keyring_l;
	Mutexdef ac_config_SerfLANConfig_Logger_mu;
	Mutexdef ac_config_SerfLANConfig_MemberlistConfig_Logger_mu;
	Mutexdef ac_config_SerfLANConfig_MemberlistConfig_Keyring_l;
	run mutexMonitor(ac_config_SerfLANConfig_MemberlistConfig_Keyring_l);
	run mutexMonitor(ac_config_SerfLANConfig_MemberlistConfig_Logger_mu);
	run mutexMonitor(ac_config_SerfLANConfig_Logger_mu);
	run mutexMonitor(ac_config_SerfWANConfig_MemberlistConfig_Keyring_l);
	run mutexMonitor(ac_config_SerfWANConfig_MemberlistConfig_Logger_mu);
	run mutexMonitor(ac_config_SerfWANConfig_Logger_mu);
	run updateJoinAddressesInConfig229(ac_config_SerfLANConfig_MemberlistConfig_Keyring_l,ac_config_SerfLANConfig_MemberlistConfig_Logger_mu,ac_config_SerfLANConfig_Logger_mu,ac_config_SerfWANConfig_MemberlistConfig_Keyring_l,ac_config_SerfWANConfig_MemberlistConfig_Logger_mu,ac_config_SerfWANConfig_Logger_mu,child_updateJoinAddressesInConfig2290);
	child_updateJoinAddressesInConfig2290?0;
	stop_process: skip;
	child!0
}
proctype updateJoinAddressesInConfig229(Mutexdef ac_config_SerfLANConfig_MemberlistConfig_Keyring_l;Mutexdef ac_config_SerfLANConfig_MemberlistConfig_Logger_mu;Mutexdef ac_config_SerfLANConfig_Logger_mu;Mutexdef ac_config_SerfWANConfig_MemberlistConfig_Keyring_l;Mutexdef ac_config_SerfWANConfig_MemberlistConfig_Logger_mu;Mutexdef ac_config_SerfWANConfig_Logger_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

