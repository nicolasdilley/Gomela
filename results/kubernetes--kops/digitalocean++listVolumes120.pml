
// https://github.com/kubernetes/kops/blob/master/pkg/resources/digitalocean/resources.go#L120
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_listVolumes1200 = [1] of {int};
	run listVolumes120(child_listVolumes1200)
stop_process:skip
}

proctype listVolumes120(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_getAllVolumesByRegion1540 = [1] of {int};
	Mutexdef c_Client_ratemtx;
	run mutexMonitor(c_Client_ratemtx);
	run getAllVolumesByRegion154(c_Client_ratemtx,child_getAllVolumesByRegion1540);
	child_getAllVolumesByRegion1540?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype getAllVolumesByRegion154(Mutexdef cloud_Client_ratemtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

