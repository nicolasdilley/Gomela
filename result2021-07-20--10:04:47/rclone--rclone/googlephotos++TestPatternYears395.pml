// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/rclone/rclone/blob/6ef7178ee4465f2361b6e2cf483cef5bbfd9c95c/backend/googlephotos/pattern_test.go#L395
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPatternYears3950 = [1] of {int};
	run TestPatternYears395(child_TestPatternYears3950);
	run receiver(child_TestPatternYears3950)
stop_process:skip
}

proctype TestPatternYears395(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_years2510 = [1] of {int};
	Mutexdef f_albums_mu;
	int var_entriesentries = -2; // opt var_entriesentries
	run mutexMonitor(f_albums_mu);
	run years251(f_albums_mu,child_years2510);
	child_years2510?0;
	stop_process: skip;
	child!0
}
proctype years251(Mutexdef f_albums_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_dirTime2172 = [1] of {int};
	chan child_dirTime2171 = [1] of {int};
	chan child_startYear2220 = [1] of {int};
	int var_f_startYear__f_startYear__ = -2; // opt var_f_startYear__f_startYear__
	int var_currentYearcurrentYear = -2; // opt var_currentYearcurrentYear
	run startYear222(f_albums_mu,child_startYear2220);
	child_startYear2220?0;
	

	if
	:: 0 != -2 && var_currentYear != -2 -> 
				for(i : 0.. var_currentYear) {
			for11: skip;
			run dirTime217(f_albums_mu,child_dirTime2172);
			child_dirTime2172?0;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			run dirTime217(f_albums_mu,child_dirTime2171);
			child_dirTime2171?0;
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
proctype startYear222(Mutexdef f_albums_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype dirTime217(Mutexdef f_albums_mu;chan child) {
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

proctype receiver(chan c) {
c?0
}

