
// https://github.com/prometheus/prometheus/blob/master/tsdb/exemplar_test.go#L28
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAddExemplar280 = [1] of {int};
	run TestAddExemplar28(child_TestAddExemplar280)
stop_process:skip
}

proctype TestAddExemplar28(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AddExemplar1644 = [1] of {int};
	chan child_AddExemplar1643 = [1] of {int};
	chan child_AddExemplar1642 = [1] of {int};
	chan child_AddExemplar1641 = [1] of {int};
	chan child_AddExemplar1640 = [1] of {int};
	Mutexdef es_lock;
	run mutexMonitor(es_lock);
	run AddExemplar164(es_lock,child_AddExemplar1640);
	child_AddExemplar1640?0;
	run AddExemplar164(es_lock,child_AddExemplar1641);
	child_AddExemplar1641?0;
	run AddExemplar164(es_lock,child_AddExemplar1642);
	child_AddExemplar1642?0;
	run AddExemplar164(es_lock,child_AddExemplar1643);
	child_AddExemplar1643?0;
	run AddExemplar164(es_lock,child_AddExemplar1644);
	child_AddExemplar1644?0;
	stop_process: skip;
	child!0
}
proctype AddExemplar164(Mutexdef ce_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	ce_lock.Lock!false;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		ce_lock.Unlock!false;
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

