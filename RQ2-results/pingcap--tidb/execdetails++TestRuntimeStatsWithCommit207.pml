#define not_found_819  -2
#define not_found_875  -2

// https://github.com/pingcap/tidb/blob/master/util/execdetails/execdetails_test.go#L207
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRuntimeStatsWithCommit2070 = [1] of {int};
	run TestRuntimeStatsWithCommit207(child_TestRuntimeStatsWithCommit2070)
stop_process:skip
}

proctype TestRuntimeStatsWithCommit207(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_String7923 = [1] of {int};
	chan child_String7922 = [1] of {int};
	Mutexdef lockDetail_Mu;
	chan child_String7921 = [1] of {int};
	chan child_String7920 = [1] of {int};
	Mutexdef stats_LockKeys_Mu;
	Mutexdef stats_Commit_Mu;
	Mutexdef commitDetail_Mu;
	run mutexMonitor(commitDetail_Mu);
	run mutexMonitor(stats_Commit_Mu);
	run mutexMonitor(stats_LockKeys_Mu);
	run String792(stats_Commit_Mu,stats_LockKeys_Mu,child_String7920);
	child_String7920?0;
	

	if
	:: true -> 
		run String792(stats_Commit_Mu,stats_LockKeys_Mu,child_String7921);
		child_String7921?0
	:: true;
	fi;
	run mutexMonitor(lockDetail_Mu);
	run String792(stats_Commit_Mu,stats_LockKeys_Mu,child_String7922);
	child_String7922?0;
	

	if
	:: true -> 
		run String792(stats_Commit_Mu,stats_LockKeys_Mu,child_String7923);
		child_String7923?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype String792(Mutexdef e_Commit_Mu;Mutexdef e_LockKeys_Mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_formatBackoff8971 = [1] of {int};
	chan child_formatBackoff8970 = [1] of {int};
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				run formatBackoff897(e_Commit_Mu,e_LockKeys_Mu,not_found_819,child_formatBackoff8970);
				child_formatBackoff8970?0
			:: true;
			fi
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				run formatBackoff897(e_Commit_Mu,e_LockKeys_Mu,not_found_875,child_formatBackoff8971);
				child_formatBackoff8971?0
			:: true;
			fi
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype formatBackoff897(Mutexdef e_Commit_Mu;Mutexdef e_LockKeys_Mu;int backoffTypes;chan child) {
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

