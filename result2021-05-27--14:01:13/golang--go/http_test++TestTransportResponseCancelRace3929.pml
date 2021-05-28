// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/http/transport_test.go#L3929
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
	chan child_TestTransportResponseCancelRace39290 = [1] of {int};
	run TestTransportResponseCancelRace3929(child_TestTransportResponseCancelRace39290);
	run receiver(child_TestTransportResponseCancelRace39290)
stop_process:skip
}

proctype TestTransportResponseCancelRace3929(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close18370 = [1] of {int};
	chan child_RoundTrip1092 = [1] of {int};
	chan child_RoundTrip1091 = [1] of {int};
	Mutexdef tr_nextProtoOnce_m;
	Mutexdef tr_TLSClientConfig_mutex;
	Mutexdef tr_connsPerHostMu;
	Mutexdef tr_altMu;
	Mutexdef tr_reqMu;
	Mutexdef tr_idleMu;
	Mutexdef ts_mu;
	Wgdef ts_wg;
	Mutexdef ts_Config_mu;
	Mutexdef ts_TLS_mutex;
	run mutexMonitor(ts_TLS_mutex);
	run mutexMonitor(ts_Config_mu);
	run wgMonitor(ts_wg);
	run mutexMonitor(ts_mu);
	run mutexMonitor(tr_idleMu);
	run mutexMonitor(tr_reqMu);
	run mutexMonitor(tr_altMu);
	run mutexMonitor(tr_connsPerHostMu);
	run mutexMonitor(tr_TLSClientConfig_mutex);
	run mutexMonitor(tr_nextProtoOnce_m);
	run RoundTrip109(tr_altMu,tr_connsPerHostMu,tr_idleMu,tr_nextProtoOnce_m,tr_reqMu,tr_TLSClientConfig_mutex,child_RoundTrip1091);
	child_RoundTrip1091?0;
	run RoundTrip109(tr_altMu,tr_connsPerHostMu,tr_idleMu,tr_nextProtoOnce_m,tr_reqMu,tr_TLSClientConfig_mutex,child_RoundTrip1092);
	child_RoundTrip1092?0;
		defer1: skip;
	run Close1837(ts_wg,ts_Config_mu,ts_mu,ts_TLS_mutex,child_Close18370);
	child_Close18370?0;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype Close1837(Wgdef b_wg;Mutexdef b_Config_mu;Mutexdef b_mu;Mutexdef b_TLS_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype RoundTrip109(Mutexdef t_altMu;Mutexdef t_connsPerHostMu;Mutexdef t_idleMu;Mutexdef t_nextProtoOnce_m;Mutexdef t_reqMu;Mutexdef t_TLSClientConfig_mutex;chan child) {
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

