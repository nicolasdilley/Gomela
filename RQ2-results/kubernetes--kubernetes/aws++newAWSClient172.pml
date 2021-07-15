
// https://github.com/kubernetes/kubernetes/blob/master/test/e2e/framework/providers/aws/aws.go#L172
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newAWSClient1720 = [1] of {int};
	run newAWSClient172(child_newAWSClient1720)
stop_process:skip
}

proctype newAWSClient172(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef session_options_Config_Credentials_m;
	Mutexdef session_options_Config_Credentials_sf_mu;
	Mutexdef session_Config_Credentials_m;
	Mutexdef session_Config_Credentials_sf_mu;
	Mutexdef cfg_Credentials_m;
	Mutexdef cfg_Credentials_sf_mu;
	run mutexMonitor(cfg_Credentials_sf_mu);
	run mutexMonitor(cfg_Credentials_m);
	run mutexMonitor(session_Config_Credentials_sf_mu);
	run mutexMonitor(session_Config_Credentials_m);
	run mutexMonitor(session_options_Config_Credentials_sf_mu);
	run mutexMonitor(session_options_Config_Credentials_m);
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

