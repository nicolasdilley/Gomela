
// https://github.com/kubernetes/kubernetes/blob/master/pkg/volume/portworx/portworx_util.go#L200
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ResizeVolume2000 = [1] of {int};
	run ResizeVolume200(child_ResizeVolume2000)
stop_process:skip
}

proctype ResizeVolume200(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef updatedVol_LastScan_state_atomicMessageInfo_initMu;
	Mutexdef updatedVol_Ctime_state_atomicMessageInfo_initMu;
	Mutexdef vol_LastScan_state_atomicMessageInfo_initMu;
	Mutexdef vol_Ctime_state_atomicMessageInfo_initMu;
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(vol_Ctime_state_atomicMessageInfo_initMu);
	run mutexMonitor(vol_LastScan_state_atomicMessageInfo_initMu);
	

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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(updatedVol_Ctime_state_atomicMessageInfo_initMu);
	run mutexMonitor(updatedVol_LastScan_state_atomicMessageInfo_initMu);
	

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

