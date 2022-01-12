// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/cache/lru_cache_test.go#L130
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGetNonExistent1300 = [1] of {int};
	run TestGetNonExistent130(child_TestGetNonExistent1300);
	run receiver(child_TestGetNonExistent1300)
stop_process:skip
}

proctype TestGetNonExistent130(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get760 = [1] of {int};
	Mutexdef cache_mu;
	run mutexMonitor(cache_mu);
	run Get76(cache_mu,child_Get760);
	child_Get760?0;
	stop_process: skip;
	child!0
}
proctype Get76(Mutexdef lru_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_moveToFront2110 = [1] of {int};
	lru_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run moveToFront211(lru_mu,child_moveToFront2110);
	child_moveToFront2110?0;
	goto defer1;
		defer1: skip;
	lru_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype moveToFront211(Mutexdef lru_mu;chan child) {
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

