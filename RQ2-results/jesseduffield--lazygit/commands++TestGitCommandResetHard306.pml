
// https://github.com/jesseduffield/lazygit/blob/master/pkg/commands/branches_test.go#L306
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGitCommandResetHard3060 = [1] of {int};
	run TestGitCommandResetHard306(child_TestGitCommandResetHard3060)
stop_process:skip
}

proctype TestGitCommandResetHard306(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef gitCmd_PatchManager_Log_Logger_mu_lock;
	Mutexdef gitCmd_OSCommand_Log_Logger_mu_lock;
	Mutexdef gitCmd_Log_Logger_mu_lock;
	run mutexMonitor(gitCmd_Log_Logger_mu_lock);
	run mutexMonitor(gitCmd_OSCommand_Log_Logger_mu_lock);
	run mutexMonitor(gitCmd_PatchManager_Log_Logger_mu_lock);
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

