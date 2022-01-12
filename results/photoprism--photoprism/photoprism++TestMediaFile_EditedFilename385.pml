// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/photoprism/mediafile_test.go#L385
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMediaFile_EditedFilename3850 = [1] of {int};
	run TestMediaFile_EditedFilename385(child_TestMediaFile_EditedFilename3850);
	run receiver(child_TestMediaFile_EditedFilename3850)
stop_process:skip
}

proctype TestMediaFile_EditedFilename385(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef conf_db_values_mu;
	Mutexdef conf_once_m;
	run mutexMonitor(conf_once_m);
	run mutexMonitor(conf_db_values_mu);
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

