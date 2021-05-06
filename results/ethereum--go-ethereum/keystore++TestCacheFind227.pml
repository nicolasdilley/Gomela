
// https://github.com/ethereum/go-ethereum/blob/master/accounts/keystore/account_cache_test.go#L227
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCacheFind2270 = [1] of {int};
	run TestCacheFind227(child_TestCacheFind2270)
stop_process:skip
}

proctype TestCacheFind227(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_find1612 = [1] of {int};
	chan child_find1613 = [1] of {int};
	chan child_add1040 = [1] of {int};
	chan child_add1041 = [1] of {int};
	Mutexdef cache_fileC_mu;
	Mutexdef cache_mu;
	int accs = -2;
	int tests = -2;
	run mutexMonitor(cache_mu);
	run mutexMonitor(cache_fileC_mu);
	

	if
	:: accs-1 != -3 -> 
				for(i : 0.. accs-1) {
			for10: skip;
			run add104(cache_mu,cache_fileC_mu,child_add1040);
			child_add1040?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run add104(cache_mu,cache_fileC_mu,child_add1041);
			child_add1041?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	

	if
	:: tests-1 != -3 -> 
				for(i : 0.. tests-1) {
			for20: skip;
			run find161(cache_mu,cache_fileC_mu,child_find1612);
			child_find1612?0;
			

			if
			:: true -> 
				goto for22_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for22_end
			:: true;
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for23: skip;
			run find161(cache_mu,cache_fileC_mu,child_find1613);
			child_find1613?0;
			

			if
			:: true -> 
				goto for23_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for23_end
			:: true;
			fi;
			for23_end: skip
		:: true -> 
			break
		od;
		for23_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype add104(Mutexdef ac_mu;Mutexdef ac_fileC_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ac_mu.Lock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
		ac_mu.Unlock!false;
	child!0
}
proctype find161(Mutexdef ac_mu;Mutexdef ac_fileC_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
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

