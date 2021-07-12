// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/http/httptest/server_test.go#L179
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
	chan child_testTLSServerClientTransportType1790 = [1] of {int};
	run testTLSServerClientTransportType179(child_testTLSServerClientTransportType1790);
	run receiver(child_testTLSServerClientTransportType1790)
stop_process:skip
}

proctype testTLSServerClientTransportType179(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close2000 = [1] of {int};
	Mutexdef __nextProtoOnce_m;
	Mutexdef __TLSClientConfig_mutex;
	Mutexdef __connsPerHostMu;
	Mutexdef __altMu;
	Mutexdef __reqMu;
	Mutexdef __idleMu;
	chan child_Client3001 = [1] of {int};
	Mutexdef ts_mu;
	Wgdef ts_wg;
	Mutexdef ts_Config_mu;
	Mutexdef ts_TLS_mutex;
	run mutexMonitor(ts_TLS_mutex);
	run mutexMonitor(ts_Config_mu);
	run wgMonitor(ts_wg);
	run mutexMonitor(ts_mu);
	run Client300(ts_wg,ts_Config_mu,ts_mu,ts_TLS_mutex,child_Client3001);
	child_Client3001?0;
	run mutexMonitor(__idleMu);
	run mutexMonitor(__reqMu);
	run mutexMonitor(__altMu);
	run mutexMonitor(__connsPerHostMu);
	run mutexMonitor(__TLSClientConfig_mutex);
	run mutexMonitor(__nextProtoOnce_m);
		defer1: skip;
	run Close200(ts_wg,ts_Config_mu,ts_mu,ts_TLS_mutex,child_Close2000);
	child_Close2000?0;
	stop_process: skip;
	child!0
}
proctype Close200(Wgdef s_wg;Mutexdef s_Config_mu;Mutexdef s_mu;Mutexdef s_TLS_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_closeConn3710 = [1] of {int};
	chan child_closeConn3711 = [1] of {int};
	int var_s_connss_conns = -2; // opt var_s_connss_conns
	s_mu.Lock!false;
	

	if
	:: true -> 
		

		if
		:: var_s_conns-1 != -3 -> 
						for(i : 0.. var_s_conns-1) {
				for10: skip;
				

				if
				:: true -> 
					run closeConn371(s_wg,s_Config_mu,s_mu,s_TLS_mutex,child_closeConn3710);
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
					run closeConn371(s_wg,s_Config_mu,s_mu,s_TLS_mutex,child_closeConn3711);
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
proctype closeConn371(Wgdef s_wg;Mutexdef s_Config_mu;Mutexdef s_mu;Mutexdef s_TLS_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Client300(Wgdef s_wg;Mutexdef s_Config_mu;Mutexdef s_mu;Mutexdef s_TLS_mutex;chan child) {
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

