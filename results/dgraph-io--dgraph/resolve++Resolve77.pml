
// https://github.com/dgraph-io/dgraph/blob/master/graphql/resolve/query.go#L77
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Resolve770 = [1] of {int};
	run Resolve77(child_Resolve770)
stop_process:skip
}

proctype Resolve77(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SpanTimer9480 = [1] of {int};
	Mutexdef span_endOnce_m;
	Mutexdef span_mu;
	run mutexMonitor(span_mu);
	run mutexMonitor(span_endOnce_m);
	run SpanTimer948(span_mu,span_endOnce_m,child_SpanTimer9480);
	child_SpanTimer9480?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SpanTimer948(Mutexdef span_mu;Mutexdef span_endOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

