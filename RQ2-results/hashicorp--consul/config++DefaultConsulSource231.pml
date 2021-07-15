
// https://github.com/hashicorp/consul/blob/master/agent/config/default.go#L231
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_DefaultConsulSource2310 = [1] of {int};
	run DefaultConsulSource231(child_DefaultConsulSource2310)
stop_process:skip
}

proctype DefaultConsulSource231(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cfg_SerfWANConfig_Logger_mu;
	Mutexdef cfg_SerfWANConfig_MemberlistConfig_Logger_mu;
	Mutexdef cfg_SerfWANConfig_MemberlistConfig_Keyring_l;
	Mutexdef cfg_SerfLANConfig_Logger_mu;
	Mutexdef cfg_SerfLANConfig_MemberlistConfig_Logger_mu;
	Mutexdef cfg_SerfLANConfig_MemberlistConfig_Keyring_l;
	run mutexMonitor(cfg_SerfLANConfig_MemberlistConfig_Keyring_l);
	run mutexMonitor(cfg_SerfLANConfig_MemberlistConfig_Logger_mu);
	run mutexMonitor(cfg_SerfLANConfig_Logger_mu);
	run mutexMonitor(cfg_SerfWANConfig_MemberlistConfig_Keyring_l);
	run mutexMonitor(cfg_SerfWANConfig_MemberlistConfig_Logger_mu);
	run mutexMonitor(cfg_SerfWANConfig_Logger_mu);
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

