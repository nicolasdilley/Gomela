
// https://github.com/kubernetes/kubernetes/blob/master/test/integration/replicaset/replicaset_test.go#L469
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
	chan child_TestRSSelectorImmutability4690 = [1] of {int};
	run TestRSSelectorImmutability469(child_TestRSSelectorImmutability4690)
stop_process:skip
}

proctype TestRSSelectorImmutability469(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef s_mu;
	Wgdef s_wg;
	Mutexdef s_Config_mu;
	Mutexdef s_Config_nextProtoOnce_m;
	Mutexdef s_Config_ErrorLog_mu;
	Mutexdef s_Config_TLSConfig_mutex;
	Mutexdef s_TLS_mutex;
	run mutexMonitor(s_TLS_mutex);
	run mutexMonitor(s_Config_TLSConfig_mutex);
	run mutexMonitor(s_Config_ErrorLog_mu);
	run mutexMonitor(s_Config_nextProtoOnce_m);
	run mutexMonitor(s_Config_mu);
	run wgMonitor(s_wg);
	run mutexMonitor(s_mu);
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

