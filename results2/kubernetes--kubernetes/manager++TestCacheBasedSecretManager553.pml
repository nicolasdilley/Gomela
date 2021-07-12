// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/kubelet/util/manager/cache_based_manager_test.go#L553
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCacheBasedSecretManager5530 = [1] of {int};
	run TestCacheBasedSecretManager553(child_TestCacheBasedSecretManager5530);
	run receiver(child_TestCacheBasedSecretManager5530)
stop_process:skip
}

proctype TestCacheBasedSecretManager553(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkObject441 = [1] of {int};
	chan child_checkObject442 = [1] of {int};
	chan child_checkObject443 = [1] of {int};
	chan child_checkObject444 = [1] of {int};
	chan child_newCacheBasedSecretManager830 = [1] of {int};
	Mutexdef store_lock;
	run mutexMonitor(store_lock);
	run newCacheBasedSecretManager83(store_lock,child_newCacheBasedSecretManager830);
	child_newCacheBasedSecretManager830?0;
	

	if
	:: 3-1 != -3 -> 
				for(i : 0.. 3-1) {
			for10: skip;
			

			if
			:: 9-1 != -3 -> 
								for(i : 0.. 9-1) {
					for11: skip;
					run checkObject44(store_lock,child_checkObject441);
					child_checkObject441?0;
					for11_end: skip
				};
				for11_exit: skip
			:: else -> 
				do
				:: true -> 
					for12: skip;
					run checkObject44(store_lock,child_checkObject442);
					child_checkObject442?0;
					for12_end: skip
				:: true -> 
					break
				od;
				for12_exit: skip
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			

			if
			:: 9-1 != -3 -> 
								for(i : 0.. 9-1) {
					for14: skip;
					run checkObject44(store_lock,child_checkObject443);
					child_checkObject443?0;
					for14_end: skip
				};
				for14_exit: skip
			:: else -> 
				do
				:: true -> 
					for15: skip;
					run checkObject44(store_lock,child_checkObject444);
					child_checkObject444?0;
					for15_end: skip
				:: true -> 
					break
				od;
				for15_exit: skip
			fi;
			for13_end: skip
		:: true -> 
			break
		od;
		for13_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype newCacheBasedSecretManager83(Mutexdef store_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewCacheBasedManager2660 = [1] of {int};
	run NewCacheBasedManager266(store_lock,child_NewCacheBasedManager2660);
	child_NewCacheBasedManager2660?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewCacheBasedManager266(Mutexdef objectStore_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checkObject44(Mutexdef store_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get1551 = [1] of {int};
	run Get155(store_lock,child_Get1551);
	child_Get1551?0;
	stop_process: skip;
	child!0
}
proctype Get155(Mutexdef s_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_isObjectFresh1471 = [1] of {int};
	s_lock.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	s_lock.Unlock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run isObjectFresh147(s_lock,child_isObjectFresh1471);
	child_isObjectFresh1471?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	:: true;
	fi;
	goto defer1;
	stop_process: skip;
	child!0
}
proctype isObjectFresh147(Mutexdef s_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
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

