// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/cloudreve/Cloudreve/blob//pkg/filesystem/validator_test.go#L46
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFileSystem_ValidateCapacity460 = [1] of {int};
	run TestFileSystem_ValidateCapacity46(child_TestFileSystem_ValidateCapacity460);
	run receiver(child_TestFileSystem_ValidateCapacity460)
stop_process:skip
}

proctype TestFileSystem_ValidateCapacity46(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ValidateCapacity551 = [1] of {int};
	chan child_ValidateCapacity550 = [1] of {int};
	Mutexdef fs_recycleLock;
	Mutexdef fs_Lock;
	run mutexMonitor(fs_Lock);
	run mutexMonitor(fs_recycleLock);
	run ValidateCapacity55(fs_Lock,fs_recycleLock,child_ValidateCapacity550);
	child_ValidateCapacity550?0;
	run ValidateCapacity55(fs_Lock,fs_recycleLock,child_ValidateCapacity551);
	child_ValidateCapacity551?0;
	stop_process: skip;
	child!0
}
proctype ValidateCapacity55(Mutexdef fs_Lock;Mutexdef fs_recycleLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

