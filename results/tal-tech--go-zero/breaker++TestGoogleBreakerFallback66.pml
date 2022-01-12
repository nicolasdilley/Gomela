// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/breaker/googlebreaker_test.go#L66
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGoogleBreakerFallback660 = [1] of {int};
	run TestGoogleBreakerFallback66(child_TestGoogleBreakerFallback660);
	run receiver(child_TestGoogleBreakerFallback660)
stop_process:skip
}

proctype TestGoogleBreakerFallback66(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_markFailed2281 = [1] of {int};
	chan child_accept370 = [1] of {int};
	Mutexdef b_proba_lock;
	Mutexdef b_stat_lock;
	run mutexMonitor(b_stat_lock);
	run mutexMonitor(b_proba_lock);
	run accept37(b_proba_lock,b_stat_lock,child_accept370);
	child_accept370?0;
	run markFailed228(b_proba_lock,b_stat_lock,10000,child_markFailed2281);
	child_markFailed2281?0;
	stop_process: skip;
	child!0
}
proctype accept37(Mutexdef b_proba_lock;Mutexdef b_stat_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_history970 = [1] of {int};
	run history97(b_proba_lock,b_stat_lock,child_history970);
	child_history970?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype history97(Mutexdef b_proba_lock;Mutexdef b_stat_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype markFailed228(Mutexdef b_proba_lock;Mutexdef b_stat_lock;int var_count;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_allow532 = [1] of {int};
	chan child_allow531 = [1] of {int};
	

	if
	:: 0 != -2 && var_count-1 != -3 -> 
				for(i : 0.. var_count-1) {
			for11: skip;
			run allow53(b_proba_lock,b_stat_lock,child_allow532);
			child_allow532?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run allow53(b_proba_lock,b_stat_lock,child_allow531);
			child_allow531?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype allow53(Mutexdef b_proba_lock;Mutexdef b_stat_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_accept371 = [1] of {int};
	run accept37(b_proba_lock,b_stat_lock,child_accept371);
	child_accept371?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

