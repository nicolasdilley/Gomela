// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/consul/blob/8d6cbe72813779f60ac24d119cc311c21003f4ce/command/kv/del/kv_delete_test.go#L20
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestKVDeleteCommand_Validation200 = [1] of {int};
	run TestKVDeleteCommand_Validation20(child_TestKVDeleteCommand_Validation200);
	run receiver(child_TestKVDeleteCommand_Validation200)
stop_process:skip
}

proctype TestKVDeleteCommand_Validation20(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_New120 = [1] of {int};
	Mutexdef ui_once_m;
	int var_cases = -2; // opt var_cases
	run mutexMonitor(ui_once_m);
	run New12(ui_once_m,child_New120);
	child_New120?0;
	stop_process: skip;
	child!0
}
proctype New12(Mutexdef ui_once_m;chan child) {
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

proctype receiver(chan c) {
c?0
}

