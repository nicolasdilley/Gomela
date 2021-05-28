// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/plugin/grpc_provisioner_test.go#L64
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
	run TestGRPCProvisioner_ValidateProvisionerConfig64(child_TestGRPCProvisioner_ValidateProvisionerConfig640);
	run receiver(child_TestGRPCProvisioner_ValidateProvisionerConfig640)
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
	Mutexdef p_PluginClient_l;
	Mutexdef client_ctrl_mu;
	run mutexMonitor(client_ctrl_mu);
	run mutexMonitor(p_PluginClient_l);
	run wgMonitor(p_PluginClient_clientWaitGroup);
	run wgMonitor(p_PluginClient_stderrWaitGroup);
	run mutexMonitor(p_mu);
	run ValidateProvisionerConfig80(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_mu,p_PluginClient_l,child_ValidateProvisionerConfig800);
	child_ValidateProvisionerConfig800?0;
	stop_process: skip;
	child!0
}
proctype ValidateProvisionerConfig80(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Mutexdef p_mu;Mutexdef p_PluginClient_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetSchema510 = [1] of {int};
	run GetSchema51(p_PluginClient_clientWaitGroup,p_PluginClient_stderrWaitGroup,p_mu,p_PluginClient_l,child_GetSchema510);
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetSchema51(Wgdef p_PluginClient_clientWaitGroup;Wgdef p_PluginClient_stderrWaitGroup;Mutexdef p_mu;Mutexdef p_PluginClient_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

