// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/history/history_test.go#L96
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestIsEquivalent960 = [1] of {int};
	run TestIsEquivalent96(child_TestIsEquivalent960);
	run receiver(child_TestIsEquivalent960)
stop_process:skip
}

proctype TestIsEquivalent96(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Records762 = [1] of {int};
	chan child_Add521 = [1] of {int};
	chan child_Add520 = [1] of {int};
	Mutexdef q_mu;
	run mutexMonitor(q_mu);
	run Add52(q_mu,child_Add520);
	child_Add520?0;
	run Add52(q_mu,child_Add521);
	child_Add521?0;
	run Records76(q_mu,child_Records762);
	child_Records762?0;
	stop_process: skip;
	child!0
}
proctype Add52(Mutexdef history_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	history_mu.Lock!false;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	:: true;
	fi;
		defer1: skip;
	history_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Records76(Mutexdef history_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_history_length = -2; // opt var_history_length
	history_mu.Lock!false;
	goto defer1;
		defer1: skip;
	history_mu.Unlock!false;
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

