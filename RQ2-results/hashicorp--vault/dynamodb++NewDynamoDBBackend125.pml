
// https://github.com/hashicorp/vault/blob/master/physical/dynamodb/dynamodb.go#L125
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewDynamoDBBackend1250 = [1] of {int};
	run NewDynamoDBBackend125(child_NewDynamoDBBackend1250)
stop_process:skip
}

proctype NewDynamoDBBackend125(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ensureTableExists8000 = [1] of {int};
	Mutexdef client_endpointCache_endpoints_mu;
	Mutexdef awsSession_options_Config_Credentials_m;
	Mutexdef awsSession_options_Config_Credentials_sf_mu;
	Mutexdef awsSession_Config_Credentials_m;
	Mutexdef awsSession_Config_Credentials_sf_mu;
	Mutexdef awsConf_Credentials_m;
	Mutexdef awsConf_Credentials_sf_mu;
	Mutexdef pooledTransport_nextProtoOnce_m;
	Mutexdef pooledTransport_TLSClientConfig_mutex;
	Mutexdef pooledTransport_connsPerHostMu;
	Mutexdef pooledTransport_altMu;
	Mutexdef pooledTransport_reqMu;
	Mutexdef pooledTransport_idleMu;
	Mutexdef creds_m;
	Mutexdef creds_sf_mu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run mutexMonitor(creds_sf_mu);
	run mutexMonitor(creds_m);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(pooledTransport_idleMu);
	run mutexMonitor(pooledTransport_reqMu);
	run mutexMonitor(pooledTransport_altMu);
	run mutexMonitor(pooledTransport_connsPerHostMu);
	run mutexMonitor(pooledTransport_TLSClientConfig_mutex);
	run mutexMonitor(pooledTransport_nextProtoOnce_m);
	run mutexMonitor(awsConf_Credentials_sf_mu);
	run mutexMonitor(awsConf_Credentials_m);
	run mutexMonitor(awsSession_Config_Credentials_sf_mu);
	run mutexMonitor(awsSession_Config_Credentials_m);
	run mutexMonitor(awsSession_options_Config_Credentials_sf_mu);
	run mutexMonitor(awsSession_options_Config_Credentials_m);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(client_endpointCache_endpoints_mu);
	run ensureTableExists800(client_endpointCache_endpoints_mu,child_ensureTableExists8000);
	child_ensureTableExists8000?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ensureTableExists800(Mutexdef client_endpointCache_endpoints_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

