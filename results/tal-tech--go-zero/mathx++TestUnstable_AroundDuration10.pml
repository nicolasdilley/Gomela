// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/mathx/unstable_test.go#L10
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUnstable_AroundDuration100 = [1] of {int};
	run TestUnstable_AroundDuration10(child_TestUnstable_AroundDuration100);
	run receiver(child_TestUnstable_AroundDuration100)
stop_process:skip
}

proctype TestUnstable_AroundDuration10(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AroundDuration321 = [1] of {int};
	chan child_AroundDuration320 = [1] of {int};
	Mutexdef unstable_lock;
	run mutexMonitor(unstable_lock);
	

	if
	:: 0 != -2 && 1000-1 != -3 -> 
				for(i : 0.. 1000-1) {
			for11: skip;
			run AroundDuration32(unstable_lock,child_AroundDuration321);
			child_AroundDuration321?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run AroundDuration32(unstable_lock,child_AroundDuration320);
			child_AroundDuration320?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype AroundDuration32(Mutexdef u_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	u_lock.Lock!false;
	u_lock.Unlock!false;
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

proctype receiver(chan c) {
c?0
}

