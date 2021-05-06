
// https://github.com/pingcap/tidb/blob/master/executor/simple.go#L1354
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_executeAlterInstance13540 = [1] of {int};
	run executeAlterInstance1354(child_executeAlterInstance13540)
stop_process:skip
}

proctype executeAlterInstance1354(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_UpdateTLSConfig880 = [1] of {int};
	Mutexdef tlsCfg_mutex;
	

	if
	:: true -> 
		run mutexMonitor(tlsCfg_mutex);
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		run UpdateTLSConfig88(tlsCfg_mutex,child_UpdateTLSConfig880);
		child_UpdateTLSConfig880?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype UpdateTLSConfig88(Mutexdef cfg_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

