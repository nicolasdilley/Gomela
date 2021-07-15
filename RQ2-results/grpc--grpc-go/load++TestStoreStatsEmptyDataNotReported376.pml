#define not_found_421  -2
#define not_found_442  -2

// https://github.com/grpc/grpc-go/blob/master/xds/internal/client/load/store_test.go#L376
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestStoreStatsEmptyDataNotReported3760 = [1] of {int};
	run TestStoreStatsEmptyDataNotReported376(child_TestStoreStatsEmptyDataNotReported3760)
stop_process:skip
}

proctype TestStoreStatsEmptyDataNotReported376(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stats631 = [1] of {int};
	chan child_Stats630 = [1] of {int};
	Mutexdef store_mu;
	run mutexMonitor(store_mu);
	run Stats63(store_mu,not_found_421,child_Stats630);
	child_Stats630?0;
	run Stats63(store_mu,not_found_442,child_Stats631);
	child_Stats631?0;
	stop_process: skip;
	child!0
}
proctype Stats63(Mutexdef s_mu;int clusterNames;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		s_mu.Unlock!false;
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

