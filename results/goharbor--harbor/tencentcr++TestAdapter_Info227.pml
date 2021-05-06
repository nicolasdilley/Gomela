
// https://github.com/goharbor/harbor/blob/master/src/pkg/reg/adapter/tencentcr/adapter_test.go#L227
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
	chan child_TestAdapter_Info2270 = [1] of {int};
	run TestAdapter_Info227(child_TestAdapter_Info2270)
stop_process:skip
}

proctype TestAdapter_Info227(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef __mu;
	Wgdef __wg;
	Mutexdef __Config_mu;
	Mutexdef __Config_nextProtoOnce_m;
	Mutexdef __Config_ErrorLog_mu;
	Mutexdef __Config_TLSConfig_mutex;
	Mutexdef __TLS_mutex;
	run mutexMonitor(__TLS_mutex);
	run mutexMonitor(__Config_TLSConfig_mutex);
	run mutexMonitor(__Config_ErrorLog_mu);
	run mutexMonitor(__Config_nextProtoOnce_m);
	run mutexMonitor(__Config_mu);
	run wgMonitor(__wg);
	run mutexMonitor(__mu);
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

