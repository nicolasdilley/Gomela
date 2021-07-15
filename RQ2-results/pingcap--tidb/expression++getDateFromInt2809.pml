
// https://github.com/pingcap/tidb/blob/master/expression/builtin_time.go#L2809
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_getDateFromInt28090 = [1] of {int};
	run getDateFromInt2809(child_getDateFromInt28090)
stop_process:skip
}

proctype getDateFromInt2809(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ParseTimeFromInt6425390 = [1] of {int};
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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
	run ParseTimeFromInt642539(sc_mu_execDetails_CommitDetail_Mu,sc_mu_execDetails_LockKeysDetail_Mu,sc_mu_CommitDetail_Mu,sc_mu_LockKeysDetail_Mu,sc_MemTracker_mu,sc_MemTracker_actionMu,sc_MemTracker_parMu,sc_DiskTracker_mu,sc_DiskTracker_actionMu,sc_DiskTracker_parMu,sc_RuntimeStatsColl_mu,sc_digestMemo_m,child_ParseTimeFromInt6425390);
	child_ParseTimeFromInt6425390?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ParseTimeFromInt642539(Mutexdef sc_mu_execDetails_CommitDetail_Mu;Mutexdef sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef sc_mu_CommitDetail_Mu;Mutexdef sc_mu_LockKeysDetail_Mu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_RuntimeStatsColl_mu;Mutexdef sc_digestMemo_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_parseDateTimeFromNum18280 = [1] of {int};
	run parseDateTimeFromNum1828(sc_mu_execDetails_CommitDetail_Mu,sc_mu_execDetails_LockKeysDetail_Mu,sc_mu_CommitDetail_Mu,sc_mu_LockKeysDetail_Mu,sc_MemTracker_mu,sc_MemTracker_actionMu,sc_MemTracker_parMu,sc_DiskTracker_mu,sc_DiskTracker_actionMu,sc_DiskTracker_parMu,sc_RuntimeStatsColl_mu,sc_digestMemo_m,child_parseDateTimeFromNum18280);
	child_parseDateTimeFromNum18280?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype parseDateTimeFromNum1828(Mutexdef sc_mu_execDetails_CommitDetail_Mu;Mutexdef sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef sc_mu_CommitDetail_Mu;Mutexdef sc_mu_LockKeysDetail_Mu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_RuntimeStatsColl_mu;Mutexdef sc_digestMemo_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getTime18026 = [1] of {int};
	chan child_getTime18025 = [1] of {int};
	chan child_getTime18024 = [1] of {int};
	chan child_getTime18023 = [1] of {int};
	chan child_getTime18022 = [1] of {int};
	chan child_getTime18021 = [1] of {int};
	chan child_getTime18020 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run getTime1802(sc_mu_execDetails_CommitDetail_Mu,sc_mu_execDetails_LockKeysDetail_Mu,sc_mu_CommitDetail_Mu,sc_mu_LockKeysDetail_Mu,sc_MemTracker_mu,sc_MemTracker_actionMu,sc_MemTracker_parMu,sc_DiskTracker_mu,sc_DiskTracker_actionMu,sc_DiskTracker_parMu,sc_RuntimeStatsColl_mu,sc_digestMemo_m,child_getTime18020);
		child_getTime18020?0;
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
		run getTime1802(sc_mu_execDetails_CommitDetail_Mu,sc_mu_execDetails_LockKeysDetail_Mu,sc_mu_CommitDetail_Mu,sc_mu_LockKeysDetail_Mu,sc_MemTracker_mu,sc_MemTracker_actionMu,sc_MemTracker_parMu,sc_DiskTracker_mu,sc_DiskTracker_actionMu,sc_DiskTracker_parMu,sc_RuntimeStatsColl_mu,sc_digestMemo_m,child_getTime18021);
		child_getTime18021?0;
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
		run getTime1802(sc_mu_execDetails_CommitDetail_Mu,sc_mu_execDetails_LockKeysDetail_Mu,sc_mu_CommitDetail_Mu,sc_mu_LockKeysDetail_Mu,sc_MemTracker_mu,sc_MemTracker_actionMu,sc_MemTracker_parMu,sc_DiskTracker_mu,sc_DiskTracker_actionMu,sc_DiskTracker_parMu,sc_RuntimeStatsColl_mu,sc_digestMemo_m,child_getTime18022);
		child_getTime18022?0;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		run getTime1802(sc_mu_execDetails_CommitDetail_Mu,sc_mu_execDetails_LockKeysDetail_Mu,sc_mu_CommitDetail_Mu,sc_mu_LockKeysDetail_Mu,sc_MemTracker_mu,sc_MemTracker_actionMu,sc_MemTracker_parMu,sc_DiskTracker_mu,sc_DiskTracker_actionMu,sc_DiskTracker_parMu,sc_RuntimeStatsColl_mu,sc_digestMemo_m,child_getTime18023);
		child_getTime18023?0;
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
		run getTime1802(sc_mu_execDetails_CommitDetail_Mu,sc_mu_execDetails_LockKeysDetail_Mu,sc_mu_CommitDetail_Mu,sc_mu_LockKeysDetail_Mu,sc_MemTracker_mu,sc_MemTracker_actionMu,sc_MemTracker_parMu,sc_DiskTracker_mu,sc_DiskTracker_actionMu,sc_DiskTracker_parMu,sc_RuntimeStatsColl_mu,sc_digestMemo_m,child_getTime18024);
		child_getTime18024?0;
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
		run getTime1802(sc_mu_execDetails_CommitDetail_Mu,sc_mu_execDetails_LockKeysDetail_Mu,sc_mu_CommitDetail_Mu,sc_mu_LockKeysDetail_Mu,sc_MemTracker_mu,sc_MemTracker_actionMu,sc_MemTracker_parMu,sc_DiskTracker_mu,sc_DiskTracker_actionMu,sc_DiskTracker_parMu,sc_RuntimeStatsColl_mu,sc_digestMemo_m,child_getTime18025);
		child_getTime18025?0;
		goto stop_process
	:: true;
	fi;
	run getTime1802(sc_mu_execDetails_CommitDetail_Mu,sc_mu_execDetails_LockKeysDetail_Mu,sc_mu_CommitDetail_Mu,sc_mu_LockKeysDetail_Mu,sc_MemTracker_mu,sc_MemTracker_actionMu,sc_MemTracker_parMu,sc_DiskTracker_mu,sc_DiskTracker_actionMu,sc_DiskTracker_parMu,sc_RuntimeStatsColl_mu,sc_digestMemo_m,child_getTime18026);
	child_getTime18026?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getTime1802(Mutexdef sc_mu_execDetails_CommitDetail_Mu;Mutexdef sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef sc_mu_CommitDetail_Mu;Mutexdef sc_mu_LockKeysDetail_Mu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_RuntimeStatsColl_mu;Mutexdef sc_digestMemo_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_check6510 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run check651(sc_mu_execDetails_CommitDetail_Mu,sc_mu_execDetails_LockKeysDetail_Mu,sc_mu_CommitDetail_Mu,sc_mu_LockKeysDetail_Mu,sc_MemTracker_mu,sc_MemTracker_actionMu,sc_MemTracker_parMu,sc_DiskTracker_mu,sc_DiskTracker_actionMu,sc_DiskTracker_parMu,sc_RuntimeStatsColl_mu,sc_digestMemo_m,child_check6510);
	child_check6510?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype check651(Mutexdef sc_mu_execDetails_CommitDetail_Mu;Mutexdef sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef sc_mu_CommitDetail_Mu;Mutexdef sc_mu_LockKeysDetail_Mu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_RuntimeStatsColl_mu;Mutexdef sc_digestMemo_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkTimestampType20780 = [1] of {int};
	

	if
	:: true -> 
		run checkTimestampType2078(sc_mu_execDetails_CommitDetail_Mu,sc_mu_execDetails_LockKeysDetail_Mu,sc_mu_CommitDetail_Mu,sc_mu_LockKeysDetail_Mu,sc_MemTracker_mu,sc_MemTracker_actionMu,sc_MemTracker_parMu,sc_DiskTracker_mu,sc_DiskTracker_actionMu,sc_DiskTracker_parMu,sc_RuntimeStatsColl_mu,sc_digestMemo_m,child_checkTimestampType20780);
		child_checkTimestampType20780?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype checkTimestampType2078(Mutexdef sc_mu_execDetails_CommitDetail_Mu;Mutexdef sc_mu_execDetails_LockKeysDetail_Mu;Mutexdef sc_mu_CommitDetail_Mu;Mutexdef sc_mu_LockKeysDetail_Mu;Mutexdef sc_MemTracker_mu;Mutexdef sc_MemTracker_actionMu;Mutexdef sc_MemTracker_parMu;Mutexdef sc_DiskTracker_mu;Mutexdef sc_DiskTracker_actionMu;Mutexdef sc_DiskTracker_parMu;Mutexdef sc_RuntimeStatsColl_mu;Mutexdef sc_digestMemo_m;chan child) {
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

