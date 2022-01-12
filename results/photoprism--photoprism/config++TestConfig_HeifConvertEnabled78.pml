// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/raw_test.go#L78
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_HeifConvertEnabled780 = [1] of {int};
	run TestConfig_HeifConvertEnabled78(child_TestConfig_HeifConvertEnabled780);
	run receiver(child_TestConfig_HeifConvertEnabled780)
stop_process:skip
}

proctype TestConfig_HeifConvertEnabled78(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_HeifConvertEnabled541 = [1] of {int};
	chan child_HeifConvertEnabled540 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run HeifConvertEnabled54(c_db_values_mu,c_once_m,child_HeifConvertEnabled540);
	child_HeifConvertEnabled540?0;
	run HeifConvertEnabled54(c_db_values_mu,c_once_m,child_HeifConvertEnabled541);
	child_HeifConvertEnabled541?0;
	stop_process: skip;
	child!0
}
proctype HeifConvertEnabled54(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DisableHeifConvert990 = [1] of {int};
	run DisableHeifConvert99(c_db_values_mu,c_once_m,child_DisableHeifConvert990);
	child_DisableHeifConvert990?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DisableHeifConvert99(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_HeifConvertBin490 = [1] of {int};
	run HeifConvertBin49(c_db_values_mu,c_once_m,child_HeifConvertBin490);
	child_HeifConvertBin490?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype HeifConvertBin49(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
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

