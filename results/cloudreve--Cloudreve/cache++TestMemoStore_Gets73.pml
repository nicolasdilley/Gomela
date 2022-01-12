// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/cloudreve/Cloudreve/blob//pkg/cache/memo_test.go#L73
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMemoStore_Gets730 = [1] of {int};
	run TestMemoStore_Gets73(child_TestMemoStore_Gets730);
	run receiver(child_TestMemoStore_Gets730)
stop_process:skip
}

proctype TestMemoStore_Gets73(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Set723 = [1] of {int};
	chan child_Set722 = [1] of {int};
	chan child_Set721 = [1] of {int};
	chan child_Set720 = [1] of {int};
	Mutexdef store_Store_mu;
	run mutexMonitor(store_Store_mu);
	run Set72(store_Store_mu,child_Set720);
	child_Set720?0;
	run Set72(store_Store_mu,child_Set721);
	child_Set721?0;
	run Set72(store_Store_mu,child_Set722);
	child_Set722?0;
	run Set72(store_Store_mu,child_Set723);
	child_Set723?0;
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

