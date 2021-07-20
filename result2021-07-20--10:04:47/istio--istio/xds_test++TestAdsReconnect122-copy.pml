// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pilot/pkg/xds/ads_test.go#L122
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAdsReconnect1220 = [1] of {int};
	run TestAdsReconnect122(child_TestAdsReconnect1220);
	run receiver(child_TestAdsReconnect1220)
stop_process:skip
}

proctype TestAdsReconnect122(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AdsPushAll8340 = [1] of {int};
	Mutexdef ads2_cancelOnce_m;
	Mutexdef ads2_conn_lceMu;
	Mutexdef ads2_conn_mu;
	Mutexdef ads_cancelOnce_m;
	Mutexdef ads_conn_lceMu;
	Mutexdef ads_conn_mu;
	Mutexdef s_Listener_mu;
	Mutexdef s_Discovery_adsClientsMutex;
	Mutexdef s_Discovery_updateMutex;
	Mutexdef s_Discovery_mutex;
	run mutexMonitor(s_Discovery_mutex);
	run mutexMonitor(s_Discovery_updateMutex);
	run mutexMonitor(s_Discovery_adsClientsMutex);
	run mutexMonitor(s_Listener_mu);
	run mutexMonitor(ads_conn_mu);
	run mutexMonitor(ads_conn_lceMu);
	run mutexMonitor(ads_cancelOnce_m);
	run mutexMonitor(ads2_conn_mu);
	run mutexMonitor(ads2_conn_lceMu);
	run mutexMonitor(ads2_cancelOnce_m);
	run AdsPushAll834(s_Discovery_adsClientsMutex,s_Discovery_mutex,s_Discovery_updateMutex,child_AdsPushAll8340);
	child_AdsPushAll8340?0;
	stop_process: skip;
	child!0
}
proctype AdsPushAll834(Mutexdef s_adsClientsMutex;Mutexdef s_mutex;Mutexdef s_updateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AdsPushAll8450 = [1] of {int};
	run AdsPushAll845(s_adsClientsMutex,s_mutex,s_updateMutex,child_AdsPushAll8450);
	child_AdsPushAll8450?0;
	stop_process: skip;
	child!0
}
proctype AdsPushAll845(Mutexdef s_adsClientsMutex;Mutexdef s_mutex;Mutexdef s_updateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_startPush8722 = [1] of {int};
	chan child_adsClientCount7980 = [1] of {int};
	chan child_adsClientCount7981 = [1] of {int};
	

	if
	:: true -> 
		run adsClientCount798(s_adsClientsMutex,s_mutex,s_updateMutex,child_adsClientCount7980);
		child_adsClientCount7980?0
	:: true -> 
		run adsClientCount798(s_adsClientsMutex,s_mutex,s_updateMutex,child_adsClientCount7981);
		child_adsClientCount7981?0
	fi;
	run startPush872(s_adsClientsMutex,s_mutex,s_updateMutex,child_startPush8722);
	child_startPush8722?0;
	stop_process: skip;
	child!0
}
proctype adsClientCount798(Mutexdef s_adsClientsMutex;Mutexdef s_mutex;Mutexdef s_updateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_adsClientsMutex.RLock!false;
	goto defer1;
		defer1: skip;
	s_adsClientsMutex.RUnlock!false;
	stop_process: skip;
	child!0
}
proctype startPush872(Mutexdef s_adsClientsMutex;Mutexdef s_mutex;Mutexdef s_updateMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_s_AllClients__s_AllClients__ = -2; // opt var_s_AllClients__s_AllClients__
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

proctype receiver(chan c) {
c?0
}

