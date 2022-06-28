// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/fs_test.go#L289
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_ConfigFile22890 = [1] of {int};
	run TestConfig_ConfigFile2289(child_TestConfig_ConfigFile22890);
	run receiver(child_TestConfig_ConfigFile22890)
stop_process:skip
}

proctype TestConfig_ConfigFile2289(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ConfigFile1441 = [1] of {int};
	chan child_ConfigFile1440 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run ConfigFile144(c_db_values_mu,c_once_m,child_ConfigFile1440);
	child_ConfigFile1440?0;
	run ConfigFile144(c_db_values_mu,c_once_m,child_ConfigFile1441);
	child_ConfigFile1441?0;
	stop_process: skip;
	child!0
}
proctype ConfigFile144(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ConfigPath1530 = [1] of {int};
	

	if
	:: true -> 
		run ConfigPath153(c_db_values_mu,c_once_m,child_ConfigPath1530);
		child_ConfigPath1530?0;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ConfigPath153(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StoragePath2722 = [1] of {int};
	chan child_StoragePath2721 = [1] of {int};
	chan child_StoragePath2720 = [1] of {int};
	

	if
	:: true -> 
		run StoragePath272(c_db_values_mu,c_once_m,child_StoragePath2720);
		child_StoragePath2720?0;
		

		if
		:: true -> 
			run StoragePath272(c_db_values_mu,c_once_m,child_StoragePath2721);
			child_StoragePath2721?0;
			goto stop_process
		:: true;
		fi;
		run StoragePath272(c_db_values_mu,c_once_m,child_StoragePath2722);
		child_StoragePath2722?0;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype StoragePath272(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ReadOnly3864 = [1] of {int};
	chan child_ReadOnly3863 = [1] of {int};
	chan child_ReadOnly3862 = [1] of {int};
	chan child_ReadOnly3861 = [1] of {int};
	chan child_OriginalsPath2000 = [1] of {int};
	

	if
	:: true -> 
		run OriginalsPath200(c_db_values_mu,c_once_m,child_OriginalsPath2000);
		child_OriginalsPath2000?0;
		run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly3861);
		child_ReadOnly3861?0;
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly3862);
			child_ReadOnly3862?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly3863);
			child_ReadOnly3863?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly3864);
		child_ReadOnly3864?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype OriginalsPath200(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
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
