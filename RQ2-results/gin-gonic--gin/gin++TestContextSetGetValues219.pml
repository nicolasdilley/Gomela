
// https://github.com/gin-gonic/gin/blob/master/context_test.go#L219
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestContextSetGetValues2190 = [1] of {int};
	run TestContextSetGetValues219(child_TestContextSetGetValues2190)
stop_process:skip
}

proctype TestContextSetGetValues219(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MustGet25913 = [1] of {int};
	chan child_MustGet25912 = [1] of {int};
	chan child_MustGet25911 = [1] of {int};
	chan child_MustGet25910 = [1] of {int};
	chan child_MustGet2599 = [1] of {int};
	chan child_MustGet2598 = [1] of {int};
	chan child_MustGet2597 = [1] of {int};
	chan child_Set2396 = [1] of {int};
	chan child_Set2395 = [1] of {int};
	chan child_Set2394 = [1] of {int};
	chan child_Set2393 = [1] of {int};
	chan child_Set2392 = [1] of {int};
	chan child_Set2391 = [1] of {int};
	chan child_Set2390 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run Set239(c_mu,child_Set2390);
	child_Set2390?0;
	run Set239(c_mu,child_Set2391);
	child_Set2391?0;
	run Set239(c_mu,child_Set2392);
	child_Set2392?0;
	run Set239(c_mu,child_Set2393);
	child_Set2393?0;
	run Set239(c_mu,child_Set2394);
	child_Set2394?0;
	run Set239(c_mu,child_Set2395);
	child_Set2395?0;
	run Set239(c_mu,child_Set2396);
	child_Set2396?0;
	run MustGet259(c_mu,child_MustGet2597);
	child_MustGet2597?0;
	run MustGet259(c_mu,child_MustGet2598);
	child_MustGet2598?0;
	run MustGet259(c_mu,child_MustGet2599);
	child_MustGet2599?0;
	run MustGet259(c_mu,child_MustGet25910);
	child_MustGet25910?0;
	run MustGet259(c_mu,child_MustGet25911);
	child_MustGet25911?0;
	run MustGet259(c_mu,child_MustGet25912);
	child_MustGet25912?0;
	run MustGet259(c_mu,child_MustGet25913);
	child_MustGet25913?0;
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
proctype MustGet259(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get2517 = [1] of {int};
	run Get251(c_mu,child_Get2517);
	child_Get2517?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

