
// https://github.com/minio/minio/blob/master/cmd/gateway/gcs/gateway-gcs.go#L167
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewGatewayLayer1670 = [1] of {int};
	run NewGatewayLayer167(child_NewGatewayLayer1670)
stop_process:skip
}

proctype NewGatewayLayer167(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef t_Transport_nextProtoOnce_m;
	Mutexdef t_Transport_TLSClientConfig_mutex;
	Mutexdef t_Transport_connsPerHostMu;
	Mutexdef t_Transport_altMu;
	Mutexdef t_Transport_reqMu;
	Mutexdef t_Transport_idleMu;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run mutexMonitor(t_Transport_idleMu);
	run mutexMonitor(t_Transport_reqMu);
	run mutexMonitor(t_Transport_altMu);
	run mutexMonitor(t_Transport_connsPerHostMu);
	run mutexMonitor(t_Transport_TLSClientConfig_mutex);
	run mutexMonitor(t_Transport_nextProtoOnce_m);
	

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

