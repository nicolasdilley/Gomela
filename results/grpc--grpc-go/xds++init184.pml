
// https://github.com/grpc/grpc-go/blob/master/xds/server_test.go#L184
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_init1840 = [1] of {int};
	run init184(child_init1840)
stop_process:skip
}

proctype init184(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cfg2_pStore_mu;
	Mutexdef cfg1_pStore_mu;
	run mutexMonitor(cfg1_pStore_mu);
	run mutexMonitor(cfg2_pStore_mu);
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

