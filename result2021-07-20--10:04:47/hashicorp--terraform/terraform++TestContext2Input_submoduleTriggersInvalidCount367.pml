// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/terraform/blob/c63c06d3c4d09a1bf1a1adc20216503e0cc2f881/terraform/context_input_test.go#L367
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContext2Input_submoduleTriggersInvalidCount3670 = [1] of {int};
	run TestContext2Input_submoduleTriggersInvalidCount367(child_TestContext2Input_submoduleTriggersInvalidCount3670);
	run receiver(child_TestContext2Input_submoduleTriggersInvalidCount3670)
stop_process:skip
}

proctype TestContext2Input_submoduleTriggersInvalidCount367(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Input220 = [1] of {int};
	Mutexdef ctx_l;
	run mutexMonitor(ctx_l);
	run Input22(ctx_l,child_Input220);
	child_Input220?0;
	stop_process: skip;
	child!0
}
proctype Input22(Mutexdef c_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_keyskeys = -2; // opt var_keyskeys
	int var_schema_Attributesschema_Attributes = -2; // opt var_schema_Attributesschema_Attributes
	int var_paspas = -2; // opt var_paspas
	int var_c_config_Module_DataResourcesc_config_Module_DataResources = -2; // opt var_c_config_Module_DataResourcesc_config_Module_DataResources
	int var_c_config_Module_ManagedResourcesc_config_Module_ManagedResources = -2; // opt var_c_config_Module_ManagedResourcesc_config_Module_ManagedResources
	int var_c_config_Module_ProviderConfigsc_config_Module_ProviderConfigs = -2; // opt var_c_config_Module_ProviderConfigsc_config_Module_ProviderConfigs
	

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

proctype receiver(chan c) {
c?0
}
