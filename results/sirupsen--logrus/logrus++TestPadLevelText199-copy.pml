// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/sirupsen/logrus/blob//text_formatter_test.go#L199
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPadLevelText1990 = [1] of {int};
	run TestPadLevelText199(child_TestPadLevelText1990);
	run receiver(child_TestPadLevelText1990)
stop_process:skip
}

proctype TestPadLevelText199(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef tfWithPadding_terminalInitOnce_m;
	Mutexdef tfDefault_terminalInitOnce_m;
	int var_params = -2; // opt var_params
	run mutexMonitor(tfDefault_terminalInitOnce_m);
	run mutexMonitor(tfWithPadding_terminalInitOnce_m);
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

