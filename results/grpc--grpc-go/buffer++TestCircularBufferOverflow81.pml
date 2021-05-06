#define TestCircularBufferOverflow_qs  0

// https://github.com/grpc/grpc-go/blob/master/internal/profiling/buffer/buffer_test.go#L81
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCircularBufferOverflow810 = [1] of {int};
	run TestCircularBufferOverflow81(child_TestCircularBufferOverflow810)
stop_process:skip
}

proctype TestCircularBufferOverflow81(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Drain2402 = [1] of {int};
	chan child_Push1751 = [1] of {int};
	chan child_Push1750 = [1] of {int};
	Mutexdef cb_drainMutex;
	run mutexMonitor(cb_drainMutex);
	

	if
	:: 0 != -2 && 10 * size-1 != -3 -> 
				for(i : 0.. 10 * size-1) {
			for11: skip;
			run Push175(cb_drainMutex,child_Push1751);
			child_Push1751?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run Push175(cb_drainMutex,child_Push1750);
			child_Push1750?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	run Drain240(cb_drainMutex,child_Drain2402);
	child_Drain2402?0;
	stop_process: skip;
	child!0
}
proctype Push175(Mutexdef cb_drainMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype Drain240(Mutexdef cb_drainMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousDrain2512512 = [1] of {int};
	Wgdef wg;
	int qs = TestCircularBufferOverflow_qs;
	cb_drainMutex.Lock!false;
	run wgMonitor(wg);
	wg.update!qs;
		for(i : 0.. qs-1) {
		for30: skip;
		run AnonymousDrain251251(wg,cb_drainMutex,child_AnonymousDrain2512512);
		for30_end: skip
	};
	for30_exit: skip;
	wg.wait?0;
	cb_drainMutex.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousDrain251251(Wgdef wg;Mutexdef cb_drainMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

