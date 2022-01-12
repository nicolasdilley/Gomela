// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/dgraph-io/dgraph/blob//worker/worker_test.go#L175
#define not_found_178  -2 // opt uids line 207
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestProcessTask1750 = [1] of {int};
	run TestProcessTask175(child_TestProcessTask1750);
	run receiver(child_TestProcessTask1750)
stop_process:skip
}

proctype TestProcessTask175(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runQuery2070 = [1] of {int};
	Mutexdef dg_jwtMutex;
	run mutexMonitor(dg_jwtMutex);
	run runQuery207(dg_jwtMutex,not_found_178,child_runQuery2070);
	child_runQuery2070?0;
	stop_process: skip;
	child!0
}
proctype runQuery207(Mutexdef dg_jwtMutex;int var_uids;chan child) {
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

