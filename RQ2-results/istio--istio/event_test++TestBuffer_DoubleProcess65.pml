
// https://github.com/istio/istio/blob/master/pkg/config/event/buffer_test.go#L65
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBuffer_DoubleProcess650 = [1] of {int};
	run TestBuffer_DoubleProcess65(child_TestBuffer_DoubleProcess650)
stop_process:skip
}

proctype TestBuffer_DoubleProcess65(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestBuffer_DoubleProcess84691 = [1] of {int};
	chan child_AnonymousTestBuffer_DoubleProcess78690 = [1] of {int};
	Mutexdef b_mu;
	Mutexdef acc_mu;
	run mutexMonitor(acc_mu);
	run mutexMonitor(b_mu);
	run AnonymousTestBuffer_DoubleProcess7869(acc_mu,b_mu,child_AnonymousTestBuffer_DoubleProcess78690);
	run AnonymousTestBuffer_DoubleProcess8469(acc_mu,b_mu,child_AnonymousTestBuffer_DoubleProcess84691);
	stop_process: skip;
	child!0
}
proctype AnonymousTestBuffer_DoubleProcess7869(Mutexdef acc_mu;Mutexdef b_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype AnonymousTestBuffer_DoubleProcess8469(Mutexdef acc_mu;Mutexdef b_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

