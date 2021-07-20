// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/executor/simple.go#L1376
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_executeAlterInstance13760 = [1] of {int};
	run executeAlterInstance1376(child_executeAlterInstance13760);
	run receiver(child_executeAlterInstance13760)
stop_process:skip
}

proctype executeAlterInstance1376(chan child) {
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

proctype receiver(chan c) {
c?0
}

