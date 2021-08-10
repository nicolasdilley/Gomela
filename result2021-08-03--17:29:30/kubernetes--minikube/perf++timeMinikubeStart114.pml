// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/minikube/blob/ce01c06fef829245cf1b940ca59cc55f4fc9c658/pkg/minikube/perf/start.go#L114
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_timeMinikubeStart1140 = [1] of {int};
	run timeMinikubeStart114(child_timeMinikubeStart1140);
	run receiver(child_timeMinikubeStart1140)
stop_process:skip
}

proctype timeMinikubeStart114(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_timeCommandLogs330 = [1] of {int};
	Mutexdef startCmd_Process_sigMu;
	run mutexMonitor(startCmd_Process_sigMu);
	run timeCommandLogs33(startCmd_Process_sigMu,child_timeCommandLogs330);
	child_timeCommandLogs330?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
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

