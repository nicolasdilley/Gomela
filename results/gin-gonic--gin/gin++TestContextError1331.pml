
// https://github.com/gin-gonic/gin/blob/master/context_test.go#L1331
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextError13310 = [1] of {int};
	run TestContextError1331(child_TestContextError13310)
stop_process:skip
}

proctype TestContextError1331(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Error2162 = [1] of {int};
	chan child_Error2161 = [1] of {int};
	chan child_Error2160 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run Error216(c_mu,child_Error2160);
	child_Error2160?0;
	run Error216(c_mu,child_Error2161);
	child_Error2161?0;
	run Error216(c_mu,child_Error2162);
	child_Error2162?0;
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

