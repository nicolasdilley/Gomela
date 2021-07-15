
// https://github.com/jaegertracing/jaeger/blob/master/cmd/flags/admin_test.go#L29
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAdminServerHandlesPortZero290 = [1] of {int};
	run TestAdminServerHandlesPortZero29(child_TestAdminServerHandlesPortZero290)
stop_process:skip
}

proctype TestAdminServerHandlesPortZero29(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1362 = [1] of {int};
	Mutexdef message_mu;
	chan child_Serve891 = [1] of {int};
	chan child_initFromViper770 = [1] of {int};
	Mutexdef logs_mu;
	Mutexdef adminServer_server_mu;
	Mutexdef adminServer_server_nextProtoOnce_m;
	Mutexdef adminServer_server_ErrorLog_mu;
	Mutexdef adminServer_server_TLSConfig_mutex;
	Mutexdef adminServer_mux_mu;
	run mutexMonitor(adminServer_mux_mu);
	run mutexMonitor(adminServer_server_TLSConfig_mutex);
	run mutexMonitor(adminServer_server_ErrorLog_mu);
	run mutexMonitor(adminServer_server_nextProtoOnce_m);
	run mutexMonitor(adminServer_server_mu);
	run mutexMonitor(logs_mu);
	run initFromViper77(adminServer_mux_mu,adminServer_server_TLSConfig_mutex,adminServer_server_ErrorLog_mu,adminServer_server_nextProtoOnce_m,adminServer_server_mu,child_initFromViper770);
	child_initFromViper770?0;
	run Serve89(adminServer_mux_mu,adminServer_server_TLSConfig_mutex,adminServer_server_ErrorLog_mu,adminServer_server_nextProtoOnce_m,adminServer_server_mu,child_Serve891);
	child_Serve891?0;
	run mutexMonitor(message_mu);
	stop_process: skip;
		run Close136(adminServer_mux_mu,adminServer_server_TLSConfig_mutex,adminServer_server_ErrorLog_mu,adminServer_server_nextProtoOnce_m,adminServer_server_mu,child_Close1362);
	child_Close1362?0;
	child!0
}
proctype initFromViper77(Mutexdef s_mux_mu;Mutexdef s_server_TLSConfig_mutex;Mutexdef s_server_ErrorLog_mu;Mutexdef s_server_nextProtoOnce_m;Mutexdef s_server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_setLogger660 = [1] of {int};
	run setLogger66(s_mux_mu,s_server_TLSConfig_mutex,s_server_ErrorLog_mu,s_server_nextProtoOnce_m,s_server_mu,child_setLogger660);
	child_setLogger660?0;
	stop_process: skip;
	child!0
}
proctype setLogger66(Mutexdef s_mux_mu;Mutexdef s_server_TLSConfig_mutex;Mutexdef s_server_ErrorLog_mu;Mutexdef s_server_nextProtoOnce_m;Mutexdef s_server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Serve89(Mutexdef s_mux_mu;Mutexdef s_server_TLSConfig_mutex;Mutexdef s_server_ErrorLog_mu;Mutexdef s_server_nextProtoOnce_m;Mutexdef s_server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_serveWithListener1041 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run serveWithListener104(s_mux_mu,s_server_TLSConfig_mutex,s_server_ErrorLog_mu,s_server_nextProtoOnce_m,s_server_mu,child_serveWithListener1041);
	child_serveWithListener1041?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype serveWithListener104(Mutexdef s_mux_mu;Mutexdef s_server_TLSConfig_mutex;Mutexdef s_server_ErrorLog_mu;Mutexdef s_server_nextProtoOnce_m;Mutexdef s_server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousserveWithListener11204 = [1] of {int};
	chan child_registerPprofHandlers1233 = [1] of {int};
	chan child_RegisterHandler252 = [1] of {int};
	chan child_Handle841 = [1] of {int};
	run Handle84(s_mux_mu,child_Handle841);
	child_Handle841?0;
	run RegisterHandler25(s_mux_mu,child_RegisterHandler252);
	child_RegisterHandler252?0;
	run registerPprofHandlers123(s_mux_mu,s_server_TLSConfig_mutex,s_server_ErrorLog_mu,s_server_nextProtoOnce_m,s_server_mu,child_registerPprofHandlers1233);
	child_registerPprofHandlers1233?0;
	run AnonymousserveWithListener1120(s_mux_mu,s_server_TLSConfig_mutex,s_server_ErrorLog_mu,s_server_nextProtoOnce_m,s_server_mu,child_AnonymousserveWithListener11204);
	stop_process: skip;
	child!0
}
proctype Handle84(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype RegisterHandler25(Mutexdef mu_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype registerPprofHandlers123(Mutexdef s_mux_mu;Mutexdef s_server_TLSConfig_mutex;Mutexdef s_server_ErrorLog_mu;Mutexdef s_server_nextProtoOnce_m;Mutexdef s_server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Handle846 = [1] of {int};
	chan child_Handle845 = [1] of {int};
	chan child_Handle844 = [1] of {int};
	chan child_Handle843 = [1] of {int};
	run Handle84(s_mux_mu,child_Handle843);
	child_Handle843?0;
	run Handle84(s_mux_mu,child_Handle844);
	child_Handle844?0;
	run Handle84(s_mux_mu,child_Handle845);
	child_Handle845?0;
	run Handle84(s_mux_mu,child_Handle846);
	child_Handle846?0;
	stop_process: skip;
	child!0
}
proctype AnonymousserveWithListener1120(Mutexdef s_mux_mu;Mutexdef s_server_TLSConfig_mutex;Mutexdef s_server_ErrorLog_mu;Mutexdef s_server_nextProtoOnce_m;Mutexdef s_server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype Close136(Mutexdef s_mux_mu;Mutexdef s_server_TLSConfig_mutex;Mutexdef s_server_ErrorLog_mu;Mutexdef s_server_nextProtoOnce_m;Mutexdef s_server_mu;chan child) {
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

