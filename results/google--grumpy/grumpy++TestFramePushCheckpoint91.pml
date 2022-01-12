// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/google/grumpy/blob//runtime/frame_test.go#L91
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFramePushCheckpoint910 = [1] of {int};
	run TestFramePushCheckpoint91(child_TestFramePushCheckpoint910);
	run receiver(child_TestFramePushCheckpoint910)
stop_process:skip
}

proctype TestFramePushCheckpoint91(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_PushCheckpoint1160 = [1] of {int};
	chan child_PushCheckpoint1161 = [1] of {int};
	Mutexdef f_globals_mutex_mutex;
	int var_states = -2; // opt var_states
	run mutexMonitor(f_globals_mutex_mutex);
	

	if
	:: var_states-1 != -3 -> 
				for(i : 0.. var_states-1) {
			for10: skip;
			run PushCheckpoint116(f_globals_mutex_mutex,child_PushCheckpoint1160);
			child_PushCheckpoint1160?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run PushCheckpoint116(f_globals_mutex_mutex,child_PushCheckpoint1161);
			child_PushCheckpoint1161?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype PushCheckpoint116(Mutexdef f_globals_mutex_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

