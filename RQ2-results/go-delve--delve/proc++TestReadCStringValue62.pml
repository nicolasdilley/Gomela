#define ub_for1398_2  -2
#define not_found_{{0x50001}{0x50011}{0x4fff2}{uint641}{uint64+12}}7021  -2

// https://github.com/go-delve/delve/blob/master/pkg/proc/proc_general_test.go#L62
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestReadCStringValue620 = [1] of {int};
	run TestReadCStringValue62(child_TestReadCStringValue620)
stop_process:skip
}

proctype TestReadCStringValue62(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_readCStringValue13940 = [1] of {int};
	chan child_readCStringValue13941 = [1] of {int};
	Mutexdef dm_t_context_mu;
	Mutexdef dm_t_context_match_mu;
	run mutexMonitor(dm_t_context_match_mu);
	run mutexMonitor(dm_t_context_mu);
	

	if
	:: not_found_{{0x50001}{0x50011}{0x4fff2}{uint641}{uint64+12}}7021-1 != -3 -> 
				for(i : 0.. not_found_{{0x50001}{0x50011}{0x4fff2}{uint641}{uint64+12}}7021-1) {
			for10: skip;
			run readCStringValue1394(dm_t_context_match_mu,dm_t_context_mu,child_readCStringValue13940);
			child_readCStringValue13940?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for17: skip;
			run readCStringValue1394(dm_t_context_match_mu,dm_t_context_mu,child_readCStringValue13941);
			child_readCStringValue13941?0;
			for17_end: skip
		:: true -> 
			break
		od;
		for17_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype readCStringValue1394(Mutexdef mem_t_context_match_mu;Mutexdef mem_t_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ReadMemory401 = [1] of {int};
	chan child_ReadMemory400 = [1] of {int};
	

	if
	:: 0 != -2 && ub_for1398_2 != -2 -> 
				for(i : 0.. ub_for1398_2) {
			for14: skip;
			run ReadMemory40(mem_t_context_match_mu,mem_t_context_mu,child_ReadMemory401);
			child_ReadMemory401?0;
			

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
			for14_end: skip
		};
		for14_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run ReadMemory40(mem_t_context_match_mu,mem_t_context_mu,child_ReadMemory400);
			child_ReadMemory400?0;
			

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
proctype ReadMemory40(Mutexdef m_t_context_match_mu;Mutexdef m_t_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_contains360 = [1] of {int};
	run contains36(m_t_context_match_mu,m_t_context_mu,child_contains360);
	child_contains360?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype contains36(Mutexdef m_t_context_match_mu;Mutexdef m_t_context_mu;chan child) {
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

