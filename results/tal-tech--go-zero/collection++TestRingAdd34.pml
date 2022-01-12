// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/tal-tech/go-zero/blob//core/collection/ring_test.go#L34
#define def_var_i  -2 // opt i line 39
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
	chan child_TestRingAdd340 = [1] of {int};
	run TestRingAdd34(child_TestRingAdd340);
	run receiver(child_TestRingAdd340)
stop_process:skip
}

proctype TestRingAdd34(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Take332 = [1] of {int};
	chan child_AnonymousTestRingAdd39390 = [1] of {int};
	int var_i = def_var_i;
	Wgdef wg;
	Mutexdef ring_lock;
	run mutexMonitor(ring_lock);
	run wgMonitor(wg);
		for(i : 0.. 100) {
		for10: skip;
		wg.update!1;
		run AnonymousTestRingAdd3939(wg,ring_lock,var_i,child_AnonymousTestRingAdd39390);
		run receiver(child_AnonymousTestRingAdd39390);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	run Take33(ring_lock,child_Take332);
	child_Take332?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRingAdd3939(Wgdef wg;Mutexdef ring_lock;int var_i;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Add241 = [1] of {int};
	chan child_Add240 = [1] of {int};
	

	if
	:: 0 != -2 && var_i != -2 -> 
				for(i : 0.. var_i) {
			for12: skip;
			run Add24(ring_lock,child_Add241);
			child_Add241?0;
			for12_end: skip
		};
		for12_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run Add24(ring_lock,child_Add240);
			child_Add240?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype Add24(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	r_lock.Lock!false;
		defer1: skip;
	r_lock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Take33(Mutexdef r_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_size = -2; // opt var_size
	r_lock.Lock!false;
	goto defer1;
		defer1: skip;
	r_lock.Unlock!false;
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

