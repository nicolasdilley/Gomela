// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//runtime/race/testdata/sync_test.go#L188
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNoRaceNilMutexCrash1880 = [1] of {int};
	run TestNoRaceNilMutexCrash188(child_TestNoRaceNilMutexCrash1880);
	run receiver(child_TestNoRaceNilMutexCrash1880)
stop_process:skip
}

proctype TestNoRaceNilMutexCrash188(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef othermutex;
	Mutexdef mutex;
	run mutexMonitor(mutex);
	run mutexMonitor(othermutex);
	othermutex.RLock!false;
		defer1: skip;
	

	if
	:: true -> 
		mutex.Lock!false;
		mutex.Unlock!false
	fi;
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

