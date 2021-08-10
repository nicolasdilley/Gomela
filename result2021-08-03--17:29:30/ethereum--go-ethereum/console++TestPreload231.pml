// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/console/console_test.go#L231
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPreload2310 = [1] of {int};
	run TestPreload231(child_TestPreload2310);
	run receiver(child_TestPreload2310)
stop_process:skip
}

proctype TestPreload231(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1510 = [1] of {int};
	Mutexdef tester_ethereum_lock;
	Mutexdef tester_stack_lock;
	Mutexdef tester_stack_startStopLock;
	run mutexMonitor(tester_stack_startStopLock);
	run mutexMonitor(tester_stack_lock);
	run mutexMonitor(tester_ethereum_lock);
		defer1: skip;
	run Close151(tester_ethereum_lock,tester_stack_lock,tester_stack_startStopLock,child_Close1510);
	child_Close1510?0;
	stop_process: skip;
	child!0
}
proctype Close151(Mutexdef env_ethereum_lock;Mutexdef env_stack_lock;Mutexdef env_stack_startStopLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

