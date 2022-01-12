// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/db_test.go#L72
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_DatabaseDsn720 = [1] of {int};
	run TestConfig_DatabaseDsn72(child_TestConfig_DatabaseDsn720);
	run receiver(child_TestConfig_DatabaseDsn720)
stop_process:skip
}

proctype TestConfig_DatabaseDsn72(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DatabaseDsn485 = [1] of {int};
	chan child_DatabaseDsn484 = [1] of {int};
	chan child_DatabaseDsn483 = [1] of {int};
	chan child_DatabaseDsn482 = [1] of {int};
	chan child_DatabaseDsn481 = [1] of {int};
	chan child_DatabaseDriver280 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run DatabaseDriver28(c_db_values_mu,c_once_m,child_DatabaseDriver280);
	child_DatabaseDriver280?0;
	run DatabaseDsn48(c_db_values_mu,c_once_m,child_DatabaseDsn481);
	child_DatabaseDsn481?0;
	run DatabaseDsn48(c_db_values_mu,c_once_m,child_DatabaseDsn482);
	child_DatabaseDsn482?0;
	run DatabaseDsn48(c_db_values_mu,c_once_m,child_DatabaseDsn483);
	child_DatabaseDsn483?0;
	run DatabaseDsn48(c_db_values_mu,c_once_m,child_DatabaseDsn484);
	child_DatabaseDsn484?0;
	run DatabaseDsn48(c_db_values_mu,c_once_m,child_DatabaseDsn485);
	child_DatabaseDsn485?0;
	stop_process: skip;
	child!0
}
proctype DatabaseDriver28(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DatabaseDsn48(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DatabaseName1435 = [1] of {int};
	chan child_DatabaseServer1034 = [1] of {int};
	chan child_DatabasePassword1653 = [1] of {int};
	chan child_DatabaseUser1542 = [1] of {int};
	chan child_DatabasePort12310 = [1] of {int};
	chan child_DatabaseHost1149 = [1] of {int};
	chan child_DatabaseName1438 = [1] of {int};
	chan child_DatabasePassword1657 = [1] of {int};
	chan child_DatabaseUser1546 = [1] of {int};
	chan child_StoragePath27211 = [1] of {int};
	

	if
	:: true -> 
		
		chan child_DatabaseDriver281 = [1] of {int};
		run DatabaseDriver28(c_db_values_mu,c_once_m,child_DatabaseDriver281);
		child_DatabaseDriver281?0
		if
		:: true -> 
			run DatabaseUser154(c_db_values_mu,c_once_m,child_DatabaseUser1542);
			child_DatabaseUser1542?0;
			run DatabasePassword165(c_db_values_mu,c_once_m,child_DatabasePassword1653);
			child_DatabasePassword1653?0;
			run DatabaseServer103(c_db_values_mu,c_once_m,child_DatabaseServer1034);
			child_DatabaseServer1034?0;
			run DatabaseName143(c_db_values_mu,c_once_m,child_DatabaseName1435);
			child_DatabaseName1435?0;
			goto stop_process
		:: true -> 
			run DatabaseUser154(c_db_values_mu,c_once_m,child_DatabaseUser1546);
			child_DatabaseUser1546?0;
			run DatabasePassword165(c_db_values_mu,c_once_m,child_DatabasePassword1657);
			child_DatabasePassword1657?0;
			run DatabaseName143(c_db_values_mu,c_once_m,child_DatabaseName1438);
			child_DatabaseName1438?0;
			run DatabaseHost114(c_db_values_mu,c_once_m,child_DatabaseHost1149);
			child_DatabaseHost1149?0;
			run DatabasePort123(c_db_values_mu,c_once_m,child_DatabasePort12310);
			child_DatabasePort12310?0;
			goto stop_process
		:: true -> 
			run StoragePath272(c_db_values_mu,c_once_m,child_StoragePath27211);
			child_StoragePath27211?0;
			goto stop_process
		:: true -> 
			goto stop_process
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DatabaseUser154(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ParseDatabaseDsn802 = [1] of {int};
	run ParseDatabaseDsn80(c_db_values_mu,c_once_m,child_ParseDatabaseDsn802);
	child_ParseDatabaseDsn802?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ParseDatabaseDsn80(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_matches = -2; // opt var_matches
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype DatabasePassword165(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ParseDatabaseDsn803 = [1] of {int};
	run ParseDatabaseDsn80(c_db_values_mu,c_once_m,child_ParseDatabaseDsn803);
	child_ParseDatabaseDsn803?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DatabaseServer103(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ParseDatabaseDsn804 = [1] of {int};
	run ParseDatabaseDsn80(c_db_values_mu,c_once_m,child_ParseDatabaseDsn804);
	child_ParseDatabaseDsn804?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DatabaseName143(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ParseDatabaseDsn805 = [1] of {int};
	run ParseDatabaseDsn80(c_db_values_mu,c_once_m,child_ParseDatabaseDsn805);
	child_ParseDatabaseDsn805?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DatabaseHost114(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DatabaseServer1039 = [1] of {int};
	run DatabaseServer103(c_db_values_mu,c_once_m,child_DatabaseServer1039);
	child_DatabaseServer1039?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype DatabasePort123(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DatabaseServer10310 = [1] of {int};
	run DatabaseServer103(c_db_values_mu,c_once_m,child_DatabaseServer10310);
	child_DatabaseServer10310?0;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			fi
		fi
	fi;
	stop_process: skip;
	child!0
}
proctype StoragePath272(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ReadOnly38615 = [1] of {int};
	chan child_ReadOnly38614 = [1] of {int};
	chan child_ReadOnly38613 = [1] of {int};
	chan child_ReadOnly38612 = [1] of {int};
	chan child_OriginalsPath20011 = [1] of {int};
	

	if
	:: true -> 
		run OriginalsPath200(c_db_values_mu,c_once_m,child_OriginalsPath20011);
		child_OriginalsPath20011?0;
		run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly38612);
		child_ReadOnly38612?0;
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly38613);
			child_ReadOnly38613?0;
			

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
			run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly38614);
			child_ReadOnly38614?0;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		run ReadOnly386(c_db_values_mu,c_once_m,child_ReadOnly38615);
		child_ReadOnly38615?0;
		

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

