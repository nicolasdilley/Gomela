// num_comm_params=5
// num_mand_comm_params=0
// num_opt_comm_params=5

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pilot/pkg/status/reporter_test.go#L61
#define not_found_115  -2 // opt not_found_115
#define not_found_118  -2 // opt not_found_118
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBuildReport610 = [1] of {int};
	run TestBuildReport61(child_TestBuildReport610);
	run receiver(child_TestBuildReport610)
stop_process:skip
}

proctype TestBuildReport61(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_removeCompletedResource1928 = [1] of {int};
	chan child_buildReport1477 = [1] of {int};
	chan child_RegisterDisconnect3496 = [1] of {int};
	chan child_processEvent3165 = [1] of {int};
	chan child_AddInProgressResource2194 = [1] of {int};
	chan child_processEvent3162 = [1] of {int};
	chan child_processEvent3163 = [1] of {int};
	chan child_AddInProgressResource2190 = [1] of {int};
	chan child_AddInProgressResource2191 = [1] of {int};
	Mutexdef r_controller_mu;
	Mutexdef r_mu;
	int var_connectionsconnections = -2; // opt var_connectionsconnections
	int var_resourcesresources = -2; // opt var_resourcesresources
	run mutexMonitor(r_mu);
	run mutexMonitor(r_controller_mu);
	

	if
	:: var_resources-1 != -3 -> 
				for(i : 0.. var_resources-1) {
			for10: skip;
			run AddInProgressResource219(r_controller_mu,r_mu,child_AddInProgressResource2190);
			child_AddInProgressResource2190?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run AddInProgressResource219(r_controller_mu,r_mu,child_AddInProgressResource2191);
			child_AddInProgressResource2191?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	

	if
	:: var_connections-1 != -3 -> 
				for(i : 0.. var_connections-1) {
			for20: skip;
			run processEvent316(r_controller_mu,r_mu,child_processEvent3162);
			child_processEvent3162?0;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			run processEvent316(r_controller_mu,r_mu,child_processEvent3163);
			child_processEvent3163?0;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	run AddInProgressResource219(r_controller_mu,r_mu,child_AddInProgressResource2194);
	child_AddInProgressResource2194?0;
	run processEvent316(r_controller_mu,r_mu,child_processEvent3165);
	child_processEvent3165?0;
	run RegisterDisconnect349(r_controller_mu,r_mu,not_found_115,child_RegisterDisconnect3496);
	child_RegisterDisconnect3496?0;
	run buildReport147(r_controller_mu,r_mu,child_buildReport1477);
	child_buildReport1477?0;
	run removeCompletedResource192(r_controller_mu,r_mu,not_found_118,child_removeCompletedResource1928);
	child_removeCompletedResource1928?0;
	stop_process: skip;
	child!0
}
proctype AddInProgressResource219(Mutexdef r_controller_mu;Mutexdef r_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	r_mu.Lock!false;
		defer1: skip;
	r_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype processEvent316(Mutexdef r_controller_mu;Mutexdef r_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_deleteKeyFromReverseMap3372 = [1] of {int};
	r_mu.Lock!false;
	run deleteKeyFromReverseMap337(r_controller_mu,r_mu,child_deleteKeyFromReverseMap3372);
	child_deleteKeyFromReverseMap3372?0;
		defer1: skip;
	r_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype deleteKeyFromReverseMap337(Mutexdef r_controller_mu;Mutexdef r_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype RegisterDisconnect349(Mutexdef r_controller_mu;Mutexdef r_mu;int types;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_deleteKeyFromReverseMap3376 = [1] of {int};
	chan child_deleteKeyFromReverseMap3377 = [1] of {int};
	r_mu.Lock!false;
	

	if
	:: var_types-1 != -3 -> 
				for(i : 0.. var_types-1) {
			for30: skip;
			run deleteKeyFromReverseMap337(r_controller_mu,r_mu,child_deleteKeyFromReverseMap3376);
			child_deleteKeyFromReverseMap3376?0;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for31: skip;
			run deleteKeyFromReverseMap337(r_controller_mu,r_mu,child_deleteKeyFromReverseMap3377);
			child_deleteKeyFromReverseMap3377?0;
			for31_end: skip
		:: true -> 
			break
		od;
		for31_exit: skip
	fi;
		defer1: skip;
	r_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype buildReport147(Mutexdef r_controller_mu;Mutexdef r_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_r_reverseStatusr_reverseStatus = -2; // opt var_r_reverseStatusr_reverseStatus
	int var_r_inProgressResourcesr_inProgressResources = -2; // opt var_r_inProgressResourcesr_inProgressResources
	r_mu.RLock!false;
	goto defer1;
		defer1: skip;
	r_mu.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype removeCompletedResource192(Mutexdef r_controller_mu;Mutexdef r_mu;int completedResources;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_toDeletetoDelete = -2; // opt var_toDeletetoDelete
	r_mu.Lock!false;
		defer1: skip;
	r_mu.Unlock!false;
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

