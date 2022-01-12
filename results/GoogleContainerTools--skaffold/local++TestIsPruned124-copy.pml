// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/GoogleContainerTools/skaffold/blob//pkg/skaffold/build/local/prune_test.go#L124
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestIsPruned1240 = [1] of {int};
	run TestIsPruned124(child_TestIsPruned1240);
	run receiver(child_TestIsPruned1240)
stop_process:skip
}

proctype TestIsPruned124(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_isPruned992 = [1] of {int};
	chan child_isPruned991 = [1] of {int};
	chan child_runPrune1060 = [1] of {int};
	Mutexdef pruner_pruneMutex;
	run mutexMonitor(pruner_pruneMutex);
	run runPrune106(pruner_pruneMutex,child_runPrune1060);
	child_runPrune1060?0;
	run isPruned99(pruner_pruneMutex,child_isPruned991);
	child_isPruned991?0;
	run isPruned99(pruner_pruneMutex,child_isPruned992);
	child_isPruned992?0;
	stop_process: skip;
	child!0
}
proctype runPrune106(Mutexdef p_pruneMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_diskUsage1801 = [1] of {int};
	chan child_diskUsage1800 = [1] of {int};
	int var_pruned = -2; // opt var_pruned
	p_pruneMutex.Lock!false;
	run diskUsage180(p_pruneMutex,child_diskUsage1800);
	child_diskUsage1800?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		run diskUsage180(p_pruneMutex,child_diskUsage1801);
		child_diskUsage1801?0;
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			goto defer1
		:: true;
		fi
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	p_pruneMutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype diskUsage180(Mutexdef p_pruneMutex;chan child) {
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
proctype isPruned99(Mutexdef p_pruneMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	p_pruneMutex.Lock!false;
	goto defer1;
		defer1: skip;
	p_pruneMutex.Unlock!false;
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

