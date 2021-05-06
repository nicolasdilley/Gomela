#define exprs796  -2

// https://github.com/pingcap/tidb/blob/master/expression/util.go#L796
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_RemoveDupExprs7960 = [1] of {int};
	run RemoveDupExprs796(exprs796,child_RemoveDupExprs7960)
stop_process:skip
}

proctype RemoveDupExprs796(int exprs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_HashCode4560 = [1] of {int};
	chan child_HashCode4561 = [1] of {int};
	Mutexdef sc_digestMemo_m;
	Mutexdef sc_RuntimeStatsColl_mu;
	Mutexdef sc_DiskTracker_parMu;
	Mutexdef sc_DiskTracker_actionMu;
	Mutexdef sc_DiskTracker_mu;
	Mutexdef sc_MemTracker_parMu;
	Mutexdef sc_MemTracker_actionMu;
	Mutexdef sc_MemTracker_mu;
	Mutexdef sc_mu_LockKeysDetail_Mu;
	Mutexdef sc_mu_CommitDetail_Mu;
	Mutexdef sc_mu_execDetails_LockKeysDetail_Mu;
	Mutexdef sc_mu_execDetails_CommitDetail_Mu;
	run mutexMonitor(sc_mu_execDetails_CommitDetail_Mu);
	run mutexMonitor(sc_mu_execDetails_LockKeysDetail_Mu);
	run mutexMonitor(sc_mu_CommitDetail_Mu);
	run mutexMonitor(sc_mu_LockKeysDetail_Mu);
	run mutexMonitor(sc_MemTracker_mu);
	run mutexMonitor(sc_MemTracker_actionMu);
	run mutexMonitor(sc_MemTracker_parMu);
	run mutexMonitor(sc_DiskTracker_mu);
	run mutexMonitor(sc_DiskTracker_actionMu);
	run mutexMonitor(sc_DiskTracker_parMu);
	run mutexMonitor(sc_RuntimeStatsColl_mu);
	run mutexMonitor(sc_digestMemo_m);
	

	if
	:: exprs-1 != -3 -> 
				for(i : 0.. exprs-1) {
			for10: skip;
			

			if
			:: true -> 
				goto for10_end
			:: true;
			fi;
			run HashCode456(sc_mu_execDetails_CommitDetail_Mu,sc_mu_execDetails_LockKeysDetail_Mu,sc_mu_CommitDetail_Mu,sc_mu_LockKeysDetail_Mu,sc_MemTracker_mu,sc_MemTracker_actionMu,sc_MemTracker_parMu,sc_DiskTracker_mu,sc_DiskTracker_actionMu,sc_DiskTracker_parMu,sc_RuntimeStatsColl_mu,sc_digestMemo_m,child_HashCode4560);
			child_HashCode4560?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			

			if
			:: true -> 
				goto for11_end
			:: true;
			fi;
			run HashCode456(sc_mu_execDetails_CommitDetail_Mu,sc_mu_execDetails_LockKeysDetail_Mu,sc_mu_CommitDetail_Mu,sc_mu_LockKeysDetail_Mu,sc_MemTracker_mu,sc_MemTracker_actionMu,sc_MemTracker_parMu,sc_DiskTracker_mu,sc_DiskTracker_actionMu,sc_DiskTracker_parMu,sc_RuntimeStatsColl_mu,sc_digestMemo_m,child_HashCode4561);
			child_HashCode4561?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype HashCode456(Mutexdef __mu_execDetails_CommitDetail_Mu;Mutexdef __mu_execDetails_LockKeysDetail_Mu;Mutexdef __mu_CommitDetail_Mu;Mutexdef __mu_LockKeysDetail_Mu;Mutexdef __MemTracker_mu;Mutexdef __MemTracker_actionMu;Mutexdef __MemTracker_parMu;Mutexdef __DiskTracker_mu;Mutexdef __DiskTracker_actionMu;Mutexdef __DiskTracker_parMu;Mutexdef __RuntimeStatsColl_mu;Mutexdef __digestMemo_m;chan child) {
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

