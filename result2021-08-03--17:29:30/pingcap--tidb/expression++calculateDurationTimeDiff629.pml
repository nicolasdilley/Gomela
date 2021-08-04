// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/expression/builtin_time.go#L629
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_calculateDurationTimeDiff6290 = [1] of {int};
	run calculateDurationTimeDiff629(child_calculateDurationTimeDiff6290);
	run receiver(child_calculateDurationTimeDiff6290)
stop_process:skip
}

proctype calculateDurationTimeDiff629(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_HandleTruncate4710 = [1] of {int};
	Mutexdef sc_RuntimeStatsColl_mu;
	Mutexdef sc_mu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run mutexMonitor(sc_mu);
		run mutexMonitor(sc_RuntimeStatsColl_mu);
		run HandleTruncate471(sc_mu,sc_RuntimeStatsColl_mu,child_HandleTruncate4710);
		child_HandleTruncate4710?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype HandleTruncate471(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AppendWarning4270 = [1] of {int};
	

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
	

	if
	:: true -> 
		run AppendWarning427(sc_mu,sc_RuntimeStatsColl_mu,child_AppendWarning4270);
		child_AppendWarning4270?0;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AppendWarning427(Mutexdef sc_mu;Mutexdef sc_RuntimeStatsColl_mu;chan child) {
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

