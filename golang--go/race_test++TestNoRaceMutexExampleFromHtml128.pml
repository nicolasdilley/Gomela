// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/runtime/race/testdata/mutex_test.go#L128
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNoRaceMutexExampleFromHtml1280 = [1] of {int};
	run TestNoRaceMutexExampleFromHtml128(child_TestNoRaceMutexExampleFromHtml1280);
	run receiver(child_TestNoRaceMutexExampleFromHtml1280)
stop_process:skip
}

proctype TestNoRaceMutexExampleFromHtml128(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestNoRaceMutexExampleFromHtml1331290 = [1] of {int};
	Mutexdef l;
	run mutexMonitor(l);
	l.Lock!false;
	run AnonymousTestNoRaceMutexExampleFromHtml133129(l,child_AnonymousTestNoRaceMutexExampleFromHtml1331290);
	run receiver(child_AnonymousTestNoRaceMutexExampleFromHtml1331290);
	l.Lock!false;
	stop_process: skip;
	child!0
}
proctype AnonymousTestNoRaceMutexExampleFromHtml133129(Mutexdef l;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	l.Unlock!false;
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

