// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/vault/barrier_aes_gcm_test.go#L50
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAESGCMBarrier_Rotate500 = [1] of {int};
	run TestAESGCMBarrier_Rotate50(child_TestAESGCMBarrier_Rotate500);
	run receiver(child_TestAESGCMBarrier_Rotate500)
stop_process:skip
}

proctype TestAESGCMBarrier_Rotate50(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_testBarrier_Rotate2520 = [1] of {int};
	Mutexdef b_cacheLock;
	Mutexdef b_l;
	run mutexMonitor(b_l);
	run mutexMonitor(b_cacheLock);
	run testBarrier_Rotate252(b_cacheLock,b_l,child_testBarrier_Rotate2520);
	child_testBarrier_Rotate2520?0;
	stop_process: skip;
	child!0
}
proctype testBarrier_Rotate252(Mutexdef b_cacheLock;Mutexdef b_l;chan child) {
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

