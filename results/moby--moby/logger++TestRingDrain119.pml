
// https://github.com/moby/moby/blob/master/daemon/logger/ring_test.go#L119
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRingDrain1190 = [1] of {int};
	run TestRingDrain119(child_TestRingDrain1190)
stop_process:skip
}

proctype TestRingDrain119(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Drain2263 = [1] of {int};
	chan child_Drain2262 = [1] of {int};
	chan child_Enqueue1661 = [1] of {int};
	chan child_Enqueue1660 = [1] of {int};
	Mutexdef r_mu;
	run mutexMonitor(r_mu);
	

	if
	:: 0 != -2 && 5-1 != -3 -> 
				for(i : 0.. 5-1) {
			for11: skip;
			run Enqueue166(r_mu,child_Enqueue1661);
			child_Enqueue1661?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Enqueue166(r_mu,child_Enqueue1660);
			child_Enqueue1660?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run Drain226(r_mu,child_Drain2262);
	child_Drain2262?0;
	run Drain226(r_mu,child_Drain2263);
	child_Drain2263?0;
	stop_process: skip;
	child!0
}
proctype Enqueue166(Mutexdef r_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_mu.Lock!false;
	

	if
	:: true -> 
		r_mu.Unlock!false;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		r_mu.Unlock!false;
		goto stop_process
	:: true;
	fi;
	r_mu.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Drain226(Mutexdef r_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_mu.Lock!false;
	r_mu.Unlock!false;
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

