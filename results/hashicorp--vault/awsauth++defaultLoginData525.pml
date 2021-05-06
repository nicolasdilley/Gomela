
// https://github.com/hashicorp/vault/blob/master/builtin/credential/aws/path_login_test.go#L525
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_defaultLoginData5250 = [1] of {int};
	run defaultLoginData525(child_defaultLoginData5250)
stop_process:skip
}

proctype defaultLoginData525(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef stsRequestValid_safeBody_lock;
	Mutexdef stsRequestValid_Config_Credentials_m;
	Mutexdef stsRequestValid_Config_Credentials_sf_mu;
	Mutexdef awsSession_options_Config_Credentials_m;
	Mutexdef awsSession_options_Config_Credentials_sf_mu;
	Mutexdef awsSession_Config_Credentials_m;
	Mutexdef awsSession_Config_Credentials_sf_mu;
	run mutexMonitor(awsSession_Config_Credentials_sf_mu);
	run mutexMonitor(awsSession_Config_Credentials_m);
	run mutexMonitor(awsSession_options_Config_Credentials_sf_mu);
	run mutexMonitor(awsSession_options_Config_Credentials_m);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(stsRequestValid_Config_Credentials_sf_mu);
	run mutexMonitor(stsRequestValid_Config_Credentials_m);
	run mutexMonitor(stsRequestValid_safeBody_lock);
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

