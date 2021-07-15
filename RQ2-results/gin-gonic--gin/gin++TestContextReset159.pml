
// https://github.com/gin-gonic/gin/blob/master/context_test.go#L159
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextReset1590 = [1] of {int};
	run TestContextReset159(child_TestContextReset1590)
stop_process:skip
}

proctype TestContextReset159(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_IsAborted1713 = [1] of {int};
	chan child_reset872 = [1] of {int};
	chan child_Set2391 = [1] of {int};
	chan child_Error2160 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run Error216(c_mu,child_Error2160);
	child_Error2160?0;
	run Set239(c_mu,child_Set2391);
	child_Set2391?0;
	run reset87(c_mu,child_reset872);
	child_reset872?0;
	run IsAborted171(c_mu,child_IsAborted1713);
	child_IsAborted1713?0;
	stop_process: skip;
	child!0
}
proctype Error216(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
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
proctype reset87(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

