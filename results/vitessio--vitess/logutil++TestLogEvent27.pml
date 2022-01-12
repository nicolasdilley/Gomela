// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/logutil/logger_test.go#L27
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLogEvent270 = [1] of {int};
	run TestLogEvent27(child_TestLogEvent270);
	run receiver(child_TestLogEvent270)
stop_process:skip
}

proctype TestLogEvent27(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_LogEvent1070 = [1] of {int};
	chan child_LogEvent1071 = [1] of {int};
	Mutexdef ml_mu;
	int var_testValues = -2; // opt var_testValues
	run mutexMonitor(ml_mu);
	

	if
	:: var_testValues-1 != -3 -> 
				for(i : 0.. var_testValues-1) {
			for10: skip;
			run LogEvent107(ml_mu,child_LogEvent1070);
			child_LogEvent1070?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run LogEvent107(ml_mu,child_LogEvent1071);
			child_LogEvent1071?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype LogEvent107(Mutexdef logger_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
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

