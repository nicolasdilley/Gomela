
// https://github.com/rclone/rclone/blob/master/backend/zoho/zoho.go#L208
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_setupRoot2080 = [1] of {int};
	run setupRoot208(child_setupRoot2080)
stop_process:skip
}

proctype setupRoot208(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_listWorkspaces1941 = [1] of {int};
	chan child_listTeams1800 = [1] of {int};
	Mutexdef apiSrv_mu;
	Mutexdef authSrv_mu;
	Mutexdef __mu;
	run mutexMonitor(__mu);
	run mutexMonitor(authSrv_mu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(apiSrv_mu);
	run listTeams180(apiSrv_mu,child_listTeams1800);
	child_listTeams1800?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run listWorkspaces194(apiSrv_mu,child_listWorkspaces1941);
	child_listWorkspaces1941?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype listTeams180(Mutexdef srv_mu;chan child) {
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
proctype listWorkspaces194(Mutexdef srv_mu;chan child) {
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

