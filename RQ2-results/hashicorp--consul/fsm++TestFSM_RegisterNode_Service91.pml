
// https://github.com/hashicorp/consul/blob/master/agent/consul/fsm/commands_oss_test.go#L91
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFSM_RegisterNode_Service910 = [1] of {int};
	run TestFSM_RegisterNode_Service91(child_TestFSM_RegisterNode_Service910)
stop_process:skip
}

proctype TestFSM_RegisterNode_Service91(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Apply1180 = [1] of {int};
	Mutexdef fsm_state_lockDelay_lock;
	Mutexdef fsm_state_db_db_writer;
	Mutexdef fsm_stateLock;
	run mutexMonitor(fsm_stateLock);
	run mutexMonitor(fsm_state_db_db_writer);
	run mutexMonitor(fsm_state_lockDelay_lock);
	run Apply118(fsm_stateLock,fsm_state_db_db_writer,fsm_state_lockDelay_lock,child_Apply1180);
	child_Apply1180?0;
	stop_process: skip;
	child!0
}
proctype Apply118(Mutexdef c_stateLock;Mutexdef c_state_db_db_writer;Mutexdef c_state_lockDelay_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

