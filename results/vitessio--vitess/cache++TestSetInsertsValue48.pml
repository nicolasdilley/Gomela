// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/cache/lru_cache_test.go#L48
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSetInsertsValue480 = [1] of {int};
	run TestSetInsertsValue48(child_TestSetInsertsValue480);
	run receiver(child_TestSetInsertsValue480)
stop_process:skip
}

proctype TestSetInsertsValue48(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Items1892 = [1] of {int};
	chan child_Get761 = [1] of {int};
	chan child_Set890 = [1] of {int};
	Mutexdef cache_mu;
	run mutexMonitor(cache_mu);
	run Set89(cache_mu,child_Set890);
	child_Set890?0;
	run Get76(cache_mu,child_Get761);
	child_Get761?0;
	run Items189(cache_mu,child_Items1892);
	child_Items1892?0;
	stop_process: skip;
	child!0
}
proctype Set89(Mutexdef lru_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_updateInplace2010 = [1] of {int};
	chan child_addNew2161 = [1] of {int};
	lru_mu.Lock!false;
	

	if
	:: true -> 
		run updateInplace201(lru_mu,child_updateInplace2010);
		child_updateInplace2010?0
	:: true -> 
		run addNew216(lru_mu,child_addNew2161);
		child_addNew2161?0
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
	chan child_checkCapacity2241 = [1] of {int};
	chan child_moveToFront2110 = [1] of {int};
	run moveToFront211(lru_mu,child_moveToFront2110);
	child_moveToFront2110?0;
	run checkCapacity224(lru_mu,child_checkCapacity2241);
	child_checkCapacity2241?0;
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
proctype checkCapacity224(Mutexdef lru_mu;chan child) {
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
	chan child_checkCapacity2241 = [1] of {int};
	run checkCapacity224(lru_mu,child_checkCapacity2241);
	child_checkCapacity2241?0;
	stop_process: skip;
	child!0
}
proctype Get76(Mutexdef lru_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_moveToFront2111 = [1] of {int};
	lru_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run moveToFront211(lru_mu,child_moveToFront2111);
	child_moveToFront2111?0;
	goto defer1;
		defer1: skip;
	lru_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Items189(Mutexdef lru_mu;chan child) {
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

