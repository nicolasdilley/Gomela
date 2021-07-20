// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/k6io/k6/blob/af1e032ebf949cde092d4a2eddb78528ea0a5864/js/common/bridge_test.go#L283
#define not_found_285  -2 // opt data line 120
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBindToGlobal2830 = [1] of {int};
	run TestBindToGlobal283(child_TestBindToGlobal2830);
	run receiver(child_TestBindToGlobal2830)
stop_process:skip
}

proctype TestBindToGlobal283(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_BindToGlobal1200 = [1] of {int};
	Mutexdef rt_vm_interruptLock;
	run mutexMonitor(rt_vm_interruptLock);
	run BindToGlobal120(rt_vm_interruptLock,not_found_285,child_BindToGlobal1200);
	child_BindToGlobal1200?0;
	stop_process: skip;
	child!0
}
proctype BindToGlobal120(Mutexdef rt_vm_interruptLock;int data;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_keyskeys = -2; // opt var_keyskeys
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

