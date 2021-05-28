// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/hashicorp/consul/blob/8d6cbe72813779f60ac24d119cc311c21003f4ce/agent/structs/acl_test.go#L466
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStructs_ACLPolicies_resolveWithCache4660 = [1] of {int};
	run TestStructs_ACLPolicies_resolveWithCache466(child_TestStructs_ACLPolicies_resolveWithCache4660);
	run receiver(child_TestStructs_ACLPolicies_resolveWithCache4660)
stop_process:skip
}

proctype TestStructs_ACLPolicies_resolveWithCache466(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cache_roles_lock;
	Mutexdef cache_authorizers_lock;
	Mutexdef cache_policies_lock;
	Mutexdef cache_parsedPolicies_lock;
	Mutexdef cache_identities_lock;
	int testPolicies = -2; // opt testPolicies
	run mutexMonitor(cache_identities_lock);
	run mutexMonitor(cache_parsedPolicies_lock);
	run mutexMonitor(cache_policies_lock);
	run mutexMonitor(cache_authorizers_lock);
	run mutexMonitor(cache_roles_lock);
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

