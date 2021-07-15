
// https://github.com/caddyserver/caddy/blob/master/admin.go#L286
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_replaceLocalAdminServer2860 = [1] of {int};
	run replaceLocalAdminServer286(child_replaceLocalAdminServer2860)
stop_process:skip
}

proctype replaceLocalAdminServer286(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousreplaceLocalAdminServer2982980 = [1] of {int};
	chan child_AnonymousreplaceLocalAdminServer3422921 = [1] of {int};
	Mutexdef handler_mux_mu;
	Mutexdef oldAdminServer_mu;
	Mutexdef oldAdminServer_nextProtoOnce_m;
	Mutexdef oldAdminServer_ErrorLog_mu;
	Mutexdef oldAdminServer_TLSConfig_mutex;
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run AnonymousreplaceLocalAdminServer342292(oldAdminServer_TLSConfig_mutex,oldAdminServer_ErrorLog_mu,oldAdminServer_nextProtoOnce_m,oldAdminServer_mu,handler_mux_mu,child_AnonymousreplaceLocalAdminServer3422921);
	goto stop_process;
	stop_process: skip;
		

	if
	:: true -> 
		run AnonymousreplaceLocalAdminServer298298(oldAdminServer_TLSConfig_mutex,oldAdminServer_ErrorLog_mu,oldAdminServer_nextProtoOnce_m,oldAdminServer_mu,child_AnonymousreplaceLocalAdminServer2982980)
	:: true;
	fi;
	child!0
}
proctype AnonymousreplaceLocalAdminServer298298(Mutexdef oldAdminServer_TLSConfig_mutex;Mutexdef oldAdminServer_ErrorLog_mu;Mutexdef oldAdminServer_nextProtoOnce_m;Mutexdef oldAdminServer_mu;chan child) {
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
proctype AnonymousreplaceLocalAdminServer342292(Mutexdef oldAdminServer_TLSConfig_mutex;Mutexdef oldAdminServer_ErrorLog_mu;Mutexdef oldAdminServer_nextProtoOnce_m;Mutexdef oldAdminServer_mu;Mutexdef handler_mux_mu;chan child) {
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

