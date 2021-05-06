
// https://github.com/hashicorp/terraform/blob/master/plugin6/grpc_provider_test.go#L415
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
	chan child_TestGRPCProvider_PlanResourceChangeJSON4150 = [1] of {int};
	run TestGRPCProvider_PlanResourceChangeJSON415(child_TestGRPCProvider_PlanResourceChangeJSON4150)
stop_process:skip
}

proctype TestGRPCProvider_PlanResourceChangeJSON415(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PlanResourceChange3780 = [1] of {int};
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
	run PlanResourceChange378(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_PluginClient_config_Cmd_Process_sigMu,p_PluginClient_config_TLSConfig_mutex,p_PluginClient_l,p_PluginClient_process_sigMu,p_TestServer_mu,p_TestServer_quit_o_m,p_TestServer_done_o_m,p_TestServer_channelzRemoveOnce_m,p_mu,child_PlanResourceChange3780);
	child_PlanResourceChange3780?0;
	stop_process: skip;
	child!0
}
proctype PlanResourceChange378(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_PluginClient_config_Cmd_Process_sigMu;Mutexdef p_PluginClient_config_TLSConfig_mutex;Mutexdef p_PluginClient_l;Mutexdef p_PluginClient_process_sigMu;Mutexdef p_TestServer_mu;Mutexdef p_TestServer_quit_o_m;Mutexdef p_TestServer_done_o_m;Mutexdef p_TestServer_channelzRemoveOnce_m;Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AttributePathToPath823 = [1] of {int};
	chan child_AttributePathToPath824 = [1] of {int};
	chan child_decodeDynamicValue6022 = [1] of {int};
	Mutexdef protoResp_PlannedState_state_atomicMessageInfo_initMu;
	Mutexdef protoResp_state_atomicMessageInfo_initMu;
	Mutexdef protoReq_ProviderMeta_state_atomicMessageInfo_initMu;
	Mutexdef protoReq_Config_state_atomicMessageInfo_initMu;
	Mutexdef protoReq_ProposedNewState_state_atomicMessageInfo_initMu;
	Mutexdef protoReq_PriorState_state_atomicMessageInfo_initMu;
	Mutexdef protoReq_state_atomicMessageInfo_initMu;
	chan child_getProviderMetaSchema1201 = [1] of {int};
	chan child_getResourceSchema980 = [1] of {int};
	int protoResp_RequiresReplace = -2;
	run getResourceSchema98(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_PluginClient_config_Cmd_Process_sigMu,p_PluginClient_config_TLSConfig_mutex,p_PluginClient_l,p_PluginClient_process_sigMu,p_TestServer_mu,p_TestServer_quit_o_m,p_TestServer_done_o_m,p_TestServer_channelzRemoveOnce_m,p_mu,child_getResourceSchema980);
	child_getResourceSchema980?0;
	run getProviderMetaSchema120(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_PluginClient_config_Cmd_Process_sigMu,p_PluginClient_config_TLSConfig_mutex,p_PluginClient_l,p_PluginClient_process_sigMu,p_TestServer_mu,p_TestServer_quit_o_m,p_TestServer_done_o_m,p_TestServer_channelzRemoveOnce_m,p_mu,child_getProviderMetaSchema1201);
	child_getProviderMetaSchema1201?0;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(protoReq_state_atomicMessageInfo_initMu);
	run mutexMonitor(protoReq_PriorState_state_atomicMessageInfo_initMu);
	run mutexMonitor(protoReq_ProposedNewState_state_atomicMessageInfo_initMu);
	run mutexMonitor(protoReq_Config_state_atomicMessageInfo_initMu);
	run mutexMonitor(protoReq_ProviderMeta_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run mutexMonitor(protoResp_state_atomicMessageInfo_initMu);
	run mutexMonitor(protoResp_PlannedState_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run decodeDynamicValue602(protoResp_PlannedState_state_atomicMessageInfo_initMu,child_decodeDynamicValue6022);
	child_decodeDynamicValue6022?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: protoResp_RequiresReplace-1 != -3 -> 
				for(i : 0.. protoResp_RequiresReplace-1) {
			for30: skip;
			run AttributePathToPath82(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_PluginClient_config_Cmd_Process_sigMu,p_PluginClient_config_TLSConfig_mutex,p_PluginClient_l,p_PluginClient_process_sigMu,p_TestServer_mu,p_TestServer_quit_o_m,p_TestServer_done_o_m,p_TestServer_channelzRemoveOnce_m,p_mu,child_AttributePathToPath823);
			child_AttributePathToPath823?0;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for33: skip;
			run AttributePathToPath82(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_PluginClient_config_Cmd_Process_sigMu,p_PluginClient_config_TLSConfig_mutex,p_PluginClient_l,p_PluginClient_process_sigMu,p_TestServer_mu,p_TestServer_quit_o_m,p_TestServer_done_o_m,p_TestServer_channelzRemoveOnce_m,p_mu,child_AttributePathToPath824);
			child_AttributePathToPath824?0;
			for33_end: skip
		:: true -> 
			break
		od;
		for33_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getResourceSchema98(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_PluginClient_config_Cmd_Process_sigMu;Mutexdef p_PluginClient_config_TLSConfig_mutex;Mutexdef p_PluginClient_l;Mutexdef p_PluginClient_process_sigMu;Mutexdef p_TestServer_mu;Mutexdef p_TestServer_quit_o_m;Mutexdef p_TestServer_done_o_m;Mutexdef p_TestServer_channelzRemoveOnce_m;Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getSchema760 = [1] of {int};
	run getSchema76(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_PluginClient_config_Cmd_Process_sigMu,p_PluginClient_config_TLSConfig_mutex,p_PluginClient_l,p_PluginClient_process_sigMu,p_TestServer_mu,p_TestServer_quit_o_m,p_TestServer_done_o_m,p_TestServer_channelzRemoveOnce_m,p_mu,child_getSchema760);
	child_getSchema760?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getSchema76(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_PluginClient_config_Cmd_Process_sigMu;Mutexdef p_PluginClient_config_TLSConfig_mutex;Mutexdef p_PluginClient_l;Mutexdef p_PluginClient_process_sigMu;Mutexdef p_TestServer_mu;Mutexdef p_TestServer_quit_o_m;Mutexdef p_TestServer_done_o_m;Mutexdef p_TestServer_channelzRemoveOnce_m;Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetProviderSchema1250 = [1] of {int};
	p_mu.Lock!false;
	

	if
	:: true -> 
		p_mu.Unlock!false;
		goto stop_process
	:: true;
	fi;
	p_mu.Unlock!false;
	run GetProviderSchema125(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_PluginClient_config_Cmd_Process_sigMu,p_PluginClient_config_TLSConfig_mutex,p_PluginClient_l,p_PluginClient_process_sigMu,p_TestServer_mu,p_TestServer_quit_o_m,p_TestServer_done_o_m,p_TestServer_channelzRemoveOnce_m,p_mu,child_GetProviderSchema1250);
	child_GetProviderSchema1250?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetProviderSchema125(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_PluginClient_config_Cmd_Process_sigMu;Mutexdef p_PluginClient_config_TLSConfig_mutex;Mutexdef p_PluginClient_l;Mutexdef p_PluginClient_process_sigMu;Mutexdef p_TestServer_mu;Mutexdef p_TestServer_quit_o_m;Mutexdef p_TestServer_done_o_m;Mutexdef p_TestServer_channelzRemoveOnce_m;Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ProtoToProviderSchema951 = [1] of {int};
	chan child_ProtoToProviderSchema950 = [1] of {int};
	Mutexdef protoResp_ProviderMeta_Block_state_atomicMessageInfo_initMu;
	Mutexdef protoResp_ProviderMeta_state_atomicMessageInfo_initMu;
	Mutexdef protoResp_Provider_Block_state_atomicMessageInfo_initMu;
	Mutexdef protoResp_Provider_state_atomicMessageInfo_initMu;
	Mutexdef protoResp_state_atomicMessageInfo_initMu;
	p_mu.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(protoResp_state_atomicMessageInfo_initMu);
	run mutexMonitor(protoResp_Provider_state_atomicMessageInfo_initMu);
	run mutexMonitor(protoResp_Provider_Block_state_atomicMessageInfo_initMu);
	run mutexMonitor(protoResp_ProviderMeta_state_atomicMessageInfo_initMu);
	run mutexMonitor(protoResp_ProviderMeta_Block_state_atomicMessageInfo_initMu);
	

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
	run ProtoToProviderSchema95(protoResp_Provider_state_atomicMessageInfo_initMu,protoResp_Provider_Block_state_atomicMessageInfo_initMu,child_ProtoToProviderSchema950);
	child_ProtoToProviderSchema950?0;
	

	if
	:: true -> 
		run ProtoToProviderSchema95(protoResp_ProviderMeta_state_atomicMessageInfo_initMu,protoResp_ProviderMeta_Block_state_atomicMessageInfo_initMu,child_ProtoToProviderSchema951);
		child_ProtoToProviderSchema951?0
	fi;
	goto stop_process;
	stop_process: skip;
		p_mu.Unlock!false;
	child!0
}
proctype ProtoToProviderSchema95(Mutexdef s_state_atomicMessageInfo_initMu;Mutexdef s_Block_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getProviderMetaSchema120(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_PluginClient_config_Cmd_Process_sigMu;Mutexdef p_PluginClient_config_TLSConfig_mutex;Mutexdef p_PluginClient_l;Mutexdef p_PluginClient_process_sigMu;Mutexdef p_TestServer_mu;Mutexdef p_TestServer_quit_o_m;Mutexdef p_TestServer_done_o_m;Mutexdef p_TestServer_channelzRemoveOnce_m;Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getSchema761 = [1] of {int};
	run getSchema76(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_PluginClient_config_Cmd_Process_sigMu,p_PluginClient_config_TLSConfig_mutex,p_PluginClient_l,p_PluginClient_process_sigMu,p_TestServer_mu,p_TestServer_quit_o_m,p_TestServer_done_o_m,p_TestServer_channelzRemoveOnce_m,p_mu,child_getSchema761);
	child_getSchema761?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype decodeDynamicValue602(Mutexdef v_state_atomicMessageInfo_initMu;chan child) {
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
	:: true;
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AttributePathToPath82(Wgdef ap_PluginClient_clientWaitGroup;Wgdef ap_PluginClient_stderrWaitGroup;Wgdef ap_TestServer_serveWG;Mutexdef ap_PluginClient_config_Cmd_Process_sigMu;Mutexdef ap_PluginClient_config_TLSConfig_mutex;Mutexdef ap_PluginClient_l;Mutexdef ap_PluginClient_process_sigMu;Mutexdef ap_TestServer_mu;Mutexdef ap_TestServer_quit_o_m;Mutexdef ap_TestServer_done_o_m;Mutexdef ap_TestServer_channelzRemoveOnce_m;Mutexdef ap_mu;chan child) {
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

