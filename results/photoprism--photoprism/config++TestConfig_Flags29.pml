// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/client_test.go#L29
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_Flags290 = [1] of {int};
	run TestConfig_Flags29(child_TestConfig_Flags290);
	run receiver(child_TestConfig_Flags290)
stop_process:skip
}

proctype TestConfig_Flags29(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Flags1270 = [1] of {int};
	Mutexdef config_db_values_mu;
	Mutexdef config_once_m;
	run mutexMonitor(config_once_m);
	run mutexMonitor(config_db_values_mu);
	run Flags127(config_db_values_mu,config_once_m,child_Flags1270);
	child_Flags1270?0;
	stop_process: skip;
	child!0
}
proctype Flags127(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DisableSettings224 = [1] of {int};
	chan child_ReadOnly3863 = [1] of {int};
	chan child_Experimental3812 = [1] of {int};
	chan child_Debug3451 = [1] of {int};
	chan child_Public3650 = [1] of {int};
	run Public365(c_db_values_mu,c_once_m,child_Public3650);
	child_Public3650?0;
	run Debug345(c_db_values_mu,c_once_m,child_Debug3451);
	child_Debug3451?0;
	run Experimental381(c_db_values_mu,c_once_m,child_Experimental3812);
	child_Experimental3812?0;
	run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly3863);
	child_ReadOnly3863?0;
	run DisableSettings22(c_db_values_mu,c_once_m,child_DisableSettings224);
	child_DisableSettings224?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Public365(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Demo3550 = [1] of {int};
	run Demo355(c_db_values_mu,c_once_m,child_Demo3550);
	child_Demo3550?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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
proctype Debug345(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Experimental381(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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
proctype DisableSettings22(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
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

