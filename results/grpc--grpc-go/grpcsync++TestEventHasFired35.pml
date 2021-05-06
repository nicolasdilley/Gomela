
// https://github.com/grpc/grpc-go/blob/master/internal/grpcsync/event_test.go#L35
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEventHasFired350 = [1] of {int};
	run TestEventHasFired35(child_TestEventHasFired350)
stop_process:skip
}

proctype TestEventHasFired35(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_HasFired542 = [1] of {int};
	chan child_Fire381 = [1] of {int};
	chan child_HasFired540 = [1] of {int};
	Mutexdef e_o_m;
	run mutexMonitor(e_o_m);
	run HasFired54(e_o_m,child_HasFired540);
	child_HasFired540?0;
	run Fire38(e_o_m,child_Fire381);
	child_Fire381?0;
	run HasFired54(e_o_m,child_HasFired542);
	child_HasFired542?0;
	stop_process: skip;
	child!0
}
proctype HasFired54(Mutexdef e_o_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Fire38(Mutexdef e_o_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

