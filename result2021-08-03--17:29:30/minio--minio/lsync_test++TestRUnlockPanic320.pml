// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/minio/minio/blob/e948e7cdf65028f7a8545d1a05c2baea75198bd0/pkg/lsync/lrwmutex_test.go#L320
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRUnlockPanic3200 = [1] of {int};
	run TestRUnlockPanic320(child_TestRUnlockPanic3200);
	run receiver(child_TestRUnlockPanic3200)
stop_process:skip
}

proctype TestRUnlockPanic320(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RUnlock1410 = [1] of {int};
	Mutexdef mu_mu;
	run mutexMonitor(mu_mu);
	run RUnlock141(mu_mu,child_RUnlock1410);
	child_RUnlock1410?0;
	stop_process: skip;
	child!0
}
proctype RUnlock141(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_unlock1500 = [1] of {int};
	run unlock150(lm_mu,child_unlock1500);
	child_unlock1500?0;
	stop_process: skip;
	child!0
}
proctype unlock150(Mutexdef lm_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	lm_mu.Lock!false;
	goto defer1;
		defer1: skip;
	lm_mu.Unlock!false;
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

