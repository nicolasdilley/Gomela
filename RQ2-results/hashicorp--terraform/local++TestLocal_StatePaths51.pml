
// https://github.com/hashicorp/terraform/blob/master/backend/local/backend_test.go#L51
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLocal_StatePaths510 = [1] of {int};
	run TestLocal_StatePaths51(child_TestLocal_StatePaths510)
stop_process:skip
}

proctype TestLocal_StatePaths51(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StatePaths3821 = [1] of {int};
	chan child_StatePaths3820 = [1] of {int};
	Mutexdef b_opLock;
	run mutexMonitor(b_opLock);
	run StatePaths382(b_opLock,child_StatePaths3820);
	child_StatePaths3820?0;
	run StatePaths382(b_opLock,child_StatePaths3821);
	child_StatePaths3821?0;
	stop_process: skip;
	child!0
}
proctype StatePaths382(Mutexdef b_opLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_stateWorkspaceDir4770 = [1] of {int};
	

	if
	:: true -> 
		run stateWorkspaceDir477(b_opLock,child_stateWorkspaceDir4770);
		child_stateWorkspaceDir4770?0
	:: true;
	fi;
	

	if
	:: true;
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype stateWorkspaceDir477(Mutexdef b_opLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

