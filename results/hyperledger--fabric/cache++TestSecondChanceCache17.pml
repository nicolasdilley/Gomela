// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//msp/cache/second_chance_test.go#L17
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSecondChanceCache170 = [1] of {int};
	run TestSecondChanceCache17(child_TestSecondChanceCache170);
	run receiver(child_TestSecondChanceCache170)
stop_process:skip
}

proctype TestSecondChanceCache17(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get578 = [1] of {int};
	chan child_get577 = [1] of {int};
	chan child_get576 = [1] of {int};
	chan child_add725 = [1] of {int};
	chan child_get574 = [1] of {int};
	chan child_add723 = [1] of {int};
	chan child_get572 = [1] of {int};
	chan child_add721 = [1] of {int};
	chan child_add720 = [1] of {int};
	Mutexdef cache_rwlock;
	run mutexMonitor(cache_rwlock);
	run add72(cache_rwlock,child_add720);
	child_add720?0;
	run add72(cache_rwlock,child_add721);
	child_add721?0;
	run get57(cache_rwlock,child_get572);
	child_get572?0;
	run add72(cache_rwlock,child_add723);
	child_add723?0;
	run get57(cache_rwlock,child_get574);
	child_get574?0;
	run add72(cache_rwlock,child_add725);
	child_add725?0;
	run get57(cache_rwlock,child_get576);
	child_get576?0;
	run get57(cache_rwlock,child_get577);
	child_get577?0;
	run get57(cache_rwlock,child_get578);
	child_get578?0;
	stop_process: skip;
	child!0
}
proctype add72(Mutexdef cache_rwlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	cache_rwlock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
		defer1: skip;
	cache_rwlock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype get57(Mutexdef cache_rwlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	cache_rwlock.RLock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	cache_rwlock.RUnlock!false;
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

