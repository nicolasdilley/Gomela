
// https://github.com/hashicorp/terraform/blob/master/plugin/grpc_provisioner_test.go#L64
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
	chan child_TestGRPCProvisioner_ValidateProvisionerConfig640 = [1] of {int};
	run TestGRPCProvisioner_ValidateProvisionerConfig64(child_TestGRPCProvisioner_ValidateProvisionerConfig640)
stop_process:skip
}

proctype TestGRPCProvisioner_ValidateProvisionerConfig64(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ValidateProvisionerConfig800 = [1] of {int};
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
	run ValidateProvisionerConfig80(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_PluginClient_config_Cmd_Process_sigMu,p_PluginClient_config_TLSConfig_mutex,p_PluginClient_l,p_PluginClient_process_sigMu,p_mu,child_ValidateProvisionerConfig800);
	child_ValidateProvisionerConfig800?0;
	stop_process: skip;
	child!0
}
proctype ValidateProvisionerConfig80(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Mutexdef p_PluginClient_config_Cmd_Process_sigMu;Mutexdef p_PluginClient_config_TLSConfig_mutex;Mutexdef p_PluginClient_l;Mutexdef p_PluginClient_process_sigMu;Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef protoResp_state_atomicMessageInfo_initMu;
	Mutexdef protoReq_Config_state_atomicMessageInfo_initMu;
	Mutexdef protoReq_state_atomicMessageInfo_initMu;
	chan child_GetSchema510 = [1] of {int};
	run GetSchema51(p_PluginClient_stderrWaitGroup,p_PluginClient_clientWaitGroup,p_PluginClient_config_Cmd_Process_sigMu,p_PluginClient_config_TLSConfig_mutex,p_PluginClient_l,p_PluginClient_process_sigMu,p_mu,child_GetSchema510);
	child_GetSchema510?0;
	

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
	run mutexMonitor(protoReq_Config_state_atomicMessageInfo_initMu);
	run mutexMonitor(protoResp_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetSchema51(Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_PluginClient_clientWaitGroup;Mutexdef p_PluginClient_config_Cmd_Process_sigMu;Mutexdef p_PluginClient_config_TLSConfig_mutex;Mutexdef p_PluginClient_l;Mutexdef p_PluginClient_process_sigMu;Mutexdef p_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ProtoToConfigSchema1040 = [1] of {int};
	Mutexdef protoResp_Provisioner_Block_state_atomicMessageInfo_initMu;
	Mutexdef protoResp_Provisioner_state_atomicMessageInfo_initMu;
	Mutexdef protoResp_state_atomicMessageInfo_initMu;
	p_mu.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(protoResp_state_atomicMessageInfo_initMu);
	run mutexMonitor(protoResp_Provisioner_state_atomicMessageInfo_initMu);
	run mutexMonitor(protoResp_Provisioner_Block_state_atomicMessageInfo_initMu);
	

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
	run ProtoToConfigSchema104(protoResp_Provisioner_Block_state_atomicMessageInfo_initMu,child_ProtoToConfigSchema1040);
	child_ProtoToConfigSchema1040?0;
	goto stop_process;
	stop_process: skip;
		p_mu.Unlock!false;
	child!0
}
proctype ProtoToConfigSchema104(Mutexdef b_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_schemaNestedBlock1540 = [1] of {int};
	chan child_schemaNestedBlock1541 = [1] of {int};
	int b_BlockTypes = -2;
	

	if
	:: b_BlockTypes-1 != -3 -> 
				for(i : 0.. b_BlockTypes-1) {
			for20: skip;
			run schemaNestedBlock154(b_state_atomicMessageInfo_initMu,child_schemaNestedBlock1540);
			child_schemaNestedBlock1540?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			run schemaNestedBlock154(b_state_atomicMessageInfo_initMu,child_schemaNestedBlock1541);
			child_schemaNestedBlock1541?0;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype schemaNestedBlock154(Mutexdef b_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
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

