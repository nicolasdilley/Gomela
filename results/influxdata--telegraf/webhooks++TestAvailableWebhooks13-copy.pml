// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/webhooks/webhooks_test.go#L13
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAvailableWebhooks130 = [1] of {int};
	run TestAvailableWebhooks13(child_TestAvailableWebhooks130);
	run receiver(child_TestAvailableWebhooks130)
stop_process:skip
}

proctype TestAvailableWebhooks13(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AvailableWebhooks839 = [1] of {int};
	chan child_AvailableWebhooks838 = [1] of {int};
	chan child_AvailableWebhooks837 = [1] of {int};
	chan child_AvailableWebhooks836 = [1] of {int};
	chan child_AvailableWebhooks835 = [1] of {int};
	chan child_AvailableWebhooks834 = [1] of {int};
	chan child_AvailableWebhooks833 = [1] of {int};
	chan child_AvailableWebhooks832 = [1] of {int};
	chan child_AvailableWebhooks831 = [1] of {int};
	chan child_AvailableWebhooks830 = [1] of {int};
	Mutexdef wb_srv_mu;
	Mutexdef wb_srv_nextProtoOnce_m;
	Mutexdef wb_srv_ErrorLog_mu;
	Mutexdef wb_srv_TLSConfig_mutex;
	run mutexMonitor(wb_srv_TLSConfig_mutex);
	run mutexMonitor(wb_srv_ErrorLog_mu);
	run mutexMonitor(wb_srv_nextProtoOnce_m);
	run mutexMonitor(wb_srv_mu);
	run AvailableWebhooks83(wb_srv_ErrorLog_mu,wb_srv_mu,wb_srv_nextProtoOnce_m,wb_srv_TLSConfig_mutex,child_AvailableWebhooks830);
	child_AvailableWebhooks830?0;
	

	if
	:: true -> 
		run AvailableWebhooks83(wb_srv_ErrorLog_mu,wb_srv_mu,wb_srv_nextProtoOnce_m,wb_srv_TLSConfig_mutex,child_AvailableWebhooks831);
		child_AvailableWebhooks831?0
	:: true;
	fi;
	run AvailableWebhooks83(wb_srv_ErrorLog_mu,wb_srv_mu,wb_srv_nextProtoOnce_m,wb_srv_TLSConfig_mutex,child_AvailableWebhooks832);
	child_AvailableWebhooks832?0;
	

	if
	:: true -> 
		run AvailableWebhooks83(wb_srv_ErrorLog_mu,wb_srv_mu,wb_srv_nextProtoOnce_m,wb_srv_TLSConfig_mutex,child_AvailableWebhooks833);
		child_AvailableWebhooks833?0
	:: true;
	fi;
	run AvailableWebhooks83(wb_srv_ErrorLog_mu,wb_srv_mu,wb_srv_nextProtoOnce_m,wb_srv_TLSConfig_mutex,child_AvailableWebhooks834);
	child_AvailableWebhooks834?0;
	

	if
	:: true -> 
		run AvailableWebhooks83(wb_srv_ErrorLog_mu,wb_srv_mu,wb_srv_nextProtoOnce_m,wb_srv_TLSConfig_mutex,child_AvailableWebhooks835);
		child_AvailableWebhooks835?0
	:: true;
	fi;
	run AvailableWebhooks83(wb_srv_ErrorLog_mu,wb_srv_mu,wb_srv_nextProtoOnce_m,wb_srv_TLSConfig_mutex,child_AvailableWebhooks836);
	child_AvailableWebhooks836?0;
	

	if
	:: true -> 
		run AvailableWebhooks83(wb_srv_ErrorLog_mu,wb_srv_mu,wb_srv_nextProtoOnce_m,wb_srv_TLSConfig_mutex,child_AvailableWebhooks837);
		child_AvailableWebhooks837?0
	:: true;
	fi;
	run AvailableWebhooks83(wb_srv_ErrorLog_mu,wb_srv_mu,wb_srv_nextProtoOnce_m,wb_srv_TLSConfig_mutex,child_AvailableWebhooks838);
	child_AvailableWebhooks838?0;
	

	if
	:: true -> 
		run AvailableWebhooks83(wb_srv_ErrorLog_mu,wb_srv_mu,wb_srv_nextProtoOnce_m,wb_srv_TLSConfig_mutex,child_AvailableWebhooks839);
		child_AvailableWebhooks839?0
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype AvailableWebhooks83(Mutexdef wb_srv_ErrorLog_mu;Mutexdef wb_srv_mu;Mutexdef wb_srv_nextProtoOnce_m;Mutexdef wb_srv_TLSConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_s_NumField = -2; // opt var_s_NumField
	goto stop_process;
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

