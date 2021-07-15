
// https://github.com/grpc/grpc-go/blob/master/internal/grpcsync/event_test.go#L65
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEventMultipleFires650 = [1] of {int};
	run TestEventMultipleFires65(child_TestEventMultipleFires650)
stop_process:skip
}

proctype TestEventMultipleFires65(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Fire385 = [1] of {int};
	chan child_HasFired544 = [1] of {int};
	chan child_Fire383 = [1] of {int};
	chan child_HasFired542 = [1] of {int};
	chan child_Fire381 = [1] of {int};
	chan child_HasFired540 = [1] of {int};
	Mutexdef e_o_m;
	run mutexMonitor(e_o_m);
	run HasFired54(e_o_m,child_HasFired540);
	child_HasFired540?0;
	run Fire38(e_o_m,child_Fire381);
	child_Fire381?0;
	

	if
	:: 0 != -2 && 3-1 != -3 -> 
				for(i : 0.. 3-1) {
			for11: skip;
			run HasFired54(e_o_m,child_HasFired544);
			child_HasFired544?0;
			run Fire38(e_o_m,child_Fire385);
			child_Fire385?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run HasFired54(e_o_m,child_HasFired542);
			child_HasFired542?0;
			run Fire38(e_o_m,child_Fire383);
			child_Fire383?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
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

