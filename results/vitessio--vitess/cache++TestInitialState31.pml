// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/cache/lru_cache_test.go#L31
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInitialState310 = [1] of {int};
	run TestInitialState31(child_TestInitialState310);
	run receiver(child_TestInitialState310)
stop_process:skip
}

proctype TestInitialState31(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Evictions1673 = [1] of {int};
	chan child_MaxCapacity1602 = [1] of {int};
	chan child_UsedCapacity1551 = [1] of {int};
	chan child_Len1340 = [1] of {int};
	Mutexdef cache_mu;
	run mutexMonitor(cache_mu);
	run Len134(cache_mu,child_Len1340);
	child_Len1340?0;
	run UsedCapacity155(cache_mu,child_UsedCapacity1551);
	child_UsedCapacity1551?0;
	run MaxCapacity160(cache_mu,child_MaxCapacity1602);
	child_MaxCapacity1602?0;
	run Evictions167(cache_mu,child_Evictions1673);
	child_Evictions1673?0;
	stop_process: skip;
	child!0
}
proctype Len134(Mutexdef lru_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	lru_mu.Lock!false;
	goto defer1;
		defer1: skip;
	lru_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype UsedCapacity155(Mutexdef lru_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype MaxCapacity160(Mutexdef lru_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	lru_mu.Lock!false;
	goto defer1;
		defer1: skip;
	lru_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Evictions167(Mutexdef lru_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	lru_mu.Lock!false;
	goto defer1;
		defer1: skip;
	lru_mu.Unlock!false;
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

