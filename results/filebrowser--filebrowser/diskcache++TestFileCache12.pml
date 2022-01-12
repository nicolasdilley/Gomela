// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/filebrowser/filebrowser/blob//diskcache/file_cache_test.go#L12
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFileCache120 = [1] of {int};
	run TestFileCache12(child_TestFileCache120);
	run receiver(child_TestFileCache120)
stop_process:skip
}

proctype TestFileCache12(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Delete654 = [1] of {int};
	chan child_checkValue433 = [1] of {int};
	chan child_Store342 = [1] of {int};
	chan child_checkValue431 = [1] of {int};
	chan child_Store340 = [1] of {int};
	Mutexdef cache_scopedLocks_m;
	Mutexdef cache_scopedLocks;
	run mutexMonitor(cache_scopedLocks);
	run mutexMonitor(cache_scopedLocks_m);
	run Store34(cache_scopedLocks,cache_scopedLocks_m,child_Store340);
	child_Store340?0;
	run checkValue43(cache_scopedLocks,cache_scopedLocks_m,child_checkValue431);
	child_checkValue431?0;
	run Store34(cache_scopedLocks,cache_scopedLocks_m,child_Store342);
	child_Store342?0;
	run checkValue43(cache_scopedLocks,cache_scopedLocks_m,child_checkValue433);
	child_checkValue433?0;
	run Delete65(cache_scopedLocks,cache_scopedLocks_m,child_Delete654);
	child_Delete654?0;
	stop_process: skip;
	child!0
}
proctype Store34(Mutexdef f_scopedLocks;Mutexdef f_scopedLocks_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getFileName1051 = [1] of {int};
	chan child_getScopedLocks910 = [1] of {int};
	run getScopedLocks91(f_scopedLocks,f_scopedLocks_m,child_getScopedLocks910);
	child_getScopedLocks910?0;
	run getFileName105(f_scopedLocks,f_scopedLocks_m,child_getFileName1051);
	child_getFileName1051?0;
	

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
proctype getScopedLocks91(Mutexdef f_scopedLocks;Mutexdef f_scopedLocks_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getFileName105(Mutexdef f_scopedLocks;Mutexdef f_scopedLocks_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checkValue43(Mutexdef cache_scopedLocks;Mutexdef cache_scopedLocks_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Load511 = [1] of {int};
	run Load51(cache_scopedLocks,cache_scopedLocks_m,child_Load511);
	child_Load511?0;
	stop_process: skip;
	child!0
}
proctype Load51(Mutexdef f_scopedLocks;Mutexdef f_scopedLocks_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_open771 = [1] of {int};
	run open77(f_scopedLocks,f_scopedLocks_m,child_open771);
	child_open771?0;
	

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
proctype open77(Mutexdef f_scopedLocks;Mutexdef f_scopedLocks_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getFileName1051 = [1] of {int};
	run getFileName105(f_scopedLocks,f_scopedLocks_m,child_getFileName1051);
	child_getFileName1051?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Delete65(Mutexdef f_scopedLocks;Mutexdef f_scopedLocks_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getFileName1055 = [1] of {int};
	chan child_getScopedLocks914 = [1] of {int};
	run getScopedLocks91(f_scopedLocks,f_scopedLocks_m,child_getScopedLocks914);
	child_getScopedLocks914?0;
	run getFileName105(f_scopedLocks,f_scopedLocks_m,child_getFileName1055);
	child_getFileName1055?0;
	

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

