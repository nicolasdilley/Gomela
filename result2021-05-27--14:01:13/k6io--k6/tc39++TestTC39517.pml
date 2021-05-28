// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/k6io/k6/blob/af1e032ebf949cde092d4a2eddb78528ea0a5864/js/tc39/tc39_test.go#L517
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTC395170 = [1] of {int};
	run TestTC39517(child_TestTC395170);
	run receiver(child_TestTC395170)
stop_process:skip
}

proctype TestTC39517(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_init4020 = [1] of {int};
	Mutexdef ctx_errorsLock;
	Mutexdef ctx_benchLock;
	Mutexdef ctx_prgCacheLock;
	int bench = -2; // opt bench
	run mutexMonitor(ctx_prgCacheLock);
	run mutexMonitor(ctx_benchLock);
	run mutexMonitor(ctx_errorsLock);
	run init402(ctx_benchLock,ctx_errorsLock,ctx_prgCacheLock,child_init4020);
	child_init4020?0;
	stop_process: skip;
	child!0
}
proctype init402(Mutexdef ctx_benchLock;Mutexdef ctx_errorsLock;Mutexdef ctx_prgCacheLock;chan child) {
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

