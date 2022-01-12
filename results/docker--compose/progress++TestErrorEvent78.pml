// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/docker/compose/blob//pkg/progress/tty_test.go#L78
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestErrorEvent780 = [1] of {int};
	run TestErrorEvent78(child_TestErrorEvent780);
	run receiver(child_TestErrorEvent780)
stop_process:skip
}

proctype TestErrorEvent78(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Event691 = [1] of {int};
	chan child_Event690 = [1] of {int};
	Mutexdef w_mtx;
	run mutexMonitor(w_mtx);
	run Event69(w_mtx,child_Event690);
	child_Event690?0;
	run Event69(w_mtx,child_Event691);
	child_Event691?0;
	stop_process: skip;
	child!0
}
proctype Event69(Mutexdef w_mtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	w_mtx.Lock!false;
	

	if
	:: true -> 
		

		if
		:: true;
		fi
	fi;
		defer1: skip;
	w_mtx.Unlock!false;
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

