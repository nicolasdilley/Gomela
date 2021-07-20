// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/dapr/dapr/blob/ab83d3535478699a2f2707d9ed9008f78c155d6d/pkg/placement/raft/fsm_test.go#L92
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPlacementState920 = [1] of {int};
	run TestPlacementState92(child_TestPlacementState920);
	run receiver(child_TestPlacementState920)
stop_process:skip
}

proctype TestPlacementState92(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PlacementState581 = [1] of {int};
	chan child_Apply1330 = [1] of {int};
	Mutexdef fsm_stateLock;
	run mutexMonitor(fsm_stateLock);
	run Apply133(fsm_stateLock,child_Apply1330);
	child_Apply1330?0;
	run PlacementState58(fsm_stateLock,child_PlacementState581);
	child_PlacementState581?0;
	stop_process: skip;
	child!0
}
proctype Apply133(Mutexdef c_stateLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_upsertMember1080 = [1] of {int};
	chan child_removeMember1201 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run upsertMember108(c_stateLock,child_upsertMember1080);
		child_upsertMember1080?0
	:: true -> 
		run removeMember120(c_stateLock,child_removeMember1201);
		child_removeMember1201?0
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
proctype upsertMember108(Mutexdef c_stateLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_stateLock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	c_stateLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype removeMember120(Mutexdef c_stateLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_stateLock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	c_stateLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype PlacementState58(Mutexdef c_stateLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_loadMaploadMap = -2; // opt var_loadMaploadMap
	int var_hostshosts = -2; // opt var_hostshosts
	int var_entriesentries = -2; // opt var_entriesentries
	c_stateLock.RLock!false;
	goto defer1;
		defer1: skip;
	c_stateLock.RUnlock!false;
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

