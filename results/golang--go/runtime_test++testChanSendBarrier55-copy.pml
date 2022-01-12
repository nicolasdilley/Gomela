// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//runtime/chanbarrier_test.go#L55
#define def_var_outer64  3 // mand outer line 64
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
	chan child_testChanSendBarrier550 = [1] of {int};
	run testChanSendBarrier55(child_testChanSendBarrier550);
	run receiver(child_testChanSendBarrier550)
stop_process:skip
}

proctype testChanSendBarrier55(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymoustestChanSendBarrier66560 = [1] of {int};
	Mutexdef globalMu;
	Wgdef wg;
	int var_outer = def_var_outer64; // mand var_outer
	run wgMonitor(wg);
	run mutexMonitor(globalMu);
		for(i : 0.. var_outer-1) {
		for10: skip;
		wg.update!1;
		run AnonymoustestChanSendBarrier6656(wg,globalMu,child_AnonymoustestChanSendBarrier66560);
		run receiver(child_AnonymoustestChanSendBarrier66560);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymoustestChanSendBarrier6656(Wgdef wg;Mutexdef globalMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_inner = -2; // opt var_inner
	globalMu.Lock!false;
	globalMu.Unlock!false;
		defer1: skip;
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

