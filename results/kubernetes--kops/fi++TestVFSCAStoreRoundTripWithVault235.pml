// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kops/blob//upup/pkg/fi/vfs_castore_test.go#L235
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestVFSCAStoreRoundTripWithVault2350 = [1] of {int};
	run TestVFSCAStoreRoundTripWithVault235(child_TestVFSCAStoreRoundTripWithVault2350);
	run receiver(child_TestVFSCAStoreRoundTripWithVault2350)
stop_process:skip
}

proctype TestVFSCAStoreRoundTripWithVault235(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StoreKeypair5380 = [1] of {int};
	Mutexdef s_mutex;
	int var_paths = -2; // opt var_paths
	run mutexMonitor(s_mutex);
	run StoreKeypair538(s_mutex,child_StoreKeypair5380);
	child_StoreKeypair5380?0;
	stop_process: skip;
	child!0
}
proctype StoreKeypair538(Mutexdef c_mutex;chan child) {
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

