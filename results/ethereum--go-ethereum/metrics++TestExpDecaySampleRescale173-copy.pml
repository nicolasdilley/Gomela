// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob//metrics/sample_test.go#L173
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestExpDecaySampleRescale1730 = [1] of {int};
	run TestExpDecaySampleRescale173(child_TestExpDecaySampleRescale1730);
	run receiver(child_TestExpDecaySampleRescale1730)
stop_process:skip
}

proctype TestExpDecaySampleRescale173(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_update1641 = [1] of {int};
	chan child_update1640 = [1] of {int};
	Mutexdef s_mutex;
	int var_s_values_Values = -2; // opt var_s_values_Values
	run mutexMonitor(s_mutex);
	run update164(s_mutex,child_update1640);
	child_update1640?0;
	run update164(s_mutex,child_update1641);
	child_update1641?0;
	stop_process: skip;
	child!0
}
proctype update164(Mutexdef s_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_values = -2; // opt var_values
	s_mutex.Lock!false;
		defer1: skip;
	s_mutex.Unlock!false;
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

