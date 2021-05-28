// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/jaegertracing/jaeger/blob/12bba8c9b91cf4a29d314934bc08f4a80e43c042/plugin/storage/badger/factory_test.go#L192
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInitFromOptions1920 = [1] of {int};
	run TestInitFromOptions192(child_TestInitFromOptions1920);
	run receiver(child_TestInitFromOptions1920)
stop_process:skip
}

proctype TestInitFromOptions192(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_InitFromOptions890 = [1] of {int};
	Mutexdef f_cache_cacheLock;
	run mutexMonitor(f_cache_cacheLock);
	run InitFromOptions89(f_cache_cacheLock,child_InitFromOptions890);
	child_InitFromOptions890?0;
	stop_process: skip;
	child!0
}
proctype InitFromOptions89(Mutexdef f_cache_cacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

