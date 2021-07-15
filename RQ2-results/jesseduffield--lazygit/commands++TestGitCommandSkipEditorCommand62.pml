
// https://github.com/jesseduffield/lazygit/blob/master/pkg/commands/rebasing_test.go#L62
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestGitCommandSkipEditorCommand620 = [1] of {int};
	run TestGitCommandSkipEditorCommand62(child_TestGitCommandSkipEditorCommand620)
stop_process:skip
}

proctype TestGitCommandSkipEditorCommand62(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runSkipEditorCommand2780 = [1] of {int};
	Mutexdef cmd_PatchManager_Log_Logger_mu_lock;
	Mutexdef cmd_OSCommand_Log_Logger_mu_lock;
	Mutexdef cmd_Log_Logger_mu_lock;
	run mutexMonitor(cmd_Log_Logger_mu_lock);
	run mutexMonitor(cmd_OSCommand_Log_Logger_mu_lock);
	run mutexMonitor(cmd_PatchManager_Log_Logger_mu_lock);
	run runSkipEditorCommand278(cmd_Log_Logger_mu_lock,cmd_OSCommand_Log_Logger_mu_lock,cmd_PatchManager_Log_Logger_mu_lock,child_runSkipEditorCommand2780);
	child_runSkipEditorCommand2780?0;
	stop_process: skip;
	child!0
}
proctype runSkipEditorCommand278(Mutexdef c_Log_Logger_mu_lock;Mutexdef c_OSCommand_Log_Logger_mu_lock;Mutexdef c_PatchManager_Log_Logger_mu_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cmd_Process_sigMu;
	run mutexMonitor(cmd_Process_sigMu);
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

