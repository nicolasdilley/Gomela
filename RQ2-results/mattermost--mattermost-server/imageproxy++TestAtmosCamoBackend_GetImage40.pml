
// https://github.com/mattermost/mattermost-server/blob/master/services/imageproxy/atmos_camo_test.go#L40
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAtmosCamoBackend_GetImage400 = [1] of {int};
	run TestAtmosCamoBackend_GetImage40(child_TestAtmosCamoBackend_GetImage400)
stop_process:skip
}

proctype TestAtmosCamoBackend_GetImage40(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetImage1000 = [1] of {int};
	Mutexdef proxy_lock;
	Mutexdef proxy_Logger_mutex;
	Mutexdef proxy_Logger_logrLogger_logr_metricsCloseOnce_m;
	Mutexdef proxy_Logger_logrLogger_logr_metricsInitOnce_m;
	Mutexdef proxy_Logger_logrLogger_logr_once_m;
	Mutexdef proxy_Logger_logrLogger_logr_mux;
	Mutexdef proxy_Logger_logrLogger_logr_tmux;
	run mutexMonitor(proxy_Logger_logrLogger_logr_tmux);
	run mutexMonitor(proxy_Logger_logrLogger_logr_mux);
	run mutexMonitor(proxy_Logger_logrLogger_logr_once_m);
	run mutexMonitor(proxy_Logger_logrLogger_logr_metricsInitOnce_m);
	run mutexMonitor(proxy_Logger_logrLogger_logr_metricsCloseOnce_m);
	run mutexMonitor(proxy_Logger_mutex);
	run mutexMonitor(proxy_lock);
	run GetImage100(proxy_Logger_logrLogger_logr_tmux,proxy_Logger_logrLogger_logr_mux,proxy_Logger_logrLogger_logr_once_m,proxy_Logger_logrLogger_logr_metricsInitOnce_m,proxy_Logger_logrLogger_logr_metricsCloseOnce_m,proxy_Logger_mutex,proxy_lock,child_GetImage1000);
	child_GetImage1000?0;
	stop_process: skip;
	child!0
}
proctype GetImage100(Mutexdef proxy_Logger_logrLogger_logr_tmux;Mutexdef proxy_Logger_logrLogger_logr_mux;Mutexdef proxy_Logger_logrLogger_logr_once_m;Mutexdef proxy_Logger_logrLogger_logr_metricsInitOnce_m;Mutexdef proxy_Logger_logrLogger_logr_metricsCloseOnce_m;Mutexdef proxy_Logger_mutex;Mutexdef proxy_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	proxy_lock.RLock!false;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
		proxy_lock.RUnlock!false;
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

