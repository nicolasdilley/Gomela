
// https://github.com/mattermost/mattermost-server/blob/master/model/client4_test.go#L29
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
	chan child_TestClient4CreatePost290 = [1] of {int};
	run TestClient4CreatePost29(child_TestClient4CreatePost290)
stop_process:skip
}

proctype TestClient4CreatePost29(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CreatePost28740 = [1] of {int};
	Mutexdef __propsMu;
	Mutexdef server_mu;
	Wgdef server_wg;
	Mutexdef server_Config_mu;
	Mutexdef server_Config_nextProtoOnce_m;
	Mutexdef server_Config_ErrorLog_mu;
	Mutexdef server_Config_TLSConfig_mutex;
	Mutexdef server_TLS_mutex;
	Mutexdef post_propsMu;
	run mutexMonitor(post_propsMu);
	run mutexMonitor(server_TLS_mutex);
	run mutexMonitor(server_Config_TLSConfig_mutex);
	run mutexMonitor(server_Config_ErrorLog_mu);
	run mutexMonitor(server_Config_nextProtoOnce_m);
	run mutexMonitor(server_Config_mu);
	run wgMonitor(server_wg);
	run mutexMonitor(server_mu);
	run mutexMonitor(__propsMu);
	run CreatePost2874(post_propsMu,child_CreatePost28740);
	child_CreatePost28740?0;
	stop_process: skip;
	child!0
}
proctype CreatePost2874(Mutexdef post_propsMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ToUnsanitizedJson2280 = [1] of {int};
	run ToUnsanitizedJson228(post_propsMu,child_ToUnsanitizedJson2280);
	child_ToUnsanitizedJson2280?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ToUnsanitizedJson228(Mutexdef o_propsMu;chan child) {
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

