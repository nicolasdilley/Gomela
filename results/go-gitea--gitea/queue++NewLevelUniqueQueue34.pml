// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-gitea/gitea/blob//modules/queue/unique_queue_disk.go#L34
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
	chan child_NewLevelUniqueQueue340 = [1] of {int};
	run NewLevelUniqueQueue34(child_NewLevelUniqueQueue340);
	run receiver(child_NewLevelUniqueQueue340)
stop_process:skip
}

proctype NewLevelUniqueQueue34(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewByteFIFOUniqueQueue2070 = [1] of {int};
	Wgdef byteFIFO_internal_db_closeW;
	Mutexdef byteFIFO_internal_db_compStats_lk;
	Mutexdef byteFIFO_internal_db_compCommitLk;
	Mutexdef byteFIFO_internal_db_tr_lk;
	Mutexdef byteFIFO_internal_db_snapsMu;
	Mutexdef byteFIFO_internal_db_memMu;
	Mutexdef byteFIFO_internal_db_s_vmu;
	Mutexdef byteFIFO_internal_set_lock;
	Wgdef byteFIFO_internal_set_db_closeW;
	Mutexdef byteFIFO_internal_set_db_compCommitLk;
	Mutexdef byteFIFO_internal_set_db_snapsMu;
	Mutexdef byteFIFO_internal_set_db_memMu;
	Mutexdef byteFIFO_internal_q_lowLock;
	Mutexdef byteFIFO_internal_q_highLock;
	Wgdef byteFIFO_internal_q_db_closeW;
	Mutexdef byteFIFO_internal_q_db_compCommitLk;
	Mutexdef byteFIFO_internal_q_db_snapsMu;
	Mutexdef byteFIFO_internal_q_db_memMu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(byteFIFO_internal_q_db_memMu);
	run mutexMonitor(byteFIFO_internal_q_db_snapsMu);
	run mutexMonitor(byteFIFO_internal_q_db_compCommitLk);
	run wgMonitor(byteFIFO_internal_q_db_closeW);
	run mutexMonitor(byteFIFO_internal_q_highLock);
	run mutexMonitor(byteFIFO_internal_q_lowLock);
	run mutexMonitor(byteFIFO_internal_set_db_memMu);
	run mutexMonitor(byteFIFO_internal_set_db_snapsMu);
	run mutexMonitor(byteFIFO_internal_set_db_compCommitLk);
	run wgMonitor(byteFIFO_internal_set_db_closeW);
	run mutexMonitor(byteFIFO_internal_set_lock);
	run mutexMonitor(byteFIFO_internal_db_s_vmu);
	run mutexMonitor(byteFIFO_internal_db_memMu);
	run mutexMonitor(byteFIFO_internal_db_snapsMu);
	run mutexMonitor(byteFIFO_internal_db_tr_lk);
	run mutexMonitor(byteFIFO_internal_db_compCommitLk);
	run mutexMonitor(byteFIFO_internal_db_compStats_lk);
	run wgMonitor(byteFIFO_internal_db_closeW);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run NewByteFIFOUniqueQueue207(byteFIFO_internal_db_closeW,byteFIFO_internal_q_db_closeW,byteFIFO_internal_set_db_closeW,byteFIFO_internal_db_compCommitLk,byteFIFO_internal_db_compStats_lk,byteFIFO_internal_db_memMu,byteFIFO_internal_db_s_vmu,byteFIFO_internal_db_snapsMu,byteFIFO_internal_db_tr_lk,byteFIFO_internal_q_db_compCommitLk,byteFIFO_internal_q_db_memMu,byteFIFO_internal_q_db_snapsMu,byteFIFO_internal_q_highLock,byteFIFO_internal_q_lowLock,byteFIFO_internal_set_db_compCommitLk,byteFIFO_internal_set_db_memMu,byteFIFO_internal_set_db_snapsMu,byteFIFO_internal_set_lock,child_NewByteFIFOUniqueQueue2070);
	child_NewByteFIFOUniqueQueue2070?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewByteFIFOUniqueQueue207(Wgdef byteFIFO_internal_db_closeW;Wgdef byteFIFO_internal_q_db_closeW;Wgdef byteFIFO_internal_set_db_closeW;Mutexdef byteFIFO_internal_db_compCommitLk;Mutexdef byteFIFO_internal_db_compStats_lk;Mutexdef byteFIFO_internal_db_memMu;Mutexdef byteFIFO_internal_db_s_vmu;Mutexdef byteFIFO_internal_db_snapsMu;Mutexdef byteFIFO_internal_db_tr_lk;Mutexdef byteFIFO_internal_q_db_compCommitLk;Mutexdef byteFIFO_internal_q_db_memMu;Mutexdef byteFIFO_internal_q_db_snapsMu;Mutexdef byteFIFO_internal_q_highLock;Mutexdef byteFIFO_internal_q_lowLock;Mutexdef byteFIFO_internal_set_db_compCommitLk;Mutexdef byteFIFO_internal_set_db_memMu;Mutexdef byteFIFO_internal_set_db_snapsMu;Mutexdef byteFIFO_internal_set_lock;chan child) {
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

