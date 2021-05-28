// num_comm_params=5
// num_mand_comm_params=1
// num_opt_comm_params=4

// git_link=https://github.com/grpc/grpc-go/blob/ebd6aba6754d073a696e5727158cd0c917ce1019/internal/profiling/buffer/buffer_test.go#L40
#define TestCircularBufferSerial_qs  ??
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
	chan child_TestCircularBufferSerial400 = [1] of {int};
	run TestCircularBufferSerial40(child_TestCircularBufferSerial400);
	run receiver(child_TestCircularBufferSerial400)
stop_process:skip
}

proctype TestCircularBufferSerial40(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Drain2405 = [1] of {int};
	chan child_Push1754 = [1] of {int};
	chan child_Push1753 = [1] of {int};
	chan child_Drain2402 = [1] of {int};
	chan child_Push1751 = [1] of {int};
	chan child_Push1750 = [1] of {int};
	Mutexdef cb_drainMutex;
	int uint32_len_result__ = -2; // opt uint32_len_result__
	int result = -2; // opt result
	int size = -2; // opt size
	run mutexMonitor(cb_drainMutex);
	

	if
	:: 0 != -2 && size / 2-1 != -3 -> 
				for(i : 0.. size / 2-1) {
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
	

	if
	:: 0 != -2 && size-1 != -3 -> 
				for(i : 0.. size-1) {
			for81: skip;
			run Push175(cb_drainMutex,child_Push1754);
			child_Push1754?0;
			for81_end: skip
		};
		for81_exit: skip
	:: else -> 
		do
		:: true -> 
			for80: skip;
			run Push175(cb_drainMutex,child_Push1753);
			child_Push1753?0;
			for80_end: skip
		:: true -> 
			break
		od;
		for80_exit: skip
	fi;
	run Drain240(cb_drainMutex,child_Drain2405);
	child_Drain2405?0;
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
	int qs = TestCircularBufferSerial_qs; // mand qs
	int cb_qp = -2; // opt cb_qp
	cb_drainMutex.Lock!false;
	run wgMonitor(wg);
	wg.update!qs;
		for(i : 0.. qs-1) {
		for30: skip;
		run AnonymousDrain251251(wg,cb_drainMutex,child_AnonymousDrain2512512);
		run receiver(child_AnonymousDrain2512512);
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

proctype receiver(chan c) {
c?0
}

