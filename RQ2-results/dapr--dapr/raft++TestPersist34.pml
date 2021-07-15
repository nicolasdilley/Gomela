
// https://github.com/dapr/dapr/blob/master/pkg/placement/raft/snapshot_test.go#L34
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPersist340 = [1] of {int};
	run TestPersist34(child_TestPersist340)
stop_process:skip
}

proctype TestPersist34(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Snapshot1651 = [1] of {int};
	chan child_Apply1330 = [1] of {int};
	Mutexdef fsm_stateLock;
	run mutexMonitor(fsm_stateLock);
	run Apply133(fsm_stateLock,child_Apply1330);
	child_Apply1330?0;
	run Snapshot165(fsm_stateLock,child_Snapshot1651);
	child_Snapshot1651?0;
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
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		c_stateLock.Unlock!false;
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
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		c_stateLock.Unlock!false;
	child!0
}
proctype Snapshot165(Mutexdef c_stateLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

