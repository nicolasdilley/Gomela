
// https://github.com/hashicorp/consul/blob/master/logging/logfile_test.go#L106
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestLogFile_FileRotation_Disabled1060 = [1] of {int};
	run TestLogFile_FileRotation_Disabled106(child_TestLogFile_FileRotation_Disabled1060)
stop_process:skip
}

proctype TestLogFile_FileRotation_Disabled106(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Write1262 = [1] of {int};
	chan child_Write1261 = [1] of {int};
	chan child_Write1260 = [1] of {int};
	Mutexdef logFile_acquire;
	run mutexMonitor(logFile_acquire);
	run Write126(logFile_acquire,child_Write1260);
	child_Write1260?0;
	run Write126(logFile_acquire,child_Write1261);
	child_Write1261?0;
	run Write126(logFile_acquire,child_Write1262);
	child_Write1262?0;
	stop_process: skip;
	child!0
}
proctype Write126(Mutexdef l_acquire;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_rotate791 = [1] of {int};
	chan child_openNew590 = [1] of {int};
	l_acquire.Lock!false;
	

	if
	:: true -> 
		run openNew59(l_acquire,child_openNew590);
		child_openNew590?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run rotate79(l_acquire,child_rotate791);
	child_rotate791?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
		l_acquire.Unlock!false;
	child!0
}
proctype openNew59(Mutexdef l_acquire;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fileNamePattern480 = [1] of {int};
	run fileNamePattern48(l_acquire,child_fileNamePattern480);
	child_fileNamePattern480?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype fileNamePattern48(Mutexdef l_acquire;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype rotate79(Mutexdef l_acquire;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_openNew592 = [1] of {int};
	chan child_pruneFiles931 = [1] of {int};
	

	if
	:: true -> 
		run pruneFiles93(l_acquire,child_pruneFiles931);
		child_pruneFiles931?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run openNew59(l_acquire,child_openNew592);
		child_openNew592?0;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype pruneFiles93(Mutexdef l_acquire;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fileNamePattern481 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run fileNamePattern48(l_acquire,child_fileNamePattern481);
	child_fileNamePattern481?0;
	

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

