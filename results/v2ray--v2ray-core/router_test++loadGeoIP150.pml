// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/v2ray/v2ray-core/blob//app/router/condition_geoip_test.go#L150
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_loadGeoIP1500 = [1] of {int};
	run loadGeoIP150(child_loadGeoIP1500);
	run receiver(child_loadGeoIP1500)
stop_process:skip
}

proctype loadGeoIP150(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef geoipList_state_atomicMessageInfo_initMu;
	int var_geoipList_Entry = -2; // opt var_geoipList_Entry
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(geoipList_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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
