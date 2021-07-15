
// https://github.com/jesseduffield/lazygit/blob/master/pkg/commands/loading_commits_test.go#L15
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewDummyCommitListBuilder150 = [1] of {int};
	run NewDummyCommitListBuilder15(child_NewDummyCommitListBuilder150)
stop_process:skip
}

proctype NewDummyCommitListBuilder15(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef osCommand_Log_Logger_mu_lock;
	run mutexMonitor(osCommand_Log_Logger_mu_lock);
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

