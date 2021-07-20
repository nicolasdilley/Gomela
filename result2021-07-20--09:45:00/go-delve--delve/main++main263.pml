// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com//blob/9ed4ba0c49d916bf128ecf69fcc109235aeed075//Users/nicolasdilley/Library/Caches/go-build/33/3308ec51655e76f514afa93cbefbfb82abb4f4e65c93b3c058b7b20058fd561f-d#L263
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_main2630 = [1] of {int};
	run main263(child_main2630);
	run receiver(child_main2630)
stop_process:skip
}

proctype main263(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TestMain420 = [1] of {int};
	Mutexdef m_afterOnce_m;
	run mutexMonitor(m_afterOnce_m);
	run TestMain42(m_afterOnce_m,child_TestMain420);
	child_TestMain420?0;
	stop_process: skip;
	child!0
}
proctype TestMain42(Mutexdef m_afterOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RunTestsWithFixtures1950 = [1] of {int};
	run RunTestsWithFixtures195(m_afterOnce_m,child_RunTestsWithFixtures1950);
	child_RunTestsWithFixtures1950?0;
	stop_process: skip;
	child!0
}
proctype RunTestsWithFixtures195(Mutexdef m_afterOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_PathsToRemovePathsToRemove = -2; // opt var_PathsToRemovePathsToRemove
	int var_fixturesfixtures = -2; // opt var_fixturesfixtures
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

