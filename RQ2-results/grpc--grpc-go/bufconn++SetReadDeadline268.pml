
// https://github.com/grpc/grpc-go/blob/master/test/bufconn/bufconn.go#L268
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_SetReadDeadline2680 = [1] of {int};
	run SetReadDeadline268(child_SetReadDeadline2680)
stop_process:skip
}

proctype SetReadDeadline268(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef p_mu;
	run mutexMonitor(p_mu);
	p_mu.Lock!false;
	goto stop_process;
	stop_process: skip;
		p_mu.Unlock!false;
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

