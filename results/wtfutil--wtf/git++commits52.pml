
// https://github.com/wtfutil/wtf/blob/master/modules/git/git_repo.go#L52
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_commits520 = [1] of {int};
	run commits52(child_commits520)
stop_process:skip
}

proctype commits52(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ExecuteCommand490 = [1] of {int};
	Mutexdef cmd_Process_sigMu;
	run mutexMonitor(cmd_Process_sigMu);
	run ExecuteCommand49(cmd_Process_sigMu,child_ExecuteCommand490);
	child_ExecuteCommand490?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ExecuteCommand49(Mutexdef cmd_Process_sigMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

