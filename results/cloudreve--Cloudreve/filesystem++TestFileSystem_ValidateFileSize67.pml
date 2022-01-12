// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/cloudreve/Cloudreve/blob//pkg/filesystem/validator_test.go#L67
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFileSystem_ValidateFileSize670 = [1] of {int};
	run TestFileSystem_ValidateFileSize67(child_TestFileSystem_ValidateFileSize670);
	run receiver(child_TestFileSystem_ValidateFileSize670)
stop_process:skip
}

proctype TestFileSystem_ValidateFileSize67(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ValidateFileSize473 = [1] of {int};
	chan child_ValidateFileSize472 = [1] of {int};
	chan child_ValidateFileSize471 = [1] of {int};
	chan child_ValidateFileSize470 = [1] of {int};
	Mutexdef fs_recycleLock;
	Mutexdef fs_Lock;
	run mutexMonitor(fs_Lock);
	run mutexMonitor(fs_recycleLock);
	run ValidateFileSize47(fs_Lock,fs_recycleLock,child_ValidateFileSize470);
	child_ValidateFileSize470?0;
	run ValidateFileSize47(fs_Lock,fs_recycleLock,child_ValidateFileSize471);
	child_ValidateFileSize471?0;
	run ValidateFileSize47(fs_Lock,fs_recycleLock,child_ValidateFileSize472);
	child_ValidateFileSize472?0;
	run ValidateFileSize47(fs_Lock,fs_recycleLock,child_ValidateFileSize473);
	child_ValidateFileSize473?0;
	stop_process: skip;
	child!0
}
proctype ValidateFileSize47(Mutexdef fs_Lock;Mutexdef fs_recycleLock;chan child) {
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

