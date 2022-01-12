// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/db_test.go#L16
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_ParseDatabaseDsn160 = [1] of {int};
	run TestConfig_ParseDatabaseDsn16(child_TestConfig_ParseDatabaseDsn160);
	run receiver(child_TestConfig_ParseDatabaseDsn160)
stop_process:skip
}

proctype TestConfig_ParseDatabaseDsn16(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DatabasePassword1655 = [1] of {int};
	chan child_DatabaseUser1544 = [1] of {int};
	chan child_DatabaseName1433 = [1] of {int};
	chan child_DatabasePort1232 = [1] of {int};
	chan child_DatabaseHost1141 = [1] of {int};
	chan child_DatabaseServer1030 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run DatabaseServer103(c_db_values_mu,c_once_m,child_DatabaseServer1030);
	child_DatabaseServer1030?0;
	run DatabaseHost114(c_db_values_mu,c_once_m,child_DatabaseHost1141);
	child_DatabaseHost1141?0;
	run DatabasePort123(c_db_values_mu,c_once_m,child_DatabasePort1232);
	child_DatabasePort1232?0;
	run DatabaseName143(c_db_values_mu,c_once_m,child_DatabaseName1433);
	child_DatabaseName1433?0;
	run DatabaseUser154(c_db_values_mu,c_once_m,child_DatabaseUser1544);
	child_DatabaseUser1544?0;
	run DatabasePassword165(c_db_values_mu,c_once_m,child_DatabasePassword1655);
	child_DatabasePassword1655?0;
	stop_process: skip;
	child!0
}
proctype DatabaseServer103(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ParseDatabaseDsn800 = [1] of {int};
	run ParseDatabaseDsn80(c_db_values_mu,c_once_m,child_ParseDatabaseDsn800);
	child_ParseDatabaseDsn800?0;
	

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
proctype DatabaseHost114(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DatabaseServer1031 = [1] of {int};
	run DatabaseServer103(c_db_values_mu,c_once_m,child_DatabaseServer1031);
	child_DatabaseServer1031?0;
	

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
	chan child_DatabaseServer1032 = [1] of {int};
	run DatabaseServer103(c_db_values_mu,c_once_m,child_DatabaseServer1032);
	child_DatabaseServer1032?0;
	

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
proctype DatabaseName143(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ParseDatabaseDsn803 = [1] of {int};
	run ParseDatabaseDsn80(c_db_values_mu,c_once_m,child_ParseDatabaseDsn803);
	child_ParseDatabaseDsn803?0;
	

	if
	:: true -> 
		goto stop_process
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
proctype DatabasePassword165(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ParseDatabaseDsn805 = [1] of {int};
	run ParseDatabaseDsn80(c_db_values_mu,c_once_m,child_ParseDatabaseDsn805);
	child_ParseDatabaseDsn805?0;
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

