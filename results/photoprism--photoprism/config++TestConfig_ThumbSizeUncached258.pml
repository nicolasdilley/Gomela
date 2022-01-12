// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/resample_test.go#L58
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_ThumbSizeUncached2580 = [1] of {int};
	run TestConfig_ThumbSizeUncached258(child_TestConfig_ThumbSizeUncached2580);
	run receiver(child_TestConfig_ThumbSizeUncached2580)
stop_process:skip
}

proctype TestConfig_ThumbSizeUncached258(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ThumbSizeUncached732 = [1] of {int};
	chan child_ThumbSizeUncached731 = [1] of {int};
	chan child_ThumbSizeUncached730 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run ThumbSizeUncached73(c_db_values_mu,c_once_m,child_ThumbSizeUncached730);
	child_ThumbSizeUncached730?0;
	run ThumbSizeUncached73(c_db_values_mu,c_once_m,child_ThumbSizeUncached731);
	child_ThumbSizeUncached731?0;
	run ThumbSizeUncached73(c_db_values_mu,c_once_m,child_ThumbSizeUncached732);
	child_ThumbSizeUncached732?0;
	stop_process: skip;
	child!0
}
proctype ThumbSizeUncached73(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ThumbSizePrecached601 = [1] of {int};
	chan child_ThumbSizePrecached600 = [1] of {int};
	run ThumbSizePrecached60(c_db_values_mu,c_once_m,child_ThumbSizePrecached600);
	child_ThumbSizePrecached600?0;
	

	if
	:: true -> 
		run ThumbSizePrecached60(c_db_values_mu,c_once_m,child_ThumbSizePrecached601);
		child_ThumbSizePrecached601?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ThumbSizePrecached60(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
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

