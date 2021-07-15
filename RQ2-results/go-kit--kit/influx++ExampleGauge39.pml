
// https://github.com/go-kit/kit/blob/master/metrics/influx/example_test.go#L39
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ExampleGauge390 = [1] of {int};
	run ExampleGauge39(child_ExampleGauge390)
stop_process:skip
}

proctype ExampleGauge39(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WriteTo1091 = [1] of {int};
	chan child_NewGauge660 = [1] of {int};
	Mutexdef in_histograms_mtx;
	Mutexdef in_gauges_mtx;
	Mutexdef in_counters_mtx;
	run mutexMonitor(in_counters_mtx);
	run mutexMonitor(in_gauges_mtx);
	run mutexMonitor(in_histograms_mtx);
	run NewGauge66(in_counters_mtx,in_gauges_mtx,in_histograms_mtx,child_NewGauge660);
	child_NewGauge660?0;
	run WriteTo109(in_counters_mtx,in_gauges_mtx,in_histograms_mtx,child_WriteTo1091);
	child_WriteTo1091?0;
	stop_process: skip;
	child!0
}
proctype NewGauge66(Mutexdef in_counters_mtx;Mutexdef in_gauges_mtx;Mutexdef in_histograms_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype WriteTo109(Mutexdef in_counters_mtx;Mutexdef in_gauges_mtx;Mutexdef in_histograms_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

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

