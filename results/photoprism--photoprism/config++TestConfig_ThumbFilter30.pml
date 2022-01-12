// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/resample_test.go#L30
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_ThumbFilter300 = [1] of {int};
	run TestConfig_ThumbFilter30(child_TestConfig_ThumbFilter300);
	run receiver(child_TestConfig_ThumbFilter300)
stop_process:skip
}

proctype TestConfig_ThumbFilter30(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ThumbFilter344 = [1] of {int};
	chan child_ThumbFilter343 = [1] of {int};
	chan child_ThumbFilter342 = [1] of {int};
	chan child_ThumbFilter341 = [1] of {int};
	chan child_ThumbFilter340 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run ThumbFilter34(c_db_values_mu,c_once_m,child_ThumbFilter340);
	child_ThumbFilter340?0;
	run ThumbFilter34(c_db_values_mu,c_once_m,child_ThumbFilter341);
	child_ThumbFilter341?0;
	run ThumbFilter34(c_db_values_mu,c_once_m,child_ThumbFilter342);
	child_ThumbFilter342?0;
	run ThumbFilter34(c_db_values_mu,c_once_m,child_ThumbFilter343);
	child_ThumbFilter343?0;
	run ThumbFilter34(c_db_values_mu,c_once_m,child_ThumbFilter344);
	child_ThumbFilter344?0;
	stop_process: skip;
	child!0
}
proctype ThumbFilter34(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
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

