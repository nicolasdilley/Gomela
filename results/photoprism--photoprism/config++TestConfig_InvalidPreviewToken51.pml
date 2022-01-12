// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/auth_test.go#L51
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_InvalidPreviewToken510 = [1] of {int};
	run TestConfig_InvalidPreviewToken51(child_TestConfig_InvalidPreviewToken510);
	run receiver(child_TestConfig_InvalidPreviewToken510)
stop_process:skip
}

proctype TestConfig_InvalidPreviewToken51(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_InvalidPreviewToken450 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run InvalidPreviewToken45(c_db_values_mu,c_once_m,child_InvalidPreviewToken450);
	child_InvalidPreviewToken450?0;
	stop_process: skip;
	child!0
}
proctype InvalidPreviewToken45(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DownloadToken361 = [1] of {int};
	chan child_PreviewToken500 = [1] of {int};
	run PreviewToken50(c_db_values_mu,c_once_m,child_PreviewToken500);
	child_PreviewToken500?0;
	run DownloadToken36(c_db_values_mu,c_once_m,child_DownloadToken361);
	child_DownloadToken361?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype PreviewToken50(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SerialChecksum2311 = [1] of {int};
	chan child_Public3650 = [1] of {int};
	

	if
	:: true -> 
		run Public365(c_db_values_mu,c_once_m,child_Public3650);
		child_Public3650?0;
		

		if
		:: true -> 
			run SerialChecksum231(c_db_values_mu,c_once_m,child_SerialChecksum2311);
			child_SerialChecksum2311?0
		fi
	:: true;
	fi;
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
proctype SerialChecksum231(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Serial2221 = [1] of {int};
	run Serial222(c_db_values_mu,c_once_m,child_Serial2221);
	child_Serial2221?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Serial222(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_initStorage1961 = [1] of {int};
	run initStorage196(c_db_values_mu,c_once_m,child_initStorage1961);
	child_initStorage1961?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype initStorage196(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_BackupPath3142 = [1] of {int};
	chan child_StoragePath2721 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run StoragePath272(c_db_values_mu,c_once_m,child_StoragePath2721);
	child_StoragePath2721?0;
	run BackupPath314(c_db_values_mu,c_once_m,child_BackupPath3142);
	child_BackupPath3142?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi
		fi
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
proctype ReadOnly386(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype BackupPath314(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StoragePath2722 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run StoragePath272(c_db_values_mu,c_once_m,child_StoragePath2722);
	child_StoragePath2722?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DownloadToken36(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
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

