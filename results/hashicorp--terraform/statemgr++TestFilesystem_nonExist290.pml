
// https://github.com/hashicorp/terraform/blob/master/states/statemgr/filesystem_test.go#L290
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFilesystem_nonExist2900 = [1] of {int};
	run TestFilesystem_nonExist290(child_TestFilesystem_nonExist2900)
stop_process:skip
}

proctype TestFilesystem_nonExist290(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_State1121 = [1] of {int};
	chan child_RefreshState2310 = [1] of {int};
	Mutexdef ls_mu;
	run mutexMonitor(ls_mu);
	run RefreshState231(ls_mu,child_RefreshState2310);
	child_RefreshState2310?0;
	run State112(ls_mu,child_State1121);
	child_State1121?0;
	stop_process: skip;
	child!0
}
proctype RefreshState231(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_refreshState2360 = [1] of {int};
	run refreshState236(s_mu,child_refreshState2360);
	child_refreshState2360?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype refreshState236(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype State112(Mutexdef s_mu;chan child) {
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

