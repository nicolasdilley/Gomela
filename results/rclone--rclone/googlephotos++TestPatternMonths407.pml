
// https://github.com/rclone/rclone/blob/master/backend/googlephotos/pattern_test.go#L407
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPatternMonths4070 = [1] of {int};
	run TestPatternMonths407(child_TestPatternMonths4070)
stop_process:skip
}

proctype TestPatternMonths407(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_months2600 = [1] of {int};
	Mutexdef f_albums_mu;
	Mutexdef f_t_context_mu;
	Mutexdef f_t_context_match_mu;
	run mutexMonitor(f_t_context_match_mu);
	run mutexMonitor(f_t_context_mu);
	run mutexMonitor(f_albums_mu);
	run months260(f_t_context_match_mu,f_t_context_mu,f_albums_mu,child_months2600);
	child_months2600?0;
	stop_process: skip;
	child!0
}
proctype months260(Mutexdef f_t_context_match_mu;Mutexdef f_t_context_mu;Mutexdef f_albums_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_dirTime2181 = [1] of {int};
	chan child_dirTime2180 = [1] of {int};
	

	if
	:: 0 != -2 && 12 != -2 -> 
				for(i : 0.. 12) {
			for11: skip;
			run dirTime218(f_t_context_match_mu,f_t_context_mu,f_albums_mu,child_dirTime2181);
			child_dirTime2181?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run dirTime218(f_t_context_match_mu,f_t_context_mu,f_albums_mu,child_dirTime2180);
			child_dirTime2180?0;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype dirTime218(Mutexdef f_t_context_match_mu;Mutexdef f_t_context_mu;Mutexdef f_albums_mu;chan child) {
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

