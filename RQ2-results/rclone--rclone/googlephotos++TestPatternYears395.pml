
// https://github.com/rclone/rclone/blob/master/backend/googlephotos/pattern_test.go#L395
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPatternYears3950 = [1] of {int};
	run TestPatternYears395(child_TestPatternYears3950)
stop_process:skip
}

proctype TestPatternYears395(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_years2510 = [1] of {int};
	Mutexdef f_albums_mu;
	Mutexdef f_t_context_mu;
	Mutexdef f_t_context_match_mu;
	run mutexMonitor(f_t_context_match_mu);
	run mutexMonitor(f_t_context_mu);
	run mutexMonitor(f_albums_mu);
	run years251(f_t_context_match_mu,f_t_context_mu,f_albums_mu,child_years2510);
	child_years2510?0;
	stop_process: skip;
	child!0
}
proctype years251(Mutexdef f_t_context_match_mu;Mutexdef f_t_context_mu;Mutexdef f_albums_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_dirTime2182 = [1] of {int};
	chan child_dirTime2181 = [1] of {int};
	chan child_startYear2230 = [1] of {int};
	int currentYear = -2;
	run startYear223(f_t_context_match_mu,f_t_context_mu,f_albums_mu,child_startYear2230);
	child_startYear2230?0;
	

	if
	:: 0 != -2 && currentYear != -2 -> 
				for(i : 0.. currentYear) {
			for11: skip;
			run dirTime218(f_t_context_match_mu,f_t_context_mu,f_albums_mu,child_dirTime2182);
			child_dirTime2182?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run dirTime218(f_t_context_match_mu,f_t_context_mu,f_albums_mu,child_dirTime2181);
			child_dirTime2181?0;
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
proctype startYear223(Mutexdef f_t_context_match_mu;Mutexdef f_t_context_mu;Mutexdef f_albums_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

