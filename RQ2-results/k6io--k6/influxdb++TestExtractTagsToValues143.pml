
// https://github.com/k6io/k6/blob/master/output/influxdb/output_test.go#L143
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestExtractTagsToValues1430 = [1] of {int};
	run TestExtractTagsToValues143(child_TestExtractTagsToValues1430)
stop_process:skip
}

proctype TestExtractTagsToValues143(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_extractTagsToValues980 = [1] of {int};
	Mutexdef o_periodicFlusher_once_m;
	run mutexMonitor(o_periodicFlusher_once_m);
	run extractTagsToValues98(o_periodicFlusher_once_m,child_extractTagsToValues980);
	child_extractTagsToValues980?0;
	stop_process: skip;
	child!0
}
proctype extractTagsToValues98(Mutexdef o_periodicFlusher_once_m;chan child) {
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

