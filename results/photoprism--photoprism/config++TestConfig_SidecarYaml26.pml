// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/fs_test.go#L26
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_SidecarYaml260 = [1] of {int};
	run TestConfig_SidecarYaml26(child_TestConfig_SidecarYaml260);
	run receiver(child_TestConfig_SidecarYaml260)
stop_process:skip
}

proctype TestConfig_SidecarYaml26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_BackupYaml2305 = [1] of {int};
	chan child_DisableBackups44 = [1] of {int};
	chan child_BackupYaml2303 = [1] of {int};
	chan child_BackupYaml2302 = [1] of {int};
	chan child_DisableBackups41 = [1] of {int};
	chan child_BackupYaml2300 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run BackupYaml230(c_db_values_mu,c_once_m,child_BackupYaml2300);
	child_BackupYaml2300?0;
	run DisableBackups4(c_db_values_mu,c_once_m,child_DisableBackups41);
	child_DisableBackups41?0;
	run BackupYaml230(c_db_values_mu,c_once_m,child_BackupYaml2302);
	child_BackupYaml2302?0;
	run BackupYaml230(c_db_values_mu,c_once_m,child_BackupYaml2303);
	child_BackupYaml2303?0;
	run DisableBackups4(c_db_values_mu,c_once_m,child_DisableBackups44);
	child_DisableBackups44?0;
	run BackupYaml230(c_db_values_mu,c_once_m,child_BackupYaml2305);
	child_BackupYaml2305?0;
	stop_process: skip;
	child!0
}
proctype BackupYaml230(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DisableBackups40 = [1] of {int};
	run DisableBackups4(c_db_values_mu,c_once_m,child_DisableBackups40);
	child_DisableBackups40?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DisableBackups4(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SidecarWritable2490 = [1] of {int};
	run SidecarWritable249(c_db_values_mu,c_once_m,child_SidecarWritable2490);
	child_SidecarWritable2490?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SidecarWritable249(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SidecarPathIsAbs2441 = [1] of {int};
	chan child_ReadOnly3860 = [1] of {int};
	run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly3860);
	child_ReadOnly3860?0;
	run SidecarPathIsAbs244(c_db_values_mu,c_once_m,child_SidecarPathIsAbs2441);
	child_SidecarPathIsAbs2441?0;
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
proctype SidecarPathIsAbs244(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SidecarPath2351 = [1] of {int};
	run SidecarPath235(c_db_values_mu,c_once_m,child_SidecarPath2351);
	child_SidecarPath2351?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SidecarPath235(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StoragePath2721 = [1] of {int};
	

	if
	:: true -> 
		run StoragePath272(c_db_values_mu,c_once_m,child_StoragePath2721);
		child_StoragePath2721?0
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
	chan child_ReadOnly3865 = [1] of {int};
	chan child_ReadOnly3864 = [1] of {int};
	chan child_ReadOnly3863 = [1] of {int};
	chan child_ReadOnly3862 = [1] of {int};
	chan child_OriginalsPath2001 = [1] of {int};
	

	if
	:: true -> 
		run OriginalsPath200(c_db_values_mu,c_once_m,child_OriginalsPath2001);
		child_OriginalsPath2001?0;
		run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly3862);
		child_ReadOnly3862?0;
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly3863);
			child_ReadOnly3863?0;
			

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
			run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly3864);
			child_ReadOnly3864?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly3865);
		child_ReadOnly3865?0;
		

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

