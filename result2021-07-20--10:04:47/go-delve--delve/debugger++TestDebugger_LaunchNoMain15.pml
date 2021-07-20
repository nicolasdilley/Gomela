// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-delve/delve/blob/9ed4ba0c49d916bf128ecf69fcc109235aeed075/service/debugger/debugger_test.go#L15
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDebugger_LaunchNoMain150 = [1] of {int};
	run TestDebugger_LaunchNoMain15(child_TestDebugger_LaunchNoMain150);
	run receiver(child_TestDebugger_LaunchNoMain150)
stop_process:skip
}

proctype TestDebugger_LaunchNoMain15(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Launch2390 = [1] of {int};
	Mutexdef d_dumpState_Mutex;
	Mutexdef d_recordMutex;
	Mutexdef d_runningMutex;
	Mutexdef d_targetMutex;
	run mutexMonitor(d_targetMutex);
	run mutexMonitor(d_runningMutex);
	run mutexMonitor(d_recordMutex);
	run mutexMonitor(d_dumpState_Mutex);
	run Launch239(d_dumpState_Mutex,d_recordMutex,d_runningMutex,d_targetMutex,child_Launch2390);
	child_Launch2390?0;
	stop_process: skip;
	child!0
}
proctype Launch239(Mutexdef d_dumpState_Mutex;Mutexdef d_recordMutex;Mutexdef d_runningMutex;Mutexdef d_targetMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousLaunch27401 = [1] of {int};
	chan child_recordingStart3060 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		d_targetMutex.Lock!false;
		run recordingStart306(d_dumpState_Mutex,d_recordMutex,d_runningMutex,d_targetMutex,child_recordingStart3060);
		child_recordingStart3060?0;
		run AnonymousLaunch2740(d_dumpState_Mutex,d_recordMutex,d_runningMutex,d_targetMutex,child_AnonymousLaunch27401);
		run receiver(child_AnonymousLaunch27401);
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	stop_process: skip;
	child!0
}
proctype recordingStart306(Mutexdef d_dumpState_Mutex;Mutexdef d_recordMutex;Mutexdef d_runningMutex;Mutexdef d_targetMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	d_recordMutex.Lock!false;
	d_recordMutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype AnonymousLaunch2740(Mutexdef d_dumpState_Mutex;Mutexdef d_recordMutex;Mutexdef d_runningMutex;Mutexdef d_targetMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkGoVersion2233 = [1] of {int};
	chan child_recordingDone3122 = [1] of {int};
	chan child_recordingRun3241 = [1] of {int};
	run recordingRun324(d_dumpState_Mutex,d_recordMutex,d_runningMutex,d_targetMutex,child_recordingRun3241);
	child_recordingRun3241?0;
	run recordingDone312(d_dumpState_Mutex,d_recordMutex,d_runningMutex,d_targetMutex,child_recordingDone3122);
	child_recordingDone3122?0;
	run checkGoVersion223(d_dumpState_Mutex,d_recordMutex,d_runningMutex,d_targetMutex,child_checkGoVersion2233);
	child_checkGoVersion2233?0;
		defer1: skip;
	d_targetMutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype recordingRun324(Mutexdef d_dumpState_Mutex;Mutexdef d_recordMutex;Mutexdef d_runningMutex;Mutexdef d_targetMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype recordingDone312(Mutexdef d_dumpState_Mutex;Mutexdef d_recordMutex;Mutexdef d_runningMutex;Mutexdef d_targetMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	d_recordMutex.Lock!false;
	d_recordMutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype checkGoVersion223(Mutexdef d_dumpState_Mutex;Mutexdef d_recordMutex;Mutexdef d_runningMutex;Mutexdef d_targetMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_isRecording3183 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run isRecording318(d_dumpState_Mutex,d_recordMutex,d_runningMutex,d_targetMutex,child_isRecording3183);
	child_isRecording3183?0;
	

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
proctype isRecording318(Mutexdef d_dumpState_Mutex;Mutexdef d_recordMutex;Mutexdef d_runningMutex;Mutexdef d_targetMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	d_recordMutex.Lock!false;
	goto defer1;
		defer1: skip;
	d_recordMutex.Unlock!false;
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

