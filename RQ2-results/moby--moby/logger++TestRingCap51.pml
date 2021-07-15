
// https://github.com/moby/moby/blob/master/daemon/logger/ring_test.go#L51
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRingCap510 = [1] of {int};
	run TestRingCap51(child_TestRingCap510)
stop_process:skip
}

proctype TestRingCap51(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Dequeue1906 = [1] of {int};
	chan child_Enqueue1665 = [1] of {int};
	chan child_Enqueue1664 = [1] of {int};
	chan child_Dequeue1903 = [1] of {int};
	chan child_Dequeue1902 = [1] of {int};
	chan child_Enqueue1661 = [1] of {int};
	chan child_Enqueue1660 = [1] of {int};
	Mutexdef r_mu;
	run mutexMonitor(r_mu);
	

	if
	:: 0 != -2 && 10-1 != -3 -> 
				for(i : 0.. 10-1) {
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
	

	if
	:: 0 != -2 && 5-1 != -3 -> 
				for(i : 0.. 5-1) {
			for23: skip;
			run Dequeue190(r_mu,child_Dequeue1903);
			child_Dequeue1903?0;
			for23_end: skip
		};
		for23_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			run Dequeue190(r_mu,child_Dequeue1902);
			child_Dequeue1902?0;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	run Enqueue166(r_mu,child_Enqueue1664);
	child_Enqueue1664?0;
	run Enqueue166(r_mu,child_Enqueue1665);
	child_Enqueue1665?0;
	run Dequeue190(r_mu,child_Dequeue1906);
	child_Dequeue1906?0;
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
proctype Dequeue190(Mutexdef r_mu;chan child) {
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

