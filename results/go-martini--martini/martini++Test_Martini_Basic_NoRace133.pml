// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-martini/martini/blob//martini_test.go#L133
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_Martini_Basic_NoRace1330 = [1] of {int};
	run Test_Martini_Basic_NoRace133(child_Test_Martini_Basic_NoRace1330);
	run receiver(child_Test_Martini_Basic_NoRace1330)
stop_process:skip
}

proctype Test_Martini_Basic_NoRace133(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTest_Martini_Basic_NoRace1401340 = [1] of {int};
	Mutexdef m_logger_mu;
	run mutexMonitor(m_logger_mu);
		for(i : 0.. 2-1) {
		for10: skip;
		run AnonymousTest_Martini_Basic_NoRace140134(m_logger_mu,child_AnonymousTest_Martini_Basic_NoRace1401340);
		run receiver(child_AnonymousTest_Martini_Basic_NoRace1401340);
		for10_end: skip
	};
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTest_Martini_Basic_NoRace140134(Mutexdef m_logger_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ServeHTTP740 = [1] of {int};
	run ServeHTTP74(m_logger_mu,child_ServeHTTP740);
	child_ServeHTTP740?0;
	stop_process: skip;
	child!0
}
proctype ServeHTTP74(Mutexdef m_logger_mu;chan child) {
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

