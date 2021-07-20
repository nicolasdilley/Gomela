// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-delve/delve/blob/9ed4ba0c49d916bf128ecf69fcc109235aeed075/service/debugger/debugger_unix_test.go#L56
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDebugger_LaunchWithTTY560 = [1] of {int};
	run TestDebugger_LaunchWithTTY56(child_TestDebugger_LaunchWithTTY560);
	run receiver(child_TestDebugger_LaunchWithTTY560)
stop_process:skip
}

proctype TestDebugger_LaunchWithTTY56(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ProcessPid3650 = [1] of {int};
	Mutexdef cmd_Process_sigMu;
	Mutexdef d_dumpState_Mutex;
	Mutexdef d_recordMutex;
	Mutexdef d_runningMutex;
	Mutexdef d_targetMutex;
	run mutexMonitor(d_targetMutex);
	run mutexMonitor(d_runningMutex);
	run mutexMonitor(d_recordMutex);
	run mutexMonitor(d_dumpState_Mutex);
	run mutexMonitor(cmd_Process_sigMu);
	run ProcessPid365(d_dumpState_Mutex,d_recordMutex,d_runningMutex,d_targetMutex,child_ProcessPid3650);
	child_ProcessPid3650?0;
	stop_process: skip;
	child!0
}
proctype ProcessPid365(Mutexdef d_dumpState_Mutex;Mutexdef d_recordMutex;Mutexdef d_runningMutex;Mutexdef d_targetMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	d_targetMutex.Lock!false;
	goto defer1;
		defer1: skip;
	d_targetMutex.Unlock!false;
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

