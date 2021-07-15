
// https://github.com/hashicorp/terraform/blob/master/plugin6/grpc_provider_test.go#L237
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
	chan child_TestGRPCProvider_Stop2370 = [1] of {int};
	run TestGRPCProvider_Stop237(child_TestGRPCProvider_Stop2370)
stop_process:skip
}

proctype TestGRPCProvider_Stop237(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stop3190 = [1] of {int};
	Mutexdef p_mu;
	Wgdef p_TestServer_serveWG;
	Mutexdef p_TestServer_channelzRemoveOnce_m;
	Mutexdef p_TestServer_done_o_m;
	Mutexdef p_TestServer_quit_o_m;
	Mutexdef p_TestServer_mu;
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
	run mutexMonitor(p_TestServer_mu);
	run mutexMonitor(p_TestServer_quit_o_m);
	run mutexMonitor(p_TestServer_done_o_m);
	run mutexMonitor(p_TestServer_channelzRemoveOnce_m);
	run wgMonitor(p_TestServer_serveWG);
	run mutexMonitor(p_mu);
	run Stop319(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_PluginClient_config_Cmd_Process_sigMu,p_PluginClient_config_TLSConfig_mutex,p_PluginClient_l,p_PluginClient_process_sigMu,p_TestServer_mu,p_TestServer_quit_o_m,p_TestServer_done_o_m,p_TestServer_channelzRemoveOnce_m,p_mu,child_Stop3190);
	child_Stop3190?0;
	stop_process: skip;
	child!0
}
proctype Stop319(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_PluginClient_config_Cmd_Process_sigMu;Mutexdef p_PluginClient_config_TLSConfig_mutex;Mutexdef p_PluginClient_l;Mutexdef p_PluginClient_process_sigMu;Mutexdef p_TestServer_mu;Mutexdef p_TestServer_quit_o_m;Mutexdef p_TestServer_done_o_m;Mutexdef p_TestServer_channelzRemoveOnce_m;Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef resp_state_atomicMessageInfo_initMu;
	run mutexMonitor(resp_state_atomicMessageInfo_initMu);
	

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

