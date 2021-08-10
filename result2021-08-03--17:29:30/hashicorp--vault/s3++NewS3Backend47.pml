// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/physical/s3/s3.go#L47
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewS3Backend470 = [1] of {int};
	run NewS3Backend47(child_NewS3Backend470);
	run receiver(child_NewS3Backend470)
stop_process:skip
}

proctype NewS3Backend47(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

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

