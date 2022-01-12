// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/cloudreve/Cloudreve/blob//pkg/filesystem/file_test.go#L585
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFileSystem_ResetFileIDIfNotExist5850 = [1] of {int};
	run TestFileSystem_ResetFileIDIfNotExist585(child_TestFileSystem_ResetFileIDIfNotExist5850);
	run receiver(child_TestFileSystem_ResetFileIDIfNotExist5850)
stop_process:skip
}

proctype TestFileSystem_ResetFileIDIfNotExist585(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_resetFileIDIfNotExist3120 = [1] of {int};
	Mutexdef fs_recycleLock;
	Mutexdef fs_Lock;
	run mutexMonitor(fs_Lock);
	run mutexMonitor(fs_recycleLock);
	run resetFileIDIfNotExist312(fs_Lock,fs_recycleLock,child_resetFileIDIfNotExist3120);
	child_resetFileIDIfNotExist3120?0;
	stop_process: skip;
	child!0
}
proctype resetFileIDIfNotExist312(Mutexdef fs_Lock;Mutexdef fs_recycleLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_resetPolicyToFirstFile3340 = [1] of {int};
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run resetPolicyToFirstFile334(fs_Lock,fs_recycleLock,child_resetPolicyToFirstFile3340);
	child_resetPolicyToFirstFile3340?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype resetPolicyToFirstFile334(Mutexdef fs_Lock;Mutexdef fs_recycleLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DispatchHandler1630 = [1] of {int};
	

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
	run DispatchHandler163(fs_Lock,fs_recycleLock,child_DispatchHandler1630);
	child_DispatchHandler1630?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DispatchHandler163(Mutexdef fs_Lock;Mutexdef fs_recycleLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
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

