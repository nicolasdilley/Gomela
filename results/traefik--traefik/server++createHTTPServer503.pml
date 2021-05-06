
// https://github.com/traefik/traefik/blob/master/pkg/server/server_entrypoint_tcp.go#L503
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_createHTTPServer5030 = [1] of {int};
	run createHTTPServer503(child_createHTTPServer5030)
stop_process:skip
}

proctype createHTTPServer503(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymouscreateHTTPServer5305041 = [1] of {int};
	Mutexdef serverHTTP_mu;
	Mutexdef serverHTTP_nextProtoOnce_m;
	Mutexdef serverHTTP_ErrorLog_mu;
	Mutexdef serverHTTP_TLSConfig_mutex;
	chan child_NewXForwarded530 = [1] of {int};
	Mutexdef httpSwitcher_handler_lock;
	run mutexMonitor(httpSwitcher_handler_lock);
	run NewXForwarded53(httpSwitcher_handler_lock,child_NewXForwarded530);
	child_NewXForwarded530?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(serverHTTP_TLSConfig_mutex);
	run mutexMonitor(serverHTTP_ErrorLog_mu);
	run mutexMonitor(serverHTTP_nextProtoOnce_m);
	run mutexMonitor(serverHTTP_mu);
	run AnonymouscreateHTTPServer530504(httpSwitcher_handler_lock,serverHTTP_TLSConfig_mutex,serverHTTP_ErrorLog_mu,serverHTTP_nextProtoOnce_m,serverHTTP_mu,child_AnonymouscreateHTTPServer5305041);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NewXForwarded53(Mutexdef next_handler_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
proctype AnonymouscreateHTTPServer530504(Mutexdef httpSwitcher_handler_lock;Mutexdef serverHTTP_TLSConfig_mutex;Mutexdef serverHTTP_ErrorLog_mu;Mutexdef serverHTTP_nextProtoOnce_m;Mutexdef serverHTTP_mu;chan child) {
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

