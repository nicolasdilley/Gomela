
// https://github.com/go-gitea/gitea/blob/master/modules/indexer/code/bleve.go#L266
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Index2660 = [1] of {int};
	run Index266(child_Index2660)
stop_process:skip
}

proctype Index266(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_addUpdate1790 = [1] of {int};
	chan child_addUpdate1791 = [1] of {int};
	Mutexdef batchWriter_p_once_m;
	Mutexdef batchWriter_p_wrMu;
	int changes_Updates = -2;
	

	if
	:: true -> 
		run mutexMonitor(batchWriter_p_wrMu);
		run mutexMonitor(batchWriter_p_once_m);
		

		if
		:: changes_Updates-1 != -3 -> 
						for(i : 0.. changes_Updates-1) {
				for10: skip;
				run addUpdate179(batchWriter_p_wrMu,batchWriter_p_once_m,child_addUpdate1790);
				child_addUpdate1790?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				for10_end: skip
			};
			for10_exit: skip
		:: else -> 
			do
			:: true -> 
				for11: skip;
				run addUpdate179(batchWriter_p_wrMu,batchWriter_p_once_m,child_addUpdate1791);
				child_addUpdate1791?0;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				for11_end: skip
			:: true -> 
				break
			od;
			for11_exit: skip
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype addUpdate179(Mutexdef batchWriter_p_wrMu;Mutexdef batchWriter_p_once_m;chan child) {
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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

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
		goto stop_process
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

