// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/http_listener_v2/http_listener_v2_test.go#L423
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
	chan child_TestWriteHTTPHighTraffic4230 = [1] of {int};
	run TestWriteHTTPHighTraffic423(child_TestWriteHTTPHighTraffic4230);
	run receiver(child_TestWriteHTTPHighTraffic4230)
stop_process:skip
}

proctype TestWriteHTTPHighTraffic423(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stop1961 = [1] of {int};
	chan child_Gather1294 = [1] of {int};
	chan child_AnonymousTestWriteHTTPHighTraffic4374372 = [1] of {int};
	Wgdef wg;
	chan child_Start1380 = [1] of {int};
	Wgdef listener_wg;
	run wgMonitor(listener_wg);
	run Start138(listener_wg,child_Start1380);
	child_Start1380?0;
	run wgMonitor(wg);
		for(i : 0.. 10-1) {
		for10: skip;
		wg.update!1;
		run AnonymousTestWriteHTTPHighTraffic437437(wg,listener_wg,child_AnonymousTestWriteHTTPHighTraffic4374372);
		run receiver(child_AnonymousTestWriteHTTPHighTraffic4374372);
		for10_end: skip
	};
	for10_exit: skip;
	wg.wait?0;
	run Gather129(listener_wg,child_Gather1294);
	child_Gather1294?0;
		defer1: skip;
	run Stop196(listener_wg,child_Stop1961);
	child_Stop1961?0;
	stop_process: skip;
	child!0
}
proctype Start138(Wgdef h_wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousStart18300 = [1] of {int};
	Mutexdef server_mu;
	Mutexdef server_nextProtoOnce_m;
	Mutexdef server_ErrorLog_mu;
	Mutexdef server_TLSConfig_mutex;
	Mutexdef tlsConf_mutex;
	run mutexMonitor(tlsConf_mutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(server_TLSConfig_mutex);
	run mutexMonitor(server_ErrorLog_mu);
	run mutexMonitor(server_nextProtoOnce_m);
	run mutexMonitor(server_mu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	h_wg.update!1;
	run AnonymousStart1830(h_wg,tlsConf_mutex,server_TLSConfig_mutex,server_ErrorLog_mu,server_nextProtoOnce_m,server_mu,child_AnonymousStart18300);
	run receiver(child_AnonymousStart18300);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousStart1830(Wgdef h_wg;Mutexdef tlsConf_mutex;Mutexdef server_TLSConfig_mutex;Mutexdef server_ErrorLog_mu;Mutexdef server_nextProtoOnce_m;Mutexdef server_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
		defer1: skip;
	h_wg.update!-1;
	stop_process: skip;
	child!0
}
proctype Stop196(Wgdef h_wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	h_wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymousTestWriteHTTPHighTraffic437437(Wgdef innerwg;Wgdef listener_wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_createURL973 = [1] of {int};
	chan child_createURL972 = [1] of {int};
	

	if
	:: 0 != -2 && 500-1 != -3 -> 
				for(i : 0.. 500-1) {
			for12: skip;
			run createURL97(listener_wg,child_createURL973);
			child_createURL973?0;
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			for12_end: skip
		};
		for12_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run createURL97(listener_wg,child_createURL972);
			child_createURL972?0;
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
		defer1: skip;
	innerwg.update!-1;
	stop_process: skip;
	child!0
}
proctype createURL97(Wgdef listener_wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Gather129(Wgdef h_wg;chan child) {
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

proctype receiver(chan c) {
c?0
}

