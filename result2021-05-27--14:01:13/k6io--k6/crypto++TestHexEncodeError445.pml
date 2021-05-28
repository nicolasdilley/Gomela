// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/k6io/k6/blob/af1e032ebf949cde092d4a2eddb78528ea0a5864/js/modules/k6/crypto/crypto_test.go#L445
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestHexEncodeError4450 = [1] of {int};
	run TestHexEncodeError445(child_TestHexEncodeError4450);
	run receiver(child_TestHexEncodeError4450)
stop_process:skip
}

proctype TestHexEncodeError445(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WithRuntime370 = [1] of {int};
	Mutexdef rt_vm_interruptLock;
	run mutexMonitor(rt_vm_interruptLock);
	run WithRuntime37(rt_vm_interruptLock,child_WithRuntime370);
	child_WithRuntime370?0;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype WithRuntime37(Mutexdef rt_vm_interruptLock;chan child) {
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

