// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/raw_test.go#L24
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_RawtherapeeEnabled240 = [1] of {int};
	run TestConfig_RawtherapeeEnabled24(child_TestConfig_RawtherapeeEnabled240);
	run receiver(child_TestConfig_RawtherapeeEnabled240)
stop_process:skip
}

proctype TestConfig_RawtherapeeEnabled24(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RawtherapeeEnabled341 = [1] of {int};
	chan child_RawtherapeeEnabled340 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run RawtherapeeEnabled34(c_db_values_mu,c_once_m,child_RawtherapeeEnabled340);
	child_RawtherapeeEnabled340?0;
	run RawtherapeeEnabled34(c_db_values_mu,c_once_m,child_RawtherapeeEnabled341);
	child_RawtherapeeEnabled341?0;
	stop_process: skip;
	child!0
}
proctype RawtherapeeEnabled34(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DisableRawtherapee840 = [1] of {int};
	run DisableRawtherapee84(c_db_values_mu,c_once_m,child_DisableRawtherapee840);
	child_DisableRawtherapee840?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DisableRawtherapee84(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RawtherapeeBin240 = [1] of {int};
	run RawtherapeeBin24(c_db_values_mu,c_once_m,child_RawtherapeeBin240);
	child_RawtherapeeBin240?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype RawtherapeeBin24(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
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

