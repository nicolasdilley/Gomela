
// https://github.com/gin-gonic/gin/blob/master/context_test.go#L331
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextCopy3310 = [1] of {int};
	run TestContextCopy331(child_TestContextCopy3310)
stop_process:skip
}

proctype TestContextCopy331(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Set2392 = [1] of {int};
	chan child_Copy1041 = [1] of {int};
	Mutexdef cp_mu;
	chan child_Set2390 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run Set239(c_mu,child_Set2390);
	child_Set2390?0;
	run mutexMonitor(cp_mu);
	run Copy104(c_mu,child_Copy1041);
	child_Copy1041?0;
	run Set239(cp_mu,child_Set2392);
	child_Set2392?0;
	stop_process: skip;
	child!0
}
proctype Set239(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mu.Lock!false;
	c_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Copy104(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cp_mu;
	run mutexMonitor(cp_mu);
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

