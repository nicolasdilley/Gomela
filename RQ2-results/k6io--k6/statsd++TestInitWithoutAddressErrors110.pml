
// https://github.com/k6io/k6/blob/master/output/statsd/output_test.go#L110
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInitWithoutAddressErrors1100 = [1] of {int};
	run TestInitWithoutAddressErrors110(child_TestInitWithoutAddressErrors1100)
stop_process:skip
}

proctype TestInitWithoutAddressErrors110(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Start1090 = [1] of {int};
	Mutexdef c_periodicFlusher_once_m;
	run mutexMonitor(c_periodicFlusher_once_m);
	run Start109(c_periodicFlusher_once_m,child_Start1090);
	child_Start1090?0;
	stop_process: skip;
	child!0
}
proctype Start109(Mutexdef o_periodicFlusher_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef pf_once_m;
	

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
	run mutexMonitor(pf_once_m);
	

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

