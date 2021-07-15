
// https://github.com/hashicorp/packer/blob/master/builder/yandex/driver_yc.go#L37
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
	chan child_NewDriverYC370 = [1] of {int};
	run NewDriverYC37(child_NewDriverYC370)
stop_process:skip
}

proctype NewDriverYC37(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef sdk_muErr;
	Wgdef sdk_initCall_callState_wg;
	Mutexdef sdk_initCall_mu;
	Mutexdef sdk_endpoints_mu;
	Mutexdef sdk_conf_TLSConfig_mutex;
	Mutexdef key_CreatedAt_state_atomicMessageInfo_initMu;
	Mutexdef sdkConfig_TLSConfig_mutex;
	run mutexMonitor(sdkConfig_TLSConfig_mutex);
	

	if
	:: true;
	:: true;
	:: true -> 
		run mutexMonitor(key_CreatedAt_state_atomicMessageInfo_initMu);
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	run mutexMonitor(sdk_conf_TLSConfig_mutex);
	run mutexMonitor(sdk_endpoints_mu);
	run mutexMonitor(sdk_initCall_mu);
	run wgMonitor(sdk_initCall_callState_wg);
	run mutexMonitor(sdk_muErr);
	

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

