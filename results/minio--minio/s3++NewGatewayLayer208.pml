
// https://github.com/minio/minio/blob/master/cmd/gateway/s3/gateway-s3.go#L208
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewGatewayLayer2080 = [1] of {int};
	run NewGatewayLayer208(child_NewGatewayLayer2080)
stop_process:skip
}

proctype NewGatewayLayer208(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newS31650 = [1] of {int};
	Mutexdef t_Transport_nextProtoOnce_m;
	Mutexdef t_Transport_TLSClientConfig_mutex;
	Mutexdef t_Transport_connsPerHostMu;
	Mutexdef t_Transport_altMu;
	Mutexdef t_Transport_reqMu;
	Mutexdef t_Transport_idleMu;
	run mutexMonitor(t_Transport_idleMu);
	run mutexMonitor(t_Transport_reqMu);
	run mutexMonitor(t_Transport_altMu);
	run mutexMonitor(t_Transport_connsPerHostMu);
	run mutexMonitor(t_Transport_TLSClientConfig_mutex);
	run mutexMonitor(t_Transport_nextProtoOnce_m);
	run newS3165(t_Transport_idleMu,t_Transport_reqMu,t_Transport_altMu,t_Transport_connsPerHostMu,t_Transport_TLSClientConfig_mutex,t_Transport_nextProtoOnce_m,child_newS31650);
	child_newS31650?0;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newS3165(Mutexdef tripper_Transport_idleMu;Mutexdef tripper_Transport_reqMu;Mutexdef tripper_Transport_altMu;Mutexdef tripper_Transport_connsPerHostMu;Mutexdef tripper_Transport_TLSClientConfig_mutex;Mutexdef tripper_Transport_nextProtoOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

