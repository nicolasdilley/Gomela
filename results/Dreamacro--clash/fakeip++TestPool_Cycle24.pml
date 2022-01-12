// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/Dreamacro/clash/blob//component/fakeip/pool_test.go#L24
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPool_Cycle240 = [1] of {int};
	run TestPool_Cycle24(child_TestPool_Cycle240);
	run receiver(child_TestPool_Cycle240)
stop_process:skip
}

proctype TestPool_Cycle24(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Lookup251 = [1] of {int};
	chan child_Lookup250 = [1] of {int};
	Mutexdef pool_cache_mu;
	Mutexdef pool_mux;
	run mutexMonitor(pool_mux);
	run mutexMonitor(pool_cache_mu);
	run Lookup25(pool_cache_mu,pool_mux,child_Lookup250);
	child_Lookup250?0;
	run Lookup25(pool_cache_mu,pool_mux,child_Lookup251);
	child_Lookup251?0;
	stop_process: skip;
	child!0
}
proctype Lookup25(Mutexdef p_cache_mu;Mutexdef p_mux;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_get1030 = [1] of {int};
	p_mux.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	run get103(p_cache_mu,p_mux,child_get1030);
	child_get1030?0;
	goto defer1;
		defer1: skip;
	p_mux.Unlock!false;
	stop_process: skip;
	child!0
}
proctype get103(Mutexdef p_cache_mu;Mutexdef p_mux;chan child) {
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

proctype receiver(chan c) {
c?0
}

