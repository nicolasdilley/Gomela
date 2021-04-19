
// https://github.com/moby/moby/blob/master/testutil/fakegit/fakegit.go#L49
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_New490 = [1] of {int};
	run New49(child_New490)
stop_process:skip
}

proctype New49(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef httpServer_mu;
	Wgdef httpServer_wg;
	Mutexdef httpServer_Config_mu;
	Mutexdef httpServer_Config_nextProtoOnce_m;
	Mutexdef httpServer_Config_ErrorLog_mu;
	Mutexdef httpServer_Config_TLSConfig_mutex;
	Mutexdef httpServer_TLS_mutex;
	

	if
	:: true -> 
		run mutexMonitor(httpServer_TLS_mutex);
		run mutexMonitor(httpServer_Config_TLSConfig_mutex);
		run mutexMonitor(httpServer_Config_ErrorLog_mu);
		run mutexMonitor(httpServer_Config_nextProtoOnce_m);
		run mutexMonitor(httpServer_Config_mu);
		run wgMonitor(httpServer_wg);
		run mutexMonitor(httpServer_mu)
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

