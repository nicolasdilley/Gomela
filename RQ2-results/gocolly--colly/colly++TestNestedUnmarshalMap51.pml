
// https://github.com/gocolly/colly/blob/master/unmarshal_test.go#L51
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
	chan child_TestNestedUnmarshalMap510 = [1] of {int};
	run TestNestedUnmarshalMap51(child_TestNestedUnmarshalMap510)
stop_process:skip
}

proctype TestNestedUnmarshalMap51(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_UnmarshalWithMap311 = [1] of {int};
	chan child_UnmarshalWithMap310 = [1] of {int};
	Mutexdef e2_Response_Request_collector_lock;
	Wgdef e2_Response_Request_collector_wg;
	Mutexdef e2_Response_Request_collector_backend_lock;
	Mutexdef e2_Response_Request_Ctx_lock;
	Mutexdef e2_Response_Ctx_lock;
	Mutexdef e2_Request_collector_lock;
	Wgdef e2_Request_collector_wg;
	Mutexdef e2_Request_collector_backend_lock;
	Mutexdef e2_Request_Ctx_lock;
	Mutexdef e_Response_Request_collector_lock;
	Wgdef e_Response_Request_collector_wg;
	Mutexdef e_Response_Request_collector_backend_lock;
	Mutexdef e_Response_Request_Ctx_lock;
	Mutexdef e_Response_Ctx_lock;
	Mutexdef e_Request_collector_lock;
	Wgdef e_Request_collector_wg;
	Mutexdef e_Request_collector_backend_lock;
	Mutexdef e_Request_Ctx_lock;
	run mutexMonitor(e_Request_Ctx_lock);
	run mutexMonitor(e_Request_collector_backend_lock);
	run wgMonitor(e_Request_collector_wg);
	run mutexMonitor(e_Request_collector_lock);
	run mutexMonitor(e_Response_Ctx_lock);
	run mutexMonitor(e_Response_Request_Ctx_lock);
	run mutexMonitor(e_Response_Request_collector_backend_lock);
	run wgMonitor(e_Response_Request_collector_wg);
	run mutexMonitor(e_Response_Request_collector_lock);
	run mutexMonitor(e2_Request_Ctx_lock);
	run mutexMonitor(e2_Request_collector_backend_lock);
	run wgMonitor(e2_Request_collector_wg);
	run mutexMonitor(e2_Request_collector_lock);
	run mutexMonitor(e2_Response_Ctx_lock);
	run mutexMonitor(e2_Response_Request_Ctx_lock);
	run mutexMonitor(e2_Response_Request_collector_backend_lock);
	run wgMonitor(e2_Response_Request_collector_wg);
	run mutexMonitor(e2_Response_Request_collector_lock);
	run UnmarshalWithMap31(e_Request_collector_wg,e_Response_Request_collector_wg,e_Request_Ctx_lock,e_Request_collector_backend_lock,e_Request_collector_lock,e_Response_Ctx_lock,e_Response_Request_Ctx_lock,e_Response_Request_collector_backend_lock,e_Response_Request_collector_lock,child_UnmarshalWithMap310);
	child_UnmarshalWithMap310?0;
	run UnmarshalWithMap31(e2_Request_collector_wg,e2_Response_Request_collector_wg,e2_Request_Ctx_lock,e2_Request_collector_backend_lock,e2_Request_collector_lock,e2_Response_Ctx_lock,e2_Response_Request_Ctx_lock,e2_Response_Request_collector_backend_lock,e2_Response_Request_collector_lock,child_UnmarshalWithMap311);
	child_UnmarshalWithMap311?0;
	stop_process: skip;
	child!0
}
proctype UnmarshalWithMap31(Wgdef h_Request_collector_wg;Wgdef h_Response_Request_collector_wg;Mutexdef h_Request_Ctx_lock;Mutexdef h_Request_collector_backend_lock;Mutexdef h_Request_collector_lock;Mutexdef h_Response_Ctx_lock;Mutexdef h_Response_Request_Ctx_lock;Mutexdef h_Response_Request_collector_backend_lock;Mutexdef h_Response_Request_collector_lock;chan child) {
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

