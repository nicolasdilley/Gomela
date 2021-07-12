// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/rpc/jsonrpc/all_test.go#L304
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_myPipe3040 = [1] of {int};
	run myPipe304(child_myPipe3040);
	run receiver(child_myPipe3040)
stop_process:skip
}

proctype myPipe304(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef w2_p_wrMu;
	Mutexdef r2_p_wrMu;
	Mutexdef w1_p_wrMu;
	Mutexdef r1_p_wrMu;
	run mutexMonitor(r1_p_wrMu);
	run mutexMonitor(w1_p_wrMu);
	run mutexMonitor(r2_p_wrMu);
	run mutexMonitor(w2_p_wrMu);
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

