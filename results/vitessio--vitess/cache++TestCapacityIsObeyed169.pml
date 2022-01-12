// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/cache/lru_cache_test.go#L169
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCapacityIsObeyed1690 = [1] of {int};
	run TestCapacityIsObeyed169(child_TestCapacityIsObeyed1690);
	run receiver(child_TestCapacityIsObeyed1690)
stop_process:skip
}

proctype TestCapacityIsObeyed169(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MaxCapacity16010 = [1] of {int};
	chan child_UsedCapacity1559 = [1] of {int};
	chan child_Len1348 = [1] of {int};
	chan child_Evictions1677 = [1] of {int};
	chan child_UsedCapacity1556 = [1] of {int};
	chan child_Set895 = [1] of {int};
	chan child_UsedCapacity1554 = [1] of {int};
	chan child_Set893 = [1] of {int};
	chan child_Set892 = [1] of {int};
	chan child_Set891 = [1] of {int};
	chan child_SetCapacity1430 = [1] of {int};
	Mutexdef cache_mu;
	run mutexMonitor(cache_mu);
	run SetCapacity143(cache_mu,child_SetCapacity1430);
	child_SetCapacity1430?0;
	run Set89(cache_mu,child_Set891);
	child_Set891?0;
	run Set89(cache_mu,child_Set892);
	child_Set892?0;
	run Set89(cache_mu,child_Set893);
	child_Set893?0;
	run UsedCapacity155(cache_mu,child_UsedCapacity1554);
	child_UsedCapacity1554?0;
	run Set89(cache_mu,child_Set895);
	child_Set895?0;
	run UsedCapacity155(cache_mu,child_UsedCapacity1556);
	child_UsedCapacity1556?0;
	run Evictions167(cache_mu,child_Evictions1677);
	child_Evictions1677?0;
	run Len134(cache_mu,child_Len1348);
	child_Len1348?0;
	run UsedCapacity155(cache_mu,child_UsedCapacity1559);
	child_UsedCapacity1559?0;
	run MaxCapacity160(cache_mu,child_MaxCapacity16010);
	child_MaxCapacity16010?0;
	stop_process: skip;
	child!0
}
proctype SetCapacity143(Mutexdef lru_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkCapacity2240 = [1] of {int};
	lru_mu.Lock!false;
	run checkCapacity224(lru_mu,child_checkCapacity2240);
	child_checkCapacity2240?0;
		defer1: skip;
	lru_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype checkCapacity224(Mutexdef lru_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Set89(Mutexdef lru_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_updateInplace2011 = [1] of {int};
	chan child_addNew2162 = [1] of {int};
	lru_mu.Lock!false;
	

	if
	:: true -> 
		run updateInplace201(lru_mu,child_updateInplace2011);
		child_updateInplace2011?0
	:: true -> 
		run addNew216(lru_mu,child_addNew2162);
		child_addNew2162?0
	fi;
	goto defer1;
		defer1: skip;
	lru_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype updateInplace201(Mutexdef lru_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkCapacity2242 = [1] of {int};
	chan child_moveToFront2111 = [1] of {int};
	run moveToFront211(lru_mu,child_moveToFront2111);
	child_moveToFront2111?0;
	run checkCapacity224(lru_mu,child_checkCapacity2242);
	child_checkCapacity2242?0;
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
proctype addNew216(Mutexdef lru_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkCapacity2242 = [1] of {int};
	run checkCapacity224(lru_mu,child_checkCapacity2242);
	child_checkCapacity2242?0;
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

