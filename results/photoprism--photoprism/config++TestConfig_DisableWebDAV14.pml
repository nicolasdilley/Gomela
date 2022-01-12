// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/disable_test.go#L14
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_DisableWebDAV140 = [1] of {int};
	run TestConfig_DisableWebDAV14(child_TestConfig_DisableWebDAV140);
	run receiver(child_TestConfig_DisableWebDAV140)
stop_process:skip
}

proctype TestConfig_DisableWebDAV14(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DisableWebDAV131 = [1] of {int};
	chan child_DisableWebDAV130 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run DisableWebDAV13(c_db_values_mu,c_once_m,child_DisableWebDAV130);
	child_DisableWebDAV130?0;
	run DisableWebDAV13(c_db_values_mu,c_once_m,child_DisableWebDAV131);
	child_DisableWebDAV131?0;
	stop_process: skip;
	child!0
}
proctype DisableWebDAV13(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Demo3551 = [1] of {int};
	chan child_ReadOnly3860 = [1] of {int};
	run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly3860);
	child_ReadOnly3860?0;
	run Demo355(c_db_values_mu,c_once_m,child_Demo3551);
	child_Demo3551?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ReadOnly386(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Demo355(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
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

