// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/consul/blob/8d6cbe72813779f60ac24d119cc311c21003f4ce/command/acl/token/update/token_update.go#L93
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Run930 = [1] of {int};
	run Run93(child_Run930);
	run receiver(child_Run930)
stop_process:skip
}

proctype Run93(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef client_modifyLock;
	int var_t_NodeIdentitiest_NodeIdentities = -2; // opt var_t_NodeIdentitiest_NodeIdentities
	int var_parsedNodeIdentsparsedNodeIdents = -2; // opt var_parsedNodeIdentsparsedNodeIdents
	int var_t_ServiceIdentitiest_ServiceIdentities = -2; // opt var_t_ServiceIdentitiest_ServiceIdentities
	int var_parsedServiceIdentsparsedServiceIdents = -2; // opt var_parsedServiceIdentsparsedServiceIdents
	int var_c_roleIDsc_roleIDs = -2; // opt var_c_roleIDsc_roleIDs
	int var_t_Rolest_Roles = -2; // opt var_t_Rolest_Roles
	int var_c_roleNamesc_roleNames = -2; // opt var_c_roleNamesc_roleNames
	int var_c_policyIDsc_policyIDs = -2; // opt var_c_policyIDsc_policyIDs
	int var_t_Policiest_Policies = -2; // opt var_t_Policiest_Policies
	int var_c_policyNamesc_policyNames = -2; // opt var_c_policyNamesc_policyNames
	

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
	run mutexMonitor(client_modifyLock);
	

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

