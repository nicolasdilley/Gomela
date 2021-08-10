// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/grpc/grpc-go/blob/ebd6aba6754d073a696e5727158cd0c917ce1019/xds/internal/client/load/store_test.go#L278
#define not_found_319  -2 // opt clusterNames line 63
#define not_found_368  -2 // opt clusterNames line 63
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStoreStats2780 = [1] of {int};
	run TestStoreStats278(child_TestStoreStats2780);
	run receiver(child_TestStoreStats2780)
stop_process:skip
}

proctype TestStoreStats278(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stats631 = [1] of {int};
	chan child_Stats630 = [1] of {int};
	Mutexdef store_mu;
	int var_testServices = -2; // opt var_testServices
	int var_testClusters = -2; // opt var_testClusters
	run mutexMonitor(store_mu);
	run Stats63(store_mu,not_found_319,child_Stats630);
	child_Stats630?0;
	run Stats63(store_mu,not_found_368,child_Stats631);
	child_Stats631?0;
	stop_process: skip;
	child!0
}
proctype Stats63(Mutexdef s_mu;int var_clusterNames;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_s_clusters = -2; // opt var_s_clusters
	s_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	s_mu.Unlock!false;
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

