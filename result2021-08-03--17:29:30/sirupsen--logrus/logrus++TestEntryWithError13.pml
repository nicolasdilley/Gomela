// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/sirupsen/logrus/blob/b50299cfaaa1bca85be76c8984070e846c7abfd2/entry_test.go#L13
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEntryWithError130 = [1] of {int};
	run TestEntryWithError13(child_TestEntryWithError130);
	run receiver(child_TestEntryWithError130)
stop_process:skip
}

proctype TestEntryWithError13(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewEntry730 = [1] of {int};
	Mutexdef logger_mu_lock;
	run mutexMonitor(logger_mu_lock);
	run NewEntry73(logger_mu_lock,child_NewEntry730);
	child_NewEntry730?0;
	stop_process: skip;
	child!0
}
proctype NewEntry73(Mutexdef logger_mu_lock;chan child) {
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

proctype receiver(chan c) {
c?0
}

