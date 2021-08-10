// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/plugin/plugin_test.go#L216
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLoadFail2160 = [1] of {int};
	run TestLoadFail216(child_TestLoadFail2160);
	run receiver(child_TestLoadFail2160)
stop_process:skip
}

proctype TestLoadFail216(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Load1450 = [1] of {int};
	Mutexdef cfg_EtcdClient_mu;
	run mutexMonitor(cfg_EtcdClient_mu);
	run Load145(cfg_EtcdClient_mu,child_Load1450);
	child_Load1450?0;
	stop_process: skip;
	child!0
}
proctype Load145(Mutexdef cfg_EtcdClient_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_tiPlugins_pluginsLkindLLiL_SysVars = -2; // opt var_tiPlugins_pluginsLkindLLiL_SysVars
	int var_tiPlugins_plugins = -2; // opt var_tiPlugins_plugins
	int var_cfg_Plugins = -2; // opt var_cfg_Plugins
	int var_cfg_EnvVersion = -2; // opt var_cfg_EnvVersion
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

