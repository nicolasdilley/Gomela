// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-delve/delve/blob/9ed4ba0c49d916bf128ecf69fcc109235aeed075/pkg/terminal/command_test.go#L780
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig7800 = [1] of {int};
	run TestConfig780(child_TestConfig7800);
	run receiver(child_TestConfig7800)
stop_process:skip
}

proctype TestConfig780(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef term_quittingMutex;
	Mutexdef term_longCommandMu;
	Mutexdef term_starlarkEnv_contextMu;
	run mutexMonitor(term_starlarkEnv_contextMu);
	run mutexMonitor(term_longCommandMu);
	run mutexMonitor(term_quittingMutex);
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

