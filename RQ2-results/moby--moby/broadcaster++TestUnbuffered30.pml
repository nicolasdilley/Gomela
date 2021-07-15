
// https://github.com/moby/moby/blob/master/pkg/broadcaster/unbuffered_test.go#L30
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUnbuffered300 = [1] of {int};
	run TestUnbuffered30(child_TestUnbuffered300)
stop_process:skip
}

proctype TestUnbuffered30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Clean4110 = [1] of {int};
	chan child_Write239 = [1] of {int};
	chan child_Write238 = [1] of {int};
	chan child_Add157 = [1] of {int};
	chan child_Write236 = [1] of {int};
	chan child_Write235 = [1] of {int};
	chan child_Write234 = [1] of {int};
	chan child_Add153 = [1] of {int};
	chan child_Write232 = [1] of {int};
	chan child_Add151 = [1] of {int};
	chan child_Add150 = [1] of {int};
	Mutexdef writer_mu;
	run mutexMonitor(writer_mu);
	run Add15(writer_mu,child_Add150);
	child_Add150?0;
	run Add15(writer_mu,child_Add151);
	child_Add151?0;
	run Write23(writer_mu,child_Write232);
	child_Write232?0;
	run Add15(writer_mu,child_Add153);
	child_Add153?0;
	run Write23(writer_mu,child_Write234);
	child_Write234?0;
	run Write23(writer_mu,child_Write235);
	child_Write235?0;
	run Write23(writer_mu,child_Write236);
	child_Write236?0;
	run Add15(writer_mu,child_Add157);
	child_Add157?0;
	run Write23(writer_mu,child_Write238);
	child_Write238?0;
	run Write23(writer_mu,child_Write239);
	child_Write239?0;
	run Clean41(writer_mu,child_Clean4110);
	child_Clean4110?0;
	stop_process: skip;
	child!0
}
proctype Add15(Mutexdef w_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	w_mu.Lock!false;
	w_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Write23(Mutexdef w_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	w_mu.Lock!false;
	w_mu.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Clean41(Mutexdef w_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	w_mu.Lock!false;
	w_mu.Unlock!false;
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

