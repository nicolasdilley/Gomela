
// https://github.com/mattermost/mattermost-server/blob/master/services/awsmeter/awsmeter.go#L68
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newAWSMarketplaceMeteringService680 = [1] of {int};
	run newAWSMarketplaceMeteringService68(child_newAWSMarketplaceMeteringService680)
stop_process:skip
}

proctype newAWSMarketplaceMeteringService68(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef creds_m;
	Mutexdef creds_sf_mu;
	Mutexdef s_options_Config_Credentials_m;
	Mutexdef s_options_Config_Credentials_sf_mu;
	Mutexdef s_Config_Credentials_m;
	Mutexdef s_Config_Credentials_sf_mu;
	run mutexMonitor(s_Config_Credentials_sf_mu);
	run mutexMonitor(s_Config_Credentials_m);
	run mutexMonitor(s_options_Config_Credentials_sf_mu);
	run mutexMonitor(s_options_Config_Credentials_m);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(creds_sf_mu);
	run mutexMonitor(creds_m);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

