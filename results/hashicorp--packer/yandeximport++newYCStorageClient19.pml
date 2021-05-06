
// https://github.com/hashicorp/packer/blob/master/post-processor/yandex-import/storage.go#L19
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_newYCStorageClient190 = [1] of {int};
	run newYCStorageClient19(child_newYCStorageClient190)
stop_process:skip
}

proctype newYCStorageClient19(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef newSession_options_Config_Credentials_m;
	Mutexdef newSession_options_Config_Credentials_sf_mu;
	Mutexdef newSession_Config_Credentials_m;
	Mutexdef newSession_Config_Credentials_sf_mu;
	Mutexdef s3Config_Credentials_m;
	Mutexdef s3Config_Credentials_sf_mu;
	Mutexdef creds_m;
	Mutexdef creds_sf_mu;
	run mutexMonitor(creds_sf_mu);
	run mutexMonitor(creds_m);
	run mutexMonitor(s3Config_Credentials_sf_mu);
	run mutexMonitor(s3Config_Credentials_m);
	

	if
	:: true;
	:: true -> 
		goto stop_process
	fi;
	run mutexMonitor(newSession_Config_Credentials_sf_mu);
	run mutexMonitor(newSession_Config_Credentials_m);
	run mutexMonitor(newSession_options_Config_Credentials_sf_mu);
	run mutexMonitor(newSession_options_Config_Credentials_m);
	

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

