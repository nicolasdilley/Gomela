#define policyARNs229  -2

// https://github.com/hashicorp/vault/blob/master/builtin/logical/aws/backend_test.go#L229
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_createRole2290 = [1] of {int};
	run createRole229(policyARNs229,child_createRole2290)
stop_process:skip
}

proctype createRole229(int policyARNs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef sess_options_Config_Credentials_m;
	Mutexdef sess_options_Config_Credentials_sf_mu;
	Mutexdef sess_Config_Credentials_m;
	Mutexdef sess_Config_Credentials_sf_mu;
	Mutexdef awsConfig_Credentials_m;
	Mutexdef awsConfig_Credentials_sf_mu;
	run mutexMonitor(awsConfig_Credentials_sf_mu);
	run mutexMonitor(awsConfig_Credentials_m);
	run mutexMonitor(sess_Config_Credentials_sf_mu);
	run mutexMonitor(sess_Config_Credentials_m);
	run mutexMonitor(sess_options_Config_Credentials_sf_mu);
	run mutexMonitor(sess_options_Config_Credentials_m);
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

