
// https://github.com/gin-gonic/gin/blob/master/context_test.go#L352
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextHandlerName3520 = [1] of {int};
	run TestContextHandlerName352(child_TestContextHandlerName3520)
stop_process:skip
}

proctype TestContextHandlerName352(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_HandlerName1270 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run HandlerName127(c_mu,child_HandlerName1270);
	child_HandlerName1270?0;
	stop_process: skip;
	child!0
}
proctype HandlerName127(Mutexdef c_mu;chan child) {
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

