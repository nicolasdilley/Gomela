// num_comm_params=3
// num_mand_comm_params=0
// num_opt_comm_params=3

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/plugin6/grpc_provider_test.go#L571
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
	chan child_TestGRPCProvider_ImportResourceState5710 = [1] of {int};
	run TestGRPCProvider_ImportResourceState571(child_TestGRPCProvider_ImportResourceState5710);
	run receiver(child_TestGRPCProvider_ImportResourceState5710)
stop_process:skip
}

proctype TestGRPCProvider_ImportResourceState571(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ImportResourceState5000 = [1] of {int};
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
	run ImportResourceState500(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_mu,p_PluginClient_l,p_TestServer_mu,child_ImportResourceState5000);
	child_ImportResourceState5000?0;
	stop_process: skip;
	child!0
}
proctype ImportResourceState500(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_mu;Mutexdef p_PluginClient_l;Mutexdef p_TestServer_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getResourceSchema980 = [1] of {int};
	chan child_getResourceSchema981 = [1] of {int};
	int protoResp_ImportedResources = -2; // opt protoResp_ImportedResources
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: protoResp_ImportedResources-1 != -3 -> 
				for(i : 0.. protoResp_ImportedResources-1) {
			for10: skip;
			run getResourceSchema98(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_mu,p_PluginClient_l,p_TestServer_mu,child_getResourceSchema980);
			child_getResourceSchema980?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for15: skip;
			run getResourceSchema98(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_mu,p_PluginClient_l,p_TestServer_mu,child_getResourceSchema981);
			child_getResourceSchema981?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for15_end: skip
		:: true -> 
			break
		od;
		for15_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getResourceSchema98(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_mu;Mutexdef p_PluginClient_l;Mutexdef p_TestServer_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getSchema760 = [1] of {int};
	run getSchema76(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_mu,p_PluginClient_l,p_TestServer_mu,child_getSchema760);
	child_getSchema760?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getSchema76(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_mu;Mutexdef p_PluginClient_l;Mutexdef p_TestServer_mu;chan child) {
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
	run GetProviderSchema125(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_TestServer_serveWG,p_mu,p_PluginClient_l,p_TestServer_mu,child_GetProviderSchema1250);
	child_GetProviderSchema1250?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetProviderSchema125(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Wgdef p_TestServer_serveWG;Mutexdef p_mu;Mutexdef p_PluginClient_l;Mutexdef p_TestServer_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int protoResp_DataSourceSchemas = -2; // opt protoResp_DataSourceSchemas
	int protoResp_ResourceSchemas = -2; // opt protoResp_ResourceSchemas
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

