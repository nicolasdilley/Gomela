// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/resample_test.go#L10
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_ConvertSize100 = [1] of {int};
	run TestConfig_ConvertSize10(child_TestConfig_ConvertSize100);
	run receiver(child_TestConfig_ConvertSize100)
stop_process:skip
}

proctype TestConfig_ConvertSize10(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_JpegSize102 = [1] of {int};
	chan child_JpegSize101 = [1] of {int};
	chan child_JpegSize100 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run JpegSize10(c_db_values_mu,c_once_m,child_JpegSize100);
	child_JpegSize100?0;
	run JpegSize10(c_db_values_mu,c_once_m,child_JpegSize101);
	child_JpegSize101?0;
	run JpegSize10(c_db_values_mu,c_once_m,child_JpegSize102);
	child_JpegSize102?0;
	stop_process: skip;
	child!0
}
proctype JpegSize10(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

proctype receiver(chan c) {
c?0
}

