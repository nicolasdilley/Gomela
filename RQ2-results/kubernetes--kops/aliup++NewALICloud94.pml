
// https://github.com/kubernetes/kops/blob/master/upup/pkg/fi/cloudup/aliup/ali_cloud.go#L94
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_NewALICloud940 = [1] of {int};
	run NewALICloud94(child_NewALICloud940)
stop_process:skip
}

proctype NewALICloud94(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef config_HttpTransport_nextProtoOnce_m;
	Mutexdef config_HttpTransport_TLSClientConfig_mutex;
	Mutexdef config_HttpTransport_connsPerHostMu;
	Mutexdef config_HttpTransport_altMu;
	Mutexdef config_HttpTransport_reqMu;
	Mutexdef config_HttpTransport_idleMu;
	

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
	run mutexMonitor(config_HttpTransport_idleMu);
	run mutexMonitor(config_HttpTransport_reqMu);
	run mutexMonitor(config_HttpTransport_altMu);
	run mutexMonitor(config_HttpTransport_connsPerHostMu);
	run mutexMonitor(config_HttpTransport_TLSClientConfig_mutex);
	run mutexMonitor(config_HttpTransport_nextProtoOnce_m);
	

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

