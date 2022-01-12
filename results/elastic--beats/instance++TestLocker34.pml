// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/elastic/beats/blob//libbeat/cmd/instance/locker_test.go#L34
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLocker340 = [1] of {int};
	run TestLocker34(child_TestLocker340);
	run receiver(child_TestLocker340)
stop_process:skip
}

proctype TestLocker34(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_lock501 = [1] of {int};
	Mutexdef bl2_fl_m;
	chan child_lock500 = [1] of {int};
	Mutexdef bl1_fl_m;
	run mutexMonitor(bl1_fl_m);
	run lock50(bl1_fl_m,child_lock500);
	child_lock500?0;
	run mutexMonitor(bl2_fl_m);
	run lock50(bl2_fl_m,child_lock501);
	child_lock501?0;
	stop_process: skip;
	child!0
}
proctype lock50(Mutexdef l_fl_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

