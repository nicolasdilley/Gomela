// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vttablet/tabletserver/vstreamer/local_vschema_test.go#L128
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFindOrCreateVindex1280 = [1] of {int};
	run TestFindOrCreateVindex128(child_TestFindOrCreateVindex1280);
	run receiver(child_TestFindOrCreateVindex1280)
stop_process:skip
}

proctype TestFindOrCreateVindex128(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_BuildVSchema1650 = [1] of {int};
	Mutexdef testSrvVSchema_RoutingRules_state_atomicMessageInfo_initMu;
	Mutexdef testSrvVSchema_state_atomicMessageInfo_initMu;
	int var_testcases = -2; // opt var_testcases
	run mutexMonitor(testSrvVSchema_state_atomicMessageInfo_initMu);
	run mutexMonitor(testSrvVSchema_RoutingRules_state_atomicMessageInfo_initMu);
	run BuildVSchema165(testSrvVSchema_RoutingRules_state_atomicMessageInfo_initMu,testSrvVSchema_state_atomicMessageInfo_initMu,child_BuildVSchema1650);
	child_BuildVSchema1650?0;
	stop_process: skip;
	child!0
}
proctype BuildVSchema165(Mutexdef source_RoutingRules_state_atomicMessageInfo_initMu;Mutexdef source_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_buildRoutingRule3992 = [1] of {int};
	chan child_resolveAutoIncrement3491 = [1] of {int};
	chan child_buildKeyspaces2080 = [1] of {int};
	run buildKeyspaces208(source_RoutingRules_state_atomicMessageInfo_initMu,source_state_atomicMessageInfo_initMu,child_buildKeyspaces2080);
	child_buildKeyspaces2080?0;
	run resolveAutoIncrement349(source_RoutingRules_state_atomicMessageInfo_initMu,source_state_atomicMessageInfo_initMu,child_resolveAutoIncrement3491);
	child_resolveAutoIncrement3491?0;
	run buildRoutingRule399(source_RoutingRules_state_atomicMessageInfo_initMu,source_state_atomicMessageInfo_initMu,child_buildRoutingRule3992);
	child_buildRoutingRule3992?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype buildKeyspaces208(Mutexdef source_RoutingRules_state_atomicMessageInfo_initMu;Mutexdef source_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_source_Keyspaces = -2; // opt var_source_Keyspaces
	stop_process: skip;
	child!0
}
proctype resolveAutoIncrement349(Mutexdef source_RoutingRules_state_atomicMessageInfo_initMu;Mutexdef source_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_ks_Tables = -2; // opt var_ks_Tables
	int var_source_Keyspaces = -2; // opt var_source_Keyspaces
	stop_process: skip;
	child!0
}
proctype buildRoutingRule399(Mutexdef source_RoutingRules_state_atomicMessageInfo_initMu;Mutexdef source_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_rule_ToTables = -2; // opt var_rule_ToTables
	int var_source_RoutingRules_Rules = -2; // opt var_source_RoutingRules_Rules
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	outer: skip;
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

