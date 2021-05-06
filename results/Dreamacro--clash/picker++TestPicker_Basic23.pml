
// https://github.com/Dreamacro/clash/blob/master/common/picker/picker_test.go#L23
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
	chan child_TestPicker_Basic230 = [1] of {int};
	run TestPicker_Basic23(child_TestPicker_Basic230)
stop_process:skip
}

proctype TestPicker_Basic23(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Wait462 = [1] of {int};
	chan child_Go611 = [1] of {int};
	chan child_Go610 = [1] of {int};
	Mutexdef picker_errOnce_m;
	Mutexdef picker_once_m;
	Wgdef picker_wg;
	run wgMonitor(picker_wg);
	run mutexMonitor(picker_once_m);
	run mutexMonitor(picker_errOnce_m);
	run Go61(picker_wg,picker_once_m,picker_errOnce_m,child_Go610);
	child_Go610?0;
	run Go61(picker_wg,picker_once_m,picker_errOnce_m,child_Go611);
	child_Go611?0;
	run Wait46(picker_wg,picker_once_m,picker_errOnce_m,child_Wait462);
	child_Wait462?0;
	stop_process: skip;
	child!0
}
proctype Go61(Wgdef p_wg;Mutexdef p_once_m;Mutexdef p_errOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousGo6400 = [1] of {int};
	p_wg.update!1;
	run AnonymousGo640(p_wg,p_once_m,p_errOnce_m,child_AnonymousGo6400);
	stop_process: skip;
	child!0
}
proctype AnonymousGo640(Wgdef p_wg;Mutexdef p_once_m;Mutexdef p_errOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
		p_wg.update!-1;
	child!0
}
proctype Wait46(Wgdef p_wg;Mutexdef p_once_m;Mutexdef p_errOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	p_wg.wait?0;
	goto stop_process;
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

