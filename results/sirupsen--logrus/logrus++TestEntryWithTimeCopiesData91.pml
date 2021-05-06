
// https://github.com/sirupsen/logrus/blob/master/entry_test.go#L91
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEntryWithTimeCopiesData910 = [1] of {int};
	run TestEntryWithTimeCopiesData91(child_TestEntryWithTimeCopiesData910)
stop_process:skip
}

proctype TestEntryWithTimeCopiesData91(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WithTime1541 = [1] of {int};
	Mutexdef childEntry2_Logger_mu_lock;
	chan child_WithTime1540 = [1] of {int};
	Mutexdef childEntry1_Logger_mu_lock;
	Mutexdef parentEntry_Logger_mu_lock;
	Mutexdef logger_mu_lock;
	run mutexMonitor(logger_mu_lock);
	run mutexMonitor(parentEntry_Logger_mu_lock);
	run mutexMonitor(childEntry1_Logger_mu_lock);
	run WithTime154(parentEntry_Logger_mu_lock,child_WithTime1540);
	child_WithTime1540?0;
	run mutexMonitor(childEntry2_Logger_mu_lock);
	run WithTime154(parentEntry_Logger_mu_lock,child_WithTime1541);
	child_WithTime1541?0;
	stop_process: skip;
	child!0
}
proctype WithTime154(Mutexdef entry_Logger_mu_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

