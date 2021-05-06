
// https://github.com/jaegertracing/jaeger/blob/master/cmd/query/app/flags_test.go#L57
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestQueryBuilderBadHeadersFlags570 = [1] of {int};
	run TestQueryBuilderBadHeadersFlags57(child_TestQueryBuilderBadHeadersFlags570)
stop_process:skip
}

proctype TestQueryBuilderBadHeadersFlags57(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef qOpts_TLSHTTP_certWatcher_mu;
	Mutexdef qOpts_TLSHTTP_certWatcher_watcher_mu;
	Mutexdef qOpts_TLSGRPC_certWatcher_mu;
	Mutexdef qOpts_TLSGRPC_certWatcher_watcher_mu;
	run mutexMonitor(qOpts_TLSGRPC_certWatcher_watcher_mu);
	run mutexMonitor(qOpts_TLSGRPC_certWatcher_mu);
	run mutexMonitor(qOpts_TLSHTTP_certWatcher_watcher_mu);
	run mutexMonitor(qOpts_TLSHTTP_certWatcher_mu);
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

