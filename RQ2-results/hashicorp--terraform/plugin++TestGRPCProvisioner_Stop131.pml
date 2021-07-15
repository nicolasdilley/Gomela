
// https://github.com/hashicorp/terraform/blob/master/plugin/grpc_provisioner_test.go#L131
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGRPCProvisioner_Stop1310 = [1] of {int};
	run TestGRPCProvisioner_Stop131(child_TestGRPCProvisioner_Stop1310)
stop_process:skip
}

proctype TestGRPCProvisioner_Stop131(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stop1570 = [1] of {int};
	Mutexdef p_mu;
	Wgdef p_PluginClient_stderrWaitGroup;
	Wgdef p_PluginClient_clientWaitGroup;
	Mutexdef p_PluginClient_process_sigMu;
	Mutexdef p_PluginClient_l;
	Mutexdef p_PluginClient_config_TLSConfig_mutex;
	Mutexdef p_PluginClient_config_Cmd_Process_sigMu;
	Mutexdef client_ctrl_mu;
	run mutexMonitor(client_ctrl_mu);
	run mutexMonitor(p_PluginClient_config_Cmd_Process_sigMu);
	run mutexMonitor(p_PluginClient_config_TLSConfig_mutex);
	run mutexMonitor(p_PluginClient_l);
	run mutexMonitor(p_PluginClient_process_sigMu);
	run wgMonitor(p_PluginClient_clientWaitGroup);
	run wgMonitor(p_PluginClient_stderrWaitGroup);
	run mutexMonitor(p_mu);
	run Stop157(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_PluginClient_config_Cmd_Process_sigMu,p_PluginClient_config_TLSConfig_mutex,p_PluginClient_l,p_PluginClient_process_sigMu,p_mu,child_Stop1570);
	child_Stop1570?0;
	stop_process: skip;
	child!0
}
proctype Stop157(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Mutexdef p_PluginClient_config_Cmd_Process_sigMu;Mutexdef p_PluginClient_config_TLSConfig_mutex;Mutexdef p_PluginClient_l;Mutexdef p_PluginClient_process_sigMu;Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef protoResp_state_atomicMessageInfo_initMu;
	run mutexMonitor(protoResp_state_atomicMessageInfo_initMu);
	

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
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
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

