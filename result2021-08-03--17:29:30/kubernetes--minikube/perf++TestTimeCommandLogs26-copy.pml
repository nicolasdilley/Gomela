// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/minikube/blob/ce01c06fef829245cf1b940ca59cc55f4fc9c658/pkg/minikube/perf/logs_test.go#L26
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTimeCommandLogs260 = [1] of {int};
	run TestTimeCommandLogs26(child_TestTimeCommandLogs260);
	run receiver(child_TestTimeCommandLogs260)
stop_process:skip
}

proctype TestTimeCommandLogs26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_timeCommandLogs330 = [1] of {int};
	Mutexdef cmd_Process_sigMu;
	int var_expected_timedLogs = -2; // opt var_expected_timedLogs
	run mutexMonitor(cmd_Process_sigMu);
	run timeCommandLogs33(cmd_Process_sigMu,child_timeCommandLogs330);
	child_timeCommandLogs330?0;
	stop_process: skip;
	child!0
}
proctype timeCommandLogs33(Mutexdef cmd_Process_sigMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_logs = -2; // opt var_logs
	

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

proctype receiver(chan c) {
c?0
}

