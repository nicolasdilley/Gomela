// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/common/validation/statebased/v20_test.go#L174
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test1Err21740 = [1] of {int};
	run Test1Err2174(child_Test1Err21740);
	run receiver(child_Test1Err21740)
stop_process:skip
}

proctype Test1Err2174(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewV20Evaluator220 = [1] of {int};
	Mutexdef ms_mutex;
	run mutexMonitor(ms_mutex);
	run NewV20Evaluator22(ms_mutex,child_NewV20Evaluator220);
	child_NewV20Evaluator220?0;
	stop_process: skip;
	child!0
}
proctype NewV20Evaluator22(Mutexdef StateFetcher_mutex;chan child) {
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

