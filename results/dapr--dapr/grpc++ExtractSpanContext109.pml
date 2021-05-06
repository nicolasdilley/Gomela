
// https://github.com/dapr/dapr/blob/master/pkg/grpc/api_test.go#L109
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ExtractSpanContext1090 = [1] of {int};
	run ExtractSpanContext109(child_ExtractSpanContext1090)
stop_process:skip
}

proctype ExtractSpanContext109(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef span_endOnce_m;
	Mutexdef span_mu;
	run mutexMonitor(span_mu);
	run mutexMonitor(span_endOnce_m);
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

