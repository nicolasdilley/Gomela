
// https://github.com/caddyserver/caddy/blob/master/admin.go#L412
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_replaceRemoteAdminServer4120 = [1] of {int};
	run replaceRemoteAdminServer412(child_replaceRemoteAdminServer4120)
stop_process:skip
}

proctype replaceRemoteAdminServer412(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousreplaceRemoteAdminServer4224220 = [1] of {int};
	chan child_AnonymousreplaceRemoteAdminServer4904191 = [1] of {int};
	Mutexdef serverLogger_mu;
	Mutexdef tlsConfig_mutex;
	Mutexdef cmCfg_certCache_mu;
	Mutexdef handler_mux_mu;
	Mutexdef oldAdminServer_mu;
	Mutexdef oldAdminServer_nextProtoOnce_m;
	Mutexdef oldAdminServer_ErrorLog_mu;
	Mutexdef oldAdminServer_TLSConfig_mutex;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(oldAdminServer_TLSConfig_mutex);
	run mutexMonitor(oldAdminServer_ErrorLog_mu);
	run mutexMonitor(oldAdminServer_nextProtoOnce_m);
	run mutexMonitor(oldAdminServer_mu);
	

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
	run mutexMonitor(handler_mux_mu);
	run mutexMonitor(cmCfg_certCache_mu);
	run mutexMonitor(tlsConfig_mutex);
	run mutexMonitor(serverLogger_mu);
	

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
	run AnonymousreplaceRemoteAdminServer490419(oldAdminServer_TLSConfig_mutex,oldAdminServer_ErrorLog_mu,oldAdminServer_nextProtoOnce_m,oldAdminServer_mu,handler_mux_mu,cmCfg_certCache_mu,tlsConfig_mutex,serverLogger_mu,child_AnonymousreplaceRemoteAdminServer4904191);
	goto stop_process;
	stop_process: skip;
		

	if
	:: true -> 
		run AnonymousreplaceRemoteAdminServer422422(oldAdminServer_TLSConfig_mutex,oldAdminServer_ErrorLog_mu,oldAdminServer_nextProtoOnce_m,oldAdminServer_mu,child_AnonymousreplaceRemoteAdminServer4224220)
	:: true;
	fi;
	child!0
}
proctype AnonymousreplaceRemoteAdminServer422422(Mutexdef oldAdminServer_TLSConfig_mutex;Mutexdef oldAdminServer_ErrorLog_mu;Mutexdef oldAdminServer_nextProtoOnce_m;Mutexdef oldAdminServer_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_stopAdminServer6070 = [1] of {int};
	run stopAdminServer607(oldAdminServer_TLSConfig_mutex,oldAdminServer_ErrorLog_mu,oldAdminServer_nextProtoOnce_m,oldAdminServer_mu,child_stopAdminServer6070);
	child_stopAdminServer6070?0;
	stop_process: skip;
	child!0
}
proctype stopAdminServer607(Mutexdef srv_TLSConfig_mutex;Mutexdef srv_ErrorLog_mu;Mutexdef srv_nextProtoOnce_m;Mutexdef srv_mu;chan child) {
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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousreplaceRemoteAdminServer490419(Mutexdef oldAdminServer_TLSConfig_mutex;Mutexdef oldAdminServer_ErrorLog_mu;Mutexdef oldAdminServer_nextProtoOnce_m;Mutexdef oldAdminServer_mu;Mutexdef handler_mux_mu;Mutexdef cmCfg_certCache_mu;Mutexdef tlsConfig_mutex;Mutexdef serverLogger_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

