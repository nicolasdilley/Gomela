
// https://github.com/hashicorp/consul/blob/master/command/flags/http.go#L131
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_APIClient1310 = [1] of {int};
	run APIClient131(child_APIClient1310)
stop_process:skip
}

proctype APIClient131(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MergeOntoConfig1390 = [1] of {int};
	Mutexdef c_Transport_nextProtoOnce_m;
	Mutexdef c_Transport_TLSClientConfig_mutex;
	Mutexdef c_Transport_connsPerHostMu;
	Mutexdef c_Transport_altMu;
	Mutexdef c_Transport_reqMu;
	Mutexdef c_Transport_idleMu;
	run mutexMonitor(c_Transport_idleMu);
	run mutexMonitor(c_Transport_reqMu);
	run mutexMonitor(c_Transport_altMu);
	run mutexMonitor(c_Transport_connsPerHostMu);
	run mutexMonitor(c_Transport_TLSClientConfig_mutex);
	run mutexMonitor(c_Transport_nextProtoOnce_m);
	run MergeOntoConfig139(c_Transport_idleMu,c_Transport_reqMu,c_Transport_altMu,c_Transport_connsPerHostMu,c_Transport_TLSClientConfig_mutex,c_Transport_nextProtoOnce_m,child_MergeOntoConfig1390);
	child_MergeOntoConfig1390?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype MergeOntoConfig139(Mutexdef c_Transport_idleMu;Mutexdef c_Transport_reqMu;Mutexdef c_Transport_altMu;Mutexdef c_Transport_connsPerHostMu;Mutexdef c_Transport_TLSClientConfig_mutex;Mutexdef c_Transport_nextProtoOnce_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

