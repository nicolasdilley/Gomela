// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/cloudreve/Cloudreve/blob//pkg/filesystem/manage_test.go#L68
#define def_var_childFolders  -2 // opt folders line 322
#define def_var_childFiles  -2 // opt files line 322
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFileSystem_List680 = [1] of {int};
	run TestFileSystem_List68(child_TestFileSystem_List680);
	run receiver(child_TestFileSystem_List680)
stop_process:skip
}

proctype TestFileSystem_List68(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_List2695 = [1] of {int};
	chan child_List2694 = [1] of {int};
	chan child_List2693 = [1] of {int};
	chan child_List2692 = [1] of {int};
	chan child_List2691 = [1] of {int};
	chan child_List2690 = [1] of {int};
	Mutexdef fs_recycleLock;
	Mutexdef fs_Lock;
	int var_objects = -2; // opt var_objects
	run mutexMonitor(fs_Lock);
	run mutexMonitor(fs_recycleLock);
	run List269(fs_Lock,fs_recycleLock,child_List2690);
	child_List2690?0;
	run List269(fs_Lock,fs_recycleLock,child_List2691);
	child_List2691?0;
	run List269(fs_Lock,fs_recycleLock,child_List2692);
	child_List2692?0;
	run List269(fs_Lock,fs_recycleLock,child_List2693);
	child_List2693?0;
	run List269(fs_Lock,fs_recycleLock,child_List2694);
	child_List2694?0;
	run List269(fs_Lock,fs_recycleLock,child_List2695);
	child_List2695?0;
	stop_process: skip;
	child!0
}
proctype List269(Mutexdef fs_Lock;Mutexdef fs_recycleLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_listObjects3222 = [1] of {int};
	int var_childFiles = def_var_childFiles;
	int var_childFolders = def_var_childFolders;
	chan child_SetTargetDir2861 = [1] of {int};
	chan child_IsPathExist170 = [1] of {int};
	run IsPathExist17(fs_Lock,fs_recycleLock,child_IsPathExist170);
	child_IsPathExist170?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run SetTargetDir286(fs_Lock,fs_recycleLock,child_SetTargetDir2861);
	child_SetTargetDir2861?0;
	run listObjects322(fs_Lock,fs_recycleLock,var_childFolders,var_childFiles,child_listObjects3222);
	child_listObjects3222?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype IsPathExist17(Mutexdef fs_Lock;Mutexdef fs_recycleLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_pathList = -2; // opt var_pathList
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SetTargetDir286(Mutexdef fs_Lock;Mutexdef fs_recycleLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype listObjects322(Mutexdef fs_Lock;Mutexdef fs_recycleLock;int var_folders;int var_files;chan child) {
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

