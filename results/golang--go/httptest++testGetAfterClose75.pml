// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//net/http/httptest/server_test.go#L75
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
	chan child_testGetAfterClose750 = [1] of {int};
	run testGetAfterClose75(child_testGetAfterClose750);
	run receiver(child_testGetAfterClose750)
stop_process:skip
}

proctype testGetAfterClose75(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close2000 = [1] of {int};
	Mutexdef ts_mu;
	Wgdef ts_wg;
	Mutexdef ts_Config_mu;
	Mutexdef ts_Config_nextProtoOnce_m;
	Mutexdef ts_Config_ErrorLog_mu;
	Mutexdef ts_Config_TLSConfig_mutex;
	Mutexdef ts_TLS_mutex;
	run mutexMonitor(ts_TLS_mutex);
	run mutexMonitor(ts_Config_TLSConfig_mutex);
	run mutexMonitor(ts_Config_ErrorLog_mu);
	run mutexMonitor(ts_Config_nextProtoOnce_m);
	run mutexMonitor(ts_Config_mu);
	run wgMonitor(ts_wg);
	run mutexMonitor(ts_mu);
	run Close200(ts_wg,ts_Config_ErrorLog_mu,ts_Config_mu,ts_Config_nextProtoOnce_m,ts_Config_TLSConfig_mutex,ts_mu,ts_TLS_mutex,child_Close2000);
	child_Close2000?0;
	stop_process: skip;
	child!0
}
proctype Close200(Wgdef s_wg;Mutexdef s_Config_ErrorLog_mu;Mutexdef s_Config_mu;Mutexdef s_Config_nextProtoOnce_m;Mutexdef s_Config_TLSConfig_mutex;Mutexdef s_mu;Mutexdef s_TLS_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_closeConn3710 = [1] of {int};
	chan child_closeConn3711 = [1] of {int};
	int var_s_conns = -2; // opt var_s_conns
	s_mu.Lock!false;
	

	if
	:: true -> 
		

		if
		:: var_s_conns-1 != -3 -> 
						for(i : 0.. var_s_conns-1) {
				for10: skip;
				

				if
				:: true -> 
					run closeConn371(s_wg,s_Config_ErrorLog_mu,s_Config_mu,s_Config_nextProtoOnce_m,s_Config_TLSConfig_mutex,s_mu,s_TLS_mutex,child_closeConn3710);
					child_closeConn3710?0
				:: true;
				fi;
				for10_end: skip
			};
			for10_exit: skip
		:: else -> 
			do
			:: true -> 
				for11: skip;
				

				if
				:: true -> 
					run closeConn371(s_wg,s_Config_ErrorLog_mu,s_Config_mu,s_Config_nextProtoOnce_m,s_Config_TLSConfig_mutex,s_mu,s_TLS_mutex,child_closeConn3711);
					child_closeConn3711?0
				:: true;
				fi;
				for11_end: skip
			:: true -> 
				break
			od;
			for11_exit: skip
		fi
	:: true;
	fi;
	s_mu.Unlock!false;
	s_wg.wait?0;
	stop_process: skip;
	child!0
}
proctype closeConn371(Wgdef s_wg;Mutexdef s_Config_ErrorLog_mu;Mutexdef s_Config_mu;Mutexdef s_Config_nextProtoOnce_m;Mutexdef s_Config_TLSConfig_mutex;Mutexdef s_mu;Mutexdef s_TLS_mutex;chan child) {
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

