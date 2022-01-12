// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/tal-tech/go-zero/blob//core/mathx/unstable_test.go#L39
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestUnstable_AroundIntNegative390 = [1] of {int};
	run TestUnstable_AroundIntNegative39(child_TestUnstable_AroundIntNegative390);
	run receiver(child_TestUnstable_AroundIntNegative390)
stop_process:skip
}

proctype TestUnstable_AroundIntNegative39(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AroundInt401 = [1] of {int};
	chan child_AroundInt400 = [1] of {int};
	Mutexdef unstable_lock;
	run mutexMonitor(unstable_lock);
	

	if
	:: 0 != -2 && 1000-1 != -3 -> 
				for(i : 0.. 1000-1) {
			for11: skip;
			run AroundInt40(unstable_lock,child_AroundInt401);
			child_AroundInt401?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run AroundInt40(unstable_lock,child_AroundInt400);
			child_AroundInt400?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype AroundInt40(Mutexdef u_lock;chan child) {
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

