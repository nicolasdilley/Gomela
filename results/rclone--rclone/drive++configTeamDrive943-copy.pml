// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/rclone/rclone/blob//backend/drive/drive.go#L943
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_configTeamDrive9430 = [1] of {int};
	run configTeamDrive943(child_configTeamDrive9430);
	run receiver(child_configTeamDrive9430)
stop_process:skip
}

proctype configTeamDrive943(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_listTeamDrives29430 = [1] of {int};
	Mutexdef f_listRmu;
	Mutexdef f_dirCache_mu;
	Mutexdef f_dirCache_cacheMu;
	int var_teamDrives = -2; // opt var_teamDrives
	

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
	run mutexMonitor(f_dirCache_cacheMu);
	run mutexMonitor(f_dirCache_mu);
	run mutexMonitor(f_listRmu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run listTeamDrives2943(f_dirCache_cacheMu,f_dirCache_mu,f_listRmu,child_listTeamDrives29430);
	child_listTeamDrives29430?0;
	

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
proctype listTeamDrives2943(Mutexdef f_dirCache_cacheMu;Mutexdef f_dirCache_mu;Mutexdef f_listRmu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef defaultFs_listRmu;
	Mutexdef defaultFs_dirCache_mu;
	Mutexdef defaultFs_dirCache_cacheMu;
	run mutexMonitor(defaultFs_dirCache_cacheMu);
	run mutexMonitor(defaultFs_dirCache_mu);
	run mutexMonitor(defaultFs_listRmu);
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

