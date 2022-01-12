// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob//vault/barrier_aes_gcm_test.go#L90
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAESGCMBarrier_Upgrade900 = [1] of {int};
	run TestAESGCMBarrier_Upgrade90(child_TestAESGCMBarrier_Upgrade900);
	run receiver(child_TestAESGCMBarrier_Upgrade900)
stop_process:skip
}

proctype TestAESGCMBarrier_Upgrade90(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_testBarrier_Upgrade4380 = [1] of {int};
	Mutexdef b2_cacheLock;
	Mutexdef b2_l;
	Mutexdef b1_cacheLock;
	Mutexdef b1_l;
	run mutexMonitor(b1_l);
	run mutexMonitor(b1_cacheLock);
	run mutexMonitor(b2_l);
	run mutexMonitor(b2_cacheLock);
	run testBarrier_Upgrade438(b1_cacheLock,b1_l,b1_cacheLock,b1_l,child_testBarrier_Upgrade4380);
	child_testBarrier_Upgrade4380?0;
	stop_process: skip;
	child!0
}
proctype testBarrier_Upgrade438(Mutexdef b1_cacheLock;Mutexdef b1_l;Mutexdef b2_cacheLock;Mutexdef b2_l;chan child) {
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

