// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//crypto/tls/tls_test.go#L735
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCloneFuncFields7350 = [1] of {int};
	run TestCloneFuncFields735(child_TestCloneFuncFields7350);
	run receiver(child_TestCloneFuncFields7350)
stop_process:skip
}

proctype TestCloneFuncFields735(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Clone7680 = [1] of {int};
	Mutexdef c2_mutex;
	Mutexdef c1_mutex;
	run mutexMonitor(c1_mutex);
	run mutexMonitor(c2_mutex);
	run Clone768(c1_mutex,child_Clone7680);
	child_Clone7680?0;
	stop_process: skip;
	child!0
}
proctype Clone768(Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	c_mutex.RLock!false;
	goto defer1;
		defer1: skip;
	c_mutex.RUnlock!false;
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

