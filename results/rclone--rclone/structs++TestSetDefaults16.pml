
// https://github.com/rclone/rclone/blob/master/lib/structs/structs_test.go#L16
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSetDefaults160 = [1] of {int};
	run TestSetDefaults16(child_TestSetDefaults160)
stop_process:skip
}

proctype TestSetDefaults16(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetDefaults440 = [1] of {int};
	Mutexdef newT_nextProtoOnce_m;
	Mutexdef newT_TLSClientConfig_mutex;
	Mutexdef newT_connsPerHostMu;
	Mutexdef newT_altMu;
	Mutexdef newT_reqMu;
	Mutexdef newT_idleMu;
	Mutexdef old_nextProtoOnce_m;
	Mutexdef old_TLSClientConfig_mutex;
	Mutexdef old_connsPerHostMu;
	Mutexdef old_altMu;
	Mutexdef old_reqMu;
	Mutexdef old_idleMu;
	run mutexMonitor(old_idleMu);
	run mutexMonitor(old_reqMu);
	run mutexMonitor(old_altMu);
	run mutexMonitor(old_connsPerHostMu);
	run mutexMonitor(old_TLSClientConfig_mutex);
	run mutexMonitor(old_nextProtoOnce_m);
	run mutexMonitor(newT_idleMu);
	run mutexMonitor(newT_reqMu);
	run mutexMonitor(newT_altMu);
	run mutexMonitor(newT_connsPerHostMu);
	run mutexMonitor(newT_TLSClientConfig_mutex);
	run mutexMonitor(newT_nextProtoOnce_m);
	run SetDefaults44(newT_idleMu,newT_reqMu,newT_altMu,newT_connsPerHostMu,newT_TLSClientConfig_mutex,newT_nextProtoOnce_m,newT_idleMu,newT_reqMu,newT_altMu,newT_connsPerHostMu,newT_TLSClientConfig_mutex,newT_nextProtoOnce_m,child_SetDefaults440);
	child_SetDefaults440?0;
	stop_process: skip;
	child!0
}
proctype SetDefaults44(Mutexdef a_idleMu;Mutexdef a_reqMu;Mutexdef a_altMu;Mutexdef a_connsPerHostMu;Mutexdef a_TLSClientConfig_mutex;Mutexdef a_nextProtoOnce_m;Mutexdef b_idleMu;Mutexdef b_reqMu;Mutexdef b_altMu;Mutexdef b_connsPerHostMu;Mutexdef b_TLSClientConfig_mutex;Mutexdef b_nextProtoOnce_m;chan child) {
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

