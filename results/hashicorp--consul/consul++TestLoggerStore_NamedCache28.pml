
// https://github.com/hashicorp/consul/blob/master/agent/consul/logging_test.go#L28
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLoggerStore_NamedCache280 = [1] of {int};
	run TestLoggerStore_NamedCache28(child_TestLoggerStore_NamedCache280)
stop_process:skip
}

proctype TestLoggerStore_NamedCache28(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Named221 = [1] of {int};
	chan child_Named220 = [1] of {int};
	Mutexdef store_l;
	run mutexMonitor(store_l);
	run Named22(store_l,child_Named220);
	child_Named220?0;
	run Named22(store_l,child_Named221);
	child_Named221?0;
	stop_process: skip;
	child!0
}
proctype Named22(Mutexdef ls_l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ls_l.Lock!false;
	goto stop_process;
	stop_process: skip;
		ls_l.Unlock!false;
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

