// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/cloudreve/Cloudreve/blob//pkg/filesystem/validator_test.go#L87
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFileSystem_ValidateExtension870 = [1] of {int};
	run TestFileSystem_ValidateExtension87(child_TestFileSystem_ValidateExtension870);
	run receiver(child_TestFileSystem_ValidateExtension870)
stop_process:skip
}

proctype TestFileSystem_ValidateExtension87(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ValidateExtension609 = [1] of {int};
	chan child_ValidateExtension608 = [1] of {int};
	chan child_ValidateExtension607 = [1] of {int};
	chan child_ValidateExtension606 = [1] of {int};
	chan child_ValidateExtension605 = [1] of {int};
	chan child_ValidateExtension604 = [1] of {int};
	chan child_ValidateExtension603 = [1] of {int};
	chan child_ValidateExtension602 = [1] of {int};
	chan child_ValidateExtension601 = [1] of {int};
	chan child_ValidateExtension600 = [1] of {int};
	Mutexdef fs_recycleLock;
	Mutexdef fs_Lock;
	run mutexMonitor(fs_Lock);
	run mutexMonitor(fs_recycleLock);
	run ValidateExtension60(fs_Lock,fs_recycleLock,child_ValidateExtension600);
	child_ValidateExtension600?0;
	run ValidateExtension60(fs_Lock,fs_recycleLock,child_ValidateExtension601);
	child_ValidateExtension601?0;
	run ValidateExtension60(fs_Lock,fs_recycleLock,child_ValidateExtension602);
	child_ValidateExtension602?0;
	run ValidateExtension60(fs_Lock,fs_recycleLock,child_ValidateExtension603);
	child_ValidateExtension603?0;
	run ValidateExtension60(fs_Lock,fs_recycleLock,child_ValidateExtension604);
	child_ValidateExtension604?0;
	run ValidateExtension60(fs_Lock,fs_recycleLock,child_ValidateExtension605);
	child_ValidateExtension605?0;
	run ValidateExtension60(fs_Lock,fs_recycleLock,child_ValidateExtension606);
	child_ValidateExtension606?0;
	run ValidateExtension60(fs_Lock,fs_recycleLock,child_ValidateExtension607);
	child_ValidateExtension607?0;
	run ValidateExtension60(fs_Lock,fs_recycleLock,child_ValidateExtension608);
	child_ValidateExtension608?0;
	run ValidateExtension60(fs_Lock,fs_recycleLock,child_ValidateExtension609);
	child_ValidateExtension609?0;
	stop_process: skip;
	child!0
}
proctype ValidateExtension60(Mutexdef fs_Lock;Mutexdef fs_recycleLock;chan child) {
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

