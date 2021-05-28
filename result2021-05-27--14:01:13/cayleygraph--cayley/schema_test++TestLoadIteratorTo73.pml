// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/cayleygraph/cayley/blob/2d53d0ab1147d1464f6a83509a0ac21750f02bd4/schema/loader_test.go#L73
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLoadIteratorTo730 = [1] of {int};
	run TestLoadIteratorTo73(child_TestLoadIteratorTo730);
	run receiver(child_TestLoadIteratorTo730)
stop_process:skip
}

proctype TestLoadIteratorTo73(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef sch_rulesForTypeMu;
	int c_from = -2; // opt c_from
	int testFillValueCases = -2; // opt testFillValueCases
	run mutexMonitor(sch_rulesForTypeMu);
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

