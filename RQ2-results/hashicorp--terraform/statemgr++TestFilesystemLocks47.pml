
// https://github.com/hashicorp/terraform/blob/master/states/statemgr/filesystem_test.go#L47
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFilesystemLocks470 = [1] of {int};
	run TestFilesystemLocks47(child_TestFilesystemLocks470)
stop_process:skip
}

proctype TestFilesystemLocks47(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_lockInfoPath4706 = [1] of {int};
	chan child_Unlock3285 = [1] of {int};
	chan child_Unlock3284 = [1] of {int};
	chan child_Lock2963 = [1] of {int};
	chan child_Unlock3282 = [1] of {int};
	chan child_lockInfo4841 = [1] of {int};
	chan child_Lock2960 = [1] of {int};
	Mutexdef s_mu;
	run mutexMonitor(s_mu);
	run Lock296(s_mu,child_Lock2960);
	child_Lock2960?0;
	run lockInfo484(s_mu,child_lockInfo4841);
	child_lockInfo4841?0;
	run Unlock328(s_mu,child_Unlock3282);
	child_Unlock3282?0;
	run Lock296(s_mu,child_Lock2963);
	child_Lock2963?0;
	run Unlock328(s_mu,child_Unlock3284);
	child_Unlock3284?0;
	run Unlock328(s_mu,child_Unlock3285);
	child_Unlock3285?0;
	run lockInfoPath470(s_mu,child_lockInfoPath4706);
	child_lockInfoPath4706?0;
	stop_process: skip;
	child!0
}
proctype Lock296(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_writeLockInfo5003 = [1] of {int};
	chan child_lockInfo4842 = [1] of {int};
	chan child_lock131 = [1] of {int};
	chan child_createStateFiles4330 = [1] of {int};
	

	if
	:: true -> 
		run createStateFiles433(s_mu,child_createStateFiles4330);
		child_createStateFiles4330?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run lock13(s_mu,child_lock131);
	child_lock131?0;
	

	if
	:: true -> 
		run lockInfo484(s_mu,child_lockInfo4842);
		child_lockInfo4842?0;
		goto stop_process
	:: true;
	fi;
	run writeLockInfo500(s_mu,child_writeLockInfo5003);
	child_writeLockInfo5003?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype createStateFiles433(Mutexdef s_mu;chan child) {
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
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype lock13(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype lockInfo484(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_lockInfoPath4702 = [1] of {int};
	run lockInfoPath470(s_mu,child_lockInfoPath4702);
	child_lockInfoPath4702?0;
	

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
proctype lockInfoPath470(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype writeLockInfo500(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_lockInfoPath4703 = [1] of {int};
	run lockInfoPath470(s_mu,child_lockInfoPath4703);
	child_lockInfoPath4703?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Unlock328(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_unlock264 = [1] of {int};
	chan child_lockInfoPath4703 = [1] of {int};
	chan child_lockInfo4842 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run lockInfo484(s_mu,child_lockInfo4842);
		child_lockInfo4842?0;
		goto stop_process
	:: true;
	fi;
	run lockInfoPath470(s_mu,child_lockInfoPath4703);
	child_lockInfoPath4703?0;
	run unlock26(s_mu,child_unlock264);
	child_unlock264?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype unlock26(Mutexdef s_mu;chan child) {
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

