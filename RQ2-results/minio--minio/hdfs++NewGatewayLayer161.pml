
// https://github.com/minio/minio/blob/master/cmd/gateway/hdfs/gateway-hdfs.go#L161
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewGatewayLayer1610 = [1] of {int};
	run NewGatewayLayer161(child_NewGatewayLayer1610)
stop_process:skip
}

proctype NewGatewayLayer161(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef clnt_options_KerberosClient_cache_mux;
	Mutexdef clnt_options_KerberosClient_sessions_mux;
	Mutexdef clnt_options_KerberosClient_settings_logger_mu;
	Mutexdef clnt_namenode_reqLock;
	Mutexdef clnt_namenode_kerberosClient_cache_mux;
	Mutexdef clnt_namenode_kerberosClient_sessions_mux;
	Mutexdef clnt_namenode_kerberosClient_settings_logger_mu;
	Mutexdef opts_KerberosClient_cache_mux;
	Mutexdef opts_KerberosClient_sessions_mux;
	Mutexdef opts_KerberosClient_settings_logger_mu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(opts_KerberosClient_settings_logger_mu);
	run mutexMonitor(opts_KerberosClient_sessions_mux);
	run mutexMonitor(opts_KerberosClient_cache_mux);
	

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
	fi;
	run mutexMonitor(clnt_namenode_kerberosClient_settings_logger_mu);
	run mutexMonitor(clnt_namenode_kerberosClient_sessions_mux);
	run mutexMonitor(clnt_namenode_kerberosClient_cache_mux);
	run mutexMonitor(clnt_namenode_reqLock);
	run mutexMonitor(clnt_options_KerberosClient_settings_logger_mu);
	run mutexMonitor(clnt_options_KerberosClient_sessions_mux);
	run mutexMonitor(clnt_options_KerberosClient_cache_mux);
	

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

