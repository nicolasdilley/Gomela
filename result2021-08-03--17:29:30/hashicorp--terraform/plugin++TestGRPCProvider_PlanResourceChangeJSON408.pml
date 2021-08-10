// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/plugin/grpc_provider_test.go#L408
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
	chan child_TestGRPCProvider_PlanResourceChangeJSON4080 = [1] of {int};
	run TestGRPCProvider_PlanResourceChangeJSON408(child_TestGRPCProvider_PlanResourceChangeJSON4080);
	run receiver(child_TestGRPCProvider_PlanResourceChangeJSON4080)
stop_process:skip
}

proctype TestGRPCProvider_PlanResourceChangeJSON408(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PlanResourceChange3780 = [1] of {int};
	Mutexdef p_mu;
	Wgdef p_TestServer_serveWG;
	Mutexdef p_TestServer_mu;
	Wgdef p_PluginClient_stderrWaitGroup;
	Wgdef p_PluginClient_clientWaitGroup;
	Mutexdef p_PluginClient_l;
	Mutexdef client_ctrl_mu;
	run mutexMonitor(client_ctrl_mu);
	run mutexMonitor(p_PluginClient_l);
	run wgMonitor(p_PluginClient_clientWaitGroup);
	run wgMonitor(p_PluginClient_stderrWaitGroup);
	run mutexMonitor(p_TestServer_mu);
	run wgMonitor(p_TestServer_serveWG);
	run mutexMonitor(p_mu);
	run PlanResourceChange378(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_mu,p_PluginClient_l,p_TestServer_mu,child_PlanResourceChange3780);
	child_PlanResourceChange3780?0;
	stop_process: skip;
	child!0
}
proctype PlanResourceChange378(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_mu;Mutexdef p_PluginClient_l;Mutexdef p_TestServer_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AttributePathToPath822 = [1] of {int};
	chan child_AttributePathToPath823 = [1] of {int};
	chan child_getProviderMetaSchema1131 = [1] of {int};
	chan child_getResourceSchema910 = [1] of {int};
	int var_protoResp_RequiresReplace = -2; // opt var_protoResp_RequiresReplace
	run getResourceSchema91(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_mu,p_PluginClient_l,p_TestServer_mu,child_getResourceSchema910);
	child_getResourceSchema910?0;
	run getProviderMetaSchema113(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_mu,p_PluginClient_l,p_TestServer_mu,child_getProviderMetaSchema1131);
	child_getProviderMetaSchema1131?0;
	

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
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
	

	if
	:: var_protoResp_RequiresReplace-1 != -3 -> 
				for(i : 0.. var_protoResp_RequiresReplace-1) {
			for30: skip;
			run AttributePathToPath82(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_mu,p_PluginClient_l,p_TestServer_mu,child_AttributePathToPath822);
			child_AttributePathToPath822?0;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for33: skip;
			run AttributePathToPath82(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_mu,p_PluginClient_l,p_TestServer_mu,child_AttributePathToPath823);
			child_AttributePathToPath823?0;
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
proctype getResourceSchema91(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_mu;Mutexdef p_PluginClient_l;Mutexdef p_TestServer_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getSchema690 = [1] of {int};
	run getSchema69(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_mu,p_PluginClient_l,p_TestServer_mu,child_getSchema690);
	child_getSchema690?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getSchema69(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_mu;Mutexdef p_PluginClient_l;Mutexdef p_TestServer_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetProviderSchema1180 = [1] of {int};
	p_mu.Lock!false;
	

	if
	:: true -> 
		p_mu.Unlock!false;
		goto stop_process
	:: true;
	fi;
	p_mu.Unlock!false;
	run GetProviderSchema118(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_mu,p_PluginClient_l,p_TestServer_mu,child_GetProviderSchema1180);
	child_GetProviderSchema1180?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetProviderSchema118(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_mu;Mutexdef p_PluginClient_l;Mutexdef p_TestServer_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_protoResp_DataSourceSchemas = -2; // opt var_protoResp_DataSourceSchemas
	int var_protoResp_ResourceSchemas = -2; // opt var_protoResp_ResourceSchemas
	p_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	p_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype getProviderMetaSchema113(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_mu;Mutexdef p_PluginClient_l;Mutexdef p_TestServer_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getSchema691 = [1] of {int};
	run getSchema69(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_mu,p_PluginClient_l,p_TestServer_mu,child_getSchema691);
	child_getSchema691?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AttributePathToPath82(Wgdef ap_PluginClient_clientWaitGroup;Wgdef ap_PluginClient_stderrWaitGroup;Wgdef ap_TestServer_serveWG;Mutexdef ap_mu;Mutexdef ap_PluginClient_l;Mutexdef ap_TestServer_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_ap_Steps = -2; // opt var_ap_Steps
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

proctype receiver(chan c) {
c?0
}
