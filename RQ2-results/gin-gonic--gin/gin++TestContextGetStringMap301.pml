
// https://github.com/gin-gonic/gin/blob/master/context_test.go#L301
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextGetStringMap3010 = [1] of {int};
	run TestContextGetStringMap301(child_TestContextGetStringMap3010)
stop_process:skip
}

proctype TestContextGetStringMap301(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetStringMap3471 = [1] of {int};
	chan child_Set2390 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run Set239(c_mu,child_Set2390);
	child_Set2390?0;
	run GetStringMap347(c_mu,child_GetStringMap3471);
	child_GetStringMap3471?0;
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
proctype GetStringMap347(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get2511 = [1] of {int};
	run Get251(c_mu,child_Get2511);
	child_Get2511?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Get251(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mu.RLock!false;
	c_mu.RUnlock!false;
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

