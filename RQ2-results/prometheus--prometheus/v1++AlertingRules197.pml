
// https://github.com/prometheus/prometheus/blob/master/web/api/v1/api_test.go#L197
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_AlertingRules1970 = [1] of {int};
	run AlertingRules197(child_AlertingRules1970)
stop_process:skip
}

proctype AlertingRules197(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef rule2_mtx;
	Mutexdef rule1_mtx;
	run mutexMonitor(rule1_mtx);
	run mutexMonitor(rule2_mtx);
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

