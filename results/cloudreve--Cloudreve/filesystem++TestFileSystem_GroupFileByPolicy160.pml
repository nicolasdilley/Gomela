// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/cloudreve/Cloudreve/blob//pkg/filesystem/file_test.go#L160
#define def_var_files  -2 // opt files line 210
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFileSystem_GroupFileByPolicy1600 = [1] of {int};
	run TestFileSystem_GroupFileByPolicy160(child_TestFileSystem_GroupFileByPolicy1600);
	run receiver(child_TestFileSystem_GroupFileByPolicy1600)
stop_process:skip
}

proctype TestFileSystem_GroupFileByPolicy160(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GroupFileByPolicy2100 = [1] of {int};
	int var_files = def_var_files;
	Mutexdef fs_recycleLock;
	Mutexdef fs_Lock;
	run mutexMonitor(fs_Lock);
	run mutexMonitor(fs_recycleLock);
	run GroupFileByPolicy210(fs_Lock,fs_recycleLock,var_files,child_GroupFileByPolicy2100);
	child_GroupFileByPolicy2100?0;
	stop_process: skip;
	child!0
}
proctype GroupFileByPolicy210(Mutexdef fs_Lock;Mutexdef fs_recycleLock;int var_files;chan child) {
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

