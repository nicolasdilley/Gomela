
// https://github.com/moby/moby/blob/master/daemon/logger/ring_test.go#L94
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRingClose940 = [1] of {int};
	run TestRingClose94(child_TestRingClose940)
stop_process:skip
}

proctype TestRingClose94(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Drain2264 = [1] of {int};
	chan child_Dequeue1903 = [1] of {int};
	chan child_Enqueue1662 = [1] of {int};
	chan child_Close2121 = [1] of {int};
	chan child_Enqueue1660 = [1] of {int};
	Mutexdef r_mu;
	run mutexMonitor(r_mu);
	run Enqueue166(r_mu,child_Enqueue1660);
	child_Enqueue1660?0;
	run Close212(r_mu,child_Close2121);
	child_Close2121?0;
	run Enqueue166(r_mu,child_Enqueue1662);
	child_Enqueue1662?0;
	run Dequeue190(r_mu,child_Dequeue1903);
	child_Dequeue1903?0;
	run Drain226(r_mu,child_Drain2264);
	child_Drain2264?0;
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
proctype Close212(Mutexdef r_mu;chan child) {
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

