
// https://github.com/kubernetes/kops/blob/master/util/pkg/vfs/s3context.go#L345
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_getRegionFromMetadata3450 = [1] of {int};
	run getRegionFromMetadata345(child_getRegionFromMetadata3450)
stop_process:skip
}

proctype getRegionFromMetadata345(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef metadataSession_options_Config_Credentials_m;
	Mutexdef metadataSession_options_Config_Credentials_sf_mu;
	Mutexdef metadataSession_Config_Credentials_m;
	Mutexdef metadataSession_Config_Credentials_sf_mu;
	Mutexdef shortTimeout_Credentials_m;
	Mutexdef shortTimeout_Credentials_sf_mu;
	run mutexMonitor(shortTimeout_Credentials_sf_mu);
	run mutexMonitor(shortTimeout_Credentials_m);
	run mutexMonitor(metadataSession_Config_Credentials_sf_mu);
	run mutexMonitor(metadataSession_Config_Credentials_m);
	run mutexMonitor(metadataSession_options_Config_Credentials_sf_mu);
	run mutexMonitor(metadataSession_options_Config_Credentials_m);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

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

