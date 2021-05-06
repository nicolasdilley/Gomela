
// https://github.com/ethereum/go-ethereum/blob/master/light/odr_test.go#L69
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Retrieve690 = [1] of {int};
	run Retrieve69(child_Retrieve690)
stop_process:skip
}

proctype Retrieve69(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Prove1500 = [1] of {int};
	Mutexdef nodes_lock;
	Mutexdef t_db_lock;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true;
	:: true;
	:: true -> 
		run mutexMonitor(t_db_lock);
		run mutexMonitor(nodes_lock);
		run Prove150(t_db_lock,nodes_lock,child_Prove1500);
		child_Prove1500?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Prove150(Mutexdef t_db_lock;Mutexdef proofDb_lock;chan child) {
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

