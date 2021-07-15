
// https://github.com/gocolly/colly/blob/master/colly_test.go#L1093
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
	chan child_TestHTMLElement10930 = [1] of {int};
	run TestHTMLElement1093(child_TestHTMLElement10930)
stop_process:skip
}

proctype TestHTMLElement1093(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Attr561 = [1] of {int};
	chan child_Attr560 = [1] of {int};
	Mutexdef v_Response_Request_collector_lock;
	Wgdef v_Response_Request_collector_wg;
	Mutexdef v_Response_Request_collector_backend_lock;
	Mutexdef v_Response_Request_Ctx_lock;
	Mutexdef v_Response_Ctx_lock;
	Mutexdef v_Request_collector_lock;
	Wgdef v_Request_collector_wg;
	Mutexdef v_Request_collector_backend_lock;
	Mutexdef v_Request_Ctx_lock;
	Mutexdef resp_Request_collector_lock;
	Wgdef resp_Request_collector_wg;
	Mutexdef resp_Request_collector_backend_lock;
	Mutexdef resp_Request_Ctx_lock;
	Mutexdef resp_Ctx_lock;
	Mutexdef ctx_lock;
	run mutexMonitor(ctx_lock);
	run mutexMonitor(resp_Ctx_lock);
	run mutexMonitor(resp_Request_Ctx_lock);
	run mutexMonitor(resp_Request_collector_backend_lock);
	run wgMonitor(resp_Request_collector_wg);
	run mutexMonitor(resp_Request_collector_lock);
	run mutexMonitor(v_Request_Ctx_lock);
	run mutexMonitor(v_Request_collector_backend_lock);
	run wgMonitor(v_Request_collector_wg);
	run mutexMonitor(v_Request_collector_lock);
	run mutexMonitor(v_Response_Ctx_lock);
	run mutexMonitor(v_Response_Request_Ctx_lock);
	run mutexMonitor(v_Response_Request_collector_backend_lock);
	run wgMonitor(v_Response_Request_collector_wg);
	run mutexMonitor(v_Response_Request_collector_lock);
	run Attr56(v_Request_collector_wg,v_Response_Request_collector_wg,v_Request_Ctx_lock,v_Request_collector_backend_lock,v_Request_collector_lock,v_Response_Ctx_lock,v_Response_Request_Ctx_lock,v_Response_Request_collector_backend_lock,v_Response_Request_collector_lock,child_Attr560);
	child_Attr560?0;
	

	if
	:: true -> 
		run Attr56(v_Request_collector_wg,v_Response_Request_collector_wg,v_Request_Ctx_lock,v_Request_collector_backend_lock,v_Request_collector_lock,v_Response_Ctx_lock,v_Response_Request_Ctx_lock,v_Response_Request_collector_backend_lock,v_Response_Request_collector_lock,child_Attr561);
		child_Attr561?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype Attr56(Wgdef h_Request_collector_wg;Wgdef h_Response_Request_collector_wg;Mutexdef h_Request_Ctx_lock;Mutexdef h_Request_collector_backend_lock;Mutexdef h_Request_collector_lock;Mutexdef h_Response_Ctx_lock;Mutexdef h_Response_Request_Ctx_lock;Mutexdef h_Response_Request_collector_backend_lock;Mutexdef h_Response_Request_collector_lock;chan child) {
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

