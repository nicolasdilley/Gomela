#define not_found_248  -2
#define not_found_265  -2
#define not_found_286  -2
#define not_found_297  -2

// https://github.com/dgraph-io/dgraph/blob/master/worker/worker_test.go#L245
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestProcessTaskIndexMLayer2450 = [1] of {int};
	run TestProcessTaskIndexMLayer245(child_TestProcessTaskIndexMLayer2450)
stop_process:skip
}

proctype TestProcessTaskIndexMLayer245(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runQuery2079 = [1] of {int};
	chan child_runQuery2078 = [1] of {int};
	chan child_setClusterEdge837 = [1] of {int};
	chan child_delClusterEdge896 = [1] of {int};
	chan child_delClusterEdge895 = [1] of {int};
	chan child_delClusterEdge894 = [1] of {int};
	chan child_runQuery2073 = [1] of {int};
	chan child_setClusterEdge832 = [1] of {int};
	chan child_setClusterEdge831 = [1] of {int};
	chan child_runQuery2070 = [1] of {int};
	Mutexdef dg_jwtMutex;
	run mutexMonitor(dg_jwtMutex);
	run runQuery207(dg_jwtMutex,not_found_248,child_runQuery2070);
	child_runQuery2070?0;
	run setClusterEdge83(dg_jwtMutex,child_setClusterEdge831);
	child_setClusterEdge831?0;
	run setClusterEdge83(dg_jwtMutex,child_setClusterEdge832);
	child_setClusterEdge832?0;
	run runQuery207(dg_jwtMutex,not_found_265,child_runQuery2073);
	child_runQuery2073?0;
	run delClusterEdge89(dg_jwtMutex,child_delClusterEdge894);
	child_delClusterEdge894?0;
	run delClusterEdge89(dg_jwtMutex,child_delClusterEdge895);
	child_delClusterEdge895?0;
	run delClusterEdge89(dg_jwtMutex,child_delClusterEdge896);
	child_delClusterEdge896?0;
	run setClusterEdge83(dg_jwtMutex,child_setClusterEdge837);
	child_setClusterEdge837?0;
	run runQuery207(dg_jwtMutex,not_found_286,child_runQuery2078);
	child_runQuery2078?0;
	run runQuery207(dg_jwtMutex,not_found_297,child_runQuery2079);
	child_runQuery2079?0;
	stop_process: skip;
	child!0
}
proctype runQuery207(Mutexdef dg_jwtMutex;int uids;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RetryQuery1860 = [1] of {int};
	run RetryQuery186(dg_jwtMutex,child_RetryQuery1860);
	child_RetryQuery1860?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype RetryQuery186(Mutexdef dg_jwtMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype setClusterEdge83(Mutexdef dg_jwtMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RetryMutation2331 = [1] of {int};
	run RetryMutation233(dg_jwtMutex,child_RetryMutation2331);
	child_RetryMutation2331?0;
	stop_process: skip;
	child!0
}
proctype RetryMutation233(Mutexdef dg_jwtMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype delClusterEdge89(Mutexdef dg_jwtMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RetryMutation2334 = [1] of {int};
	run RetryMutation233(dg_jwtMutex,child_RetryMutation2334);
	child_RetryMutation2334?0;
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

