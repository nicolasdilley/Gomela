// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/worker/diff_utils_test.go#L30
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestOrderedColumns300 = [1] of {int};
	run TestOrderedColumns30(child_TestOrderedColumns300);
	run receiver(child_TestOrderedColumns300)
stop_process:skip
}

proctype TestOrderedColumns30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_orderedColumns1930 = [1] of {int};
	Mutexdef input_state_atomicMessageInfo_initMu;
	run mutexMonitor(input_state_atomicMessageInfo_initMu);
	run orderedColumns193(input_state_atomicMessageInfo_initMu,child_orderedColumns1930);
	child_orderedColumns1930?0;
	stop_process: skip;
	child!0
}
proctype orderedColumns193(Mutexdef td_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_orderedColumnsHelper2030 = [1] of {int};
	run orderedColumnsHelper203(td_state_atomicMessageInfo_initMu,child_orderedColumnsHelper2030);
	child_orderedColumnsHelper2030?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype orderedColumnsHelper203(Mutexdef td_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_td_PrimaryKeyColumns = -2; // opt var_td_PrimaryKeyColumns
	int var_td_Columns = -2; // opt var_td_Columns
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

