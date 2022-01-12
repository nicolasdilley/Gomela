// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/breaker/googlebreaker_test.go#L121
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGoogleBreakerHalfOpen1210 = [1] of {int};
	run TestGoogleBreakerHalfOpen121(child_TestGoogleBreakerHalfOpen1210);
	run receiver(child_TestGoogleBreakerHalfOpen1210)
stop_process:skip
}

proctype TestGoogleBreakerHalfOpen121(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_accept370 = [1] of {int};
	Mutexdef b_proba_lock;
	Mutexdef b_stat_lock;
	run mutexMonitor(b_stat_lock);
	run mutexMonitor(b_proba_lock);
	run accept37(b_proba_lock,b_stat_lock,child_accept370);
	child_accept370?0;
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

