
// https://github.com/gin-gonic/gin/blob/master/context_test.go#L1380
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextAbortWithError13800 = [1] of {int};
	run TestContextAbortWithError1380(child_TestContextAbortWithError13800)
stop_process:skip
}

proctype TestContextAbortWithError1380(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsAborted1710 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run IsAborted171(c_mu,child_IsAborted1710);
	child_IsAborted1710?0;
	stop_process: skip;
	child!0
}
proctype IsAborted171(Mutexdef c_mu;chan child) {
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

