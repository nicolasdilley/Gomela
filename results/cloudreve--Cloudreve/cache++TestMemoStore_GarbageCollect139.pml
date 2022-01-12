// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/cloudreve/Cloudreve/blob//pkg/cache/memo_test.go#L139
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMemoStore_GarbageCollect1390 = [1] of {int};
	run TestMemoStore_GarbageCollect139(child_TestMemoStore_GarbageCollect1390);
	run receiver(child_TestMemoStore_GarbageCollect1390)
stop_process:skip
}

proctype TestMemoStore_GarbageCollect139(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get782 = [1] of {int};
	chan child_GarbageCollect521 = [1] of {int};
	chan child_Set720 = [1] of {int};
	Mutexdef store_Store_mu;
	run mutexMonitor(store_Store_mu);
	run Set72(store_Store_mu,child_Set720);
	child_Set720?0;
	run GarbageCollect52(store_Store_mu,child_GarbageCollect521);
	child_GarbageCollect521?0;
	run Get78(store_Store_mu,child_Get782);
	child_Get782?0;
	stop_process: skip;
	child!0
}
proctype Set72(Mutexdef store_Store_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GarbageCollect52(Mutexdef store_Store_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Get78(Mutexdef store_Store_mu;chan child) {
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

