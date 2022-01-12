// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//common/flogging/global_test.go#L18
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGlobalReset180 = [1] of {int};
	run TestGlobalReset18(child_TestGlobalReset180);
	run receiver(child_TestGlobalReset180)
stop_process:skip
}

proctype TestGlobalReset18(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Encoding1931 = [1] of {int};
	chan child_Encoding1930 = [1] of {int};
	Mutexdef system_multiFormatter_mutex;
	Mutexdef system_mutex;
	run mutexMonitor(system_mutex);
	run mutexMonitor(system_multiFormatter_mutex);
	run Encoding193(system_multiFormatter_mutex,system_mutex,child_Encoding1930);
	child_Encoding1930?0;
	run Encoding193(system_multiFormatter_mutex,system_mutex,child_Encoding1931);
	child_Encoding1931?0;
	stop_process: skip;
	child!0
}
proctype Encoding193(Mutexdef l_multiFormatter_mutex;Mutexdef l_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	l_mutex.RLock!false;
	l_mutex.RUnlock!false;
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

