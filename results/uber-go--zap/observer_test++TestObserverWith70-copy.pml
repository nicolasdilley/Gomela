// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/uber-go/zap/blob//zaptest/observer/observer_test.go#L70
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestObserverWith700 = [1] of {int};
	run TestObserverWith70(child_TestObserverWith700);
	run receiver(child_TestObserverWith700)
stop_process:skip
}

proctype TestObserverWith70(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_All500 = [1] of {int};
	Mutexdef logs_mu;
	run mutexMonitor(logs_mu);
	run All50(logs_mu,child_All500);
	child_All500?0;
	stop_process: skip;
	child!0
}
proctype All50(Mutexdef o_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_o_logs = -2; // opt var_o_logs
	o_mu.RLock!false;
	o_mu.RUnlock!false;
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

