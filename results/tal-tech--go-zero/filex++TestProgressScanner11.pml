// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/filex/progressscanner_test.go#L11
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestProgressScanner110 = [1] of {int};
	run TestProgressScanner11(child_TestProgressScanner110);
	run receiver(child_TestProgressScanner110)
stop_process:skip
}

proctype TestProgressScanner11(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewProgressScanner210 = [1] of {int};
	Mutexdef bar_mu;
	Mutexdef bar_finishOnce_m;
	run mutexMonitor(bar_finishOnce_m);
	run mutexMonitor(bar_mu);
	run NewProgressScanner21(bar_finishOnce_m,bar_mu,child_NewProgressScanner210);
	child_NewProgressScanner210?0;
	stop_process: skip;
	child!0
}
proctype NewProgressScanner21(Mutexdef bar_finishOnce_m;Mutexdef bar_mu;chan child) {
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

