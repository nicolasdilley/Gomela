
// https://github.com/cli/cli/blob/master/pkg/cmd/api/api_test.go#L1063
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_processResponse_template10630 = [1] of {int};
	run Test_processResponse_template1063(child_Test_processResponse_template10630)
stop_process:skip
}

proctype Test_processResponse_template1063(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef io_pagerProcess_sigMu;
	Mutexdef io_progressIndicator_mu;
	run mutexMonitor(io_progressIndicator_mu);
	run mutexMonitor(io_pagerProcess_sigMu);
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

