// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/minio/minio/blob//pkg/lsync/lrwmutex_test.go#L297
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUnlockPanic2970 = [1] of {int};
	run TestUnlockPanic297(child_TestUnlockPanic2970);
	run receiver(child_TestUnlockPanic2970)
stop_process:skip
}

proctype TestUnlockPanic297(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Unlock1290 = [1] of {int};
	Mutexdef mu_mu;
	run mutexMonitor(mu_mu);
	run Unlock129(mu_mu,child_Unlock1290);
	child_Unlock1290?0;
	stop_process: skip;
	child!0
}
proctype Unlock129(Mutexdef lm_mu;chan child) {
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

