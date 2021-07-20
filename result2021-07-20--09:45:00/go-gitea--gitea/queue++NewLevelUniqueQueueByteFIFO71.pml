// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-gitea/gitea/blob/ed393779004335a0afcca0dfac48937db41fabd6/modules/queue/unique_queue_disk.go#L71
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewLevelUniqueQueueByteFIFO710 = [1] of {int};
	run NewLevelUniqueQueueByteFIFO71(child_NewLevelUniqueQueueByteFIFO710);
	run receiver(child_NewLevelUniqueQueueByteFIFO710)
stop_process:skip
}

proctype NewLevelUniqueQueueByteFIFO71(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef internal_db_closeW;
	Mutexdef internal_db_compCommitLk;
	Mutexdef internal_db_snapsMu;
	Mutexdef internal_db_memMu;
	Mutexdef internal_set_lock;
	Mutexdef internal_q_lowLock;
	Mutexdef internal_q_highLock;
	Wgdef db_closeW;
	Mutexdef db_compStats_lk;
	Mutexdef db_compCommitLk;
	Mutexdef db_tr_lk;
	Mutexdef db_snapsMu;
	Mutexdef db_memMu;
	Mutexdef db_s_vmu;
	run mutexMonitor(db_s_vmu);
	run mutexMonitor(db_memMu);
	run mutexMonitor(db_snapsMu);
	run mutexMonitor(db_tr_lk);
	run mutexMonitor(db_compCommitLk);
	run mutexMonitor(db_compStats_lk);
	run wgMonitor(db_closeW);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(internal_q_highLock);
	run mutexMonitor(internal_q_lowLock);
	run mutexMonitor(internal_set_lock);
	run mutexMonitor(internal_db_memMu);
	run mutexMonitor(internal_db_snapsMu);
	run mutexMonitor(internal_db_compCommitLk);
	run wgMonitor(internal_db_closeW);
	

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
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

