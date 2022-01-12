// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/cloudreve/Cloudreve/blob//pkg/filesystem/validator_test.go#L30
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFileSystem_ValidateLegalName300 = [1] of {int};
	run TestFileSystem_ValidateLegalName30(child_TestFileSystem_ValidateLegalName300);
	run receiver(child_TestFileSystem_ValidateLegalName300)
stop_process:skip
}

proctype TestFileSystem_ValidateLegalName30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ValidateLegalName209 = [1] of {int};
	chan child_ValidateLegalName208 = [1] of {int};
	chan child_ValidateLegalName207 = [1] of {int};
	chan child_ValidateLegalName206 = [1] of {int};
	chan child_ValidateLegalName205 = [1] of {int};
	chan child_ValidateLegalName204 = [1] of {int};
	chan child_ValidateLegalName203 = [1] of {int};
	chan child_ValidateLegalName202 = [1] of {int};
	chan child_ValidateLegalName201 = [1] of {int};
	chan child_ValidateLegalName200 = [1] of {int};
	Mutexdef fs_recycleLock;
	Mutexdef fs_Lock;
	run mutexMonitor(fs_Lock);
	run mutexMonitor(fs_recycleLock);
	run ValidateLegalName20(fs_Lock,fs_recycleLock,child_ValidateLegalName200);
	child_ValidateLegalName200?0;
	run ValidateLegalName20(fs_Lock,fs_recycleLock,child_ValidateLegalName201);
	child_ValidateLegalName201?0;
	run ValidateLegalName20(fs_Lock,fs_recycleLock,child_ValidateLegalName202);
	child_ValidateLegalName202?0;
	run ValidateLegalName20(fs_Lock,fs_recycleLock,child_ValidateLegalName203);
	child_ValidateLegalName203?0;
	run ValidateLegalName20(fs_Lock,fs_recycleLock,child_ValidateLegalName204);
	child_ValidateLegalName204?0;
	run ValidateLegalName20(fs_Lock,fs_recycleLock,child_ValidateLegalName205);
	child_ValidateLegalName205?0;
	run ValidateLegalName20(fs_Lock,fs_recycleLock,child_ValidateLegalName206);
	child_ValidateLegalName206?0;
	run ValidateLegalName20(fs_Lock,fs_recycleLock,child_ValidateLegalName207);
	child_ValidateLegalName207?0;
	run ValidateLegalName20(fs_Lock,fs_recycleLock,child_ValidateLegalName208);
	child_ValidateLegalName208?0;
	run ValidateLegalName20(fs_Lock,fs_recycleLock,child_ValidateLegalName209);
	child_ValidateLegalName209?0;
	stop_process: skip;
	child!0
}
proctype ValidateLegalName20(Mutexdef fs_Lock;Mutexdef fs_recycleLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_reservedCharacter = -2; // opt var_reservedCharacter
	

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

