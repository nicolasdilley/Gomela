// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//msp/cache/second_chance_test.go#L52
#define def_var_workers57  ?? // mand workers line 57
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSecondChanceCacheConcurrent520 = [1] of {int};
	run TestSecondChanceCacheConcurrent52(child_TestSecondChanceCacheConcurrent520);
	run receiver(child_TestSecondChanceCacheConcurrent520)
stop_process:skip
}

proctype TestSecondChanceCacheConcurrent52(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestSecondChanceCacheConcurrent67560 = [1] of {int};
	Wgdef wg;
	Mutexdef cache_rwlock;
	int var_workers = def_var_workers57; // mand var_workers
	run mutexMonitor(cache_rwlock);
	run wgMonitor(wg);
	wg.update!var_workers;
		for(i : 0.. var_workers-1) {
		for10: skip;
		run AnonymousTestSecondChanceCacheConcurrent6756(wg,cache_rwlock,child_AnonymousTestSecondChanceCacheConcurrent67560);
		run receiver(child_AnonymousTestSecondChanceCacheConcurrent67560);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestSecondChanceCacheConcurrent6756(Wgdef wg;Mutexdef cache_rwlock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get5715 = [1] of {int};
	chan child_add7214 = [1] of {int};
	chan child_get5713 = [1] of {int};
	chan child_add7212 = [1] of {int};
	chan child_get5711 = [1] of {int};
	chan child_add7210 = [1] of {int};
	chan child_get579 = [1] of {int};
	chan child_add728 = [1] of {int};
	chan child_get577 = [1] of {int};
	chan child_add726 = [1] of {int};
	chan child_get575 = [1] of {int};
	chan child_add724 = [1] of {int};
	chan child_get573 = [1] of {int};
	chan child_add722 = [1] of {int};
	chan child_get571 = [1] of {int};
	chan child_add720 = [1] of {int};
	

	if
	:: 0 != -2 && 10000-1 != -3 -> 
				for(i : 0.. 10000-1) {
			for14: skip;
			run add72(cache_rwlock,child_add728);
			child_add728?0;
			run get57(cache_rwlock,child_get579);
			child_get579?0;
			run add72(cache_rwlock,child_add7210);
			child_add7210?0;
			run get57(cache_rwlock,child_get5711);
			child_get5711?0;
			run add72(cache_rwlock,child_add7212);
			child_add7212?0;
			run get57(cache_rwlock,child_get5713);
			child_get5713?0;
			run add72(cache_rwlock,child_add7214);
			child_add7214?0;
			run get57(cache_rwlock,child_get5715);
			child_get5715?0;
			for14_end: skip
		};
		for14_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run add72(cache_rwlock,child_add720);
			child_add720?0;
			run get57(cache_rwlock,child_get571);
			child_get571?0;
			run add72(cache_rwlock,child_add722);
			child_add722?0;
			run get57(cache_rwlock,child_get573);
			child_get573?0;
			run add72(cache_rwlock,child_add724);
			child_add724?0;
			run get57(cache_rwlock,child_get575);
			child_get575?0;
			run add72(cache_rwlock,child_add726);
			child_add726?0;
			run get57(cache_rwlock,child_get577);
			child_get577?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	wg.update!-1;
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
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

