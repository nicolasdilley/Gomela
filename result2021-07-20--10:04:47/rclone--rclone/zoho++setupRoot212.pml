// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/rclone/rclone/blob/6ef7178ee4465f2361b6e2cf483cef5bbfd9c95c/backend/zoho/zoho.go#L212
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_setupRoot2120 = [1] of {int};
	run setupRoot212(child_setupRoot2120);
	run receiver(child_setupRoot2120)
stop_process:skip
}

proctype setupRoot212(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_listWorkspaces1981 = [1] of {int};
	chan child_listTeams1840 = [1] of {int};
	Mutexdef apiSrv_mu;
	Mutexdef authSrv_mu;
	Mutexdef __mu;
	int var_workspacesworkspaces = -2; // opt var_workspacesworkspaces
	int var_teamsteams = -2; // opt var_teamsteams
	run mutexMonitor(__mu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(authSrv_mu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(apiSrv_mu);
	run listTeams184(apiSrv_mu,child_listTeams1840);
	child_listTeams1840?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run listWorkspaces198(apiSrv_mu,child_listWorkspaces1981);
	child_listWorkspaces1981?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype listTeams184(Mutexdef srv_mu;chan child) {
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
proctype listWorkspaces198(Mutexdef srv_mu;chan child) {
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

