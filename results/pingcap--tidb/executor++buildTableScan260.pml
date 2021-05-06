
// https://github.com/pingcap/tidb/blob/master/executor/admin.go#L260
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_buildTableScan2600 = [1] of {int};
	run buildTableScan260(child_buildTableScan2600)
stop_process:skip
}

proctype buildTableScan260(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Select610 = [1] of {int};
	Mutexdef kvReq_MemTracker_parMu;
	Mutexdef kvReq_MemTracker_actionMu;
	Mutexdef kvReq_MemTracker_mu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(kvReq_MemTracker_mu);
	run mutexMonitor(kvReq_MemTracker_actionMu);
	run mutexMonitor(kvReq_MemTracker_parMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Select61(kvReq_MemTracker_mu,kvReq_MemTracker_actionMu,kvReq_MemTracker_parMu,child_Select610);
	child_Select610?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Select61(Mutexdef kvReq_MemTracker_mu;Mutexdef kvReq_MemTracker_actionMu;Mutexdef kvReq_MemTracker_parMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

