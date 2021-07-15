
// https://github.com/moby/moby/blob/master/daemon/events/events_test.go#L257
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestIgnoreBufferedWhenNoTimes2570 = [1] of {int};
	run TestIgnoreBufferedWhenNoTimes257(child_TestIgnoreBufferedWhenNoTimes2570)
stop_process:skip
}

proctype TestIgnoreBufferedWhenNoTimes257(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_loadBufferedEvents1330 = [1] of {int};
	Mutexdef events_pub_m;
	Mutexdef events_mu;
	run mutexMonitor(events_mu);
	run mutexMonitor(events_pub_m);
	run loadBufferedEvents133(events_mu,events_pub_m,child_loadBufferedEvents1330);
	child_loadBufferedEvents1330?0;
	stop_process: skip;
	child!0
}
proctype loadBufferedEvents133(Mutexdef e_mu;Mutexdef e_pub_m;chan child) {
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

