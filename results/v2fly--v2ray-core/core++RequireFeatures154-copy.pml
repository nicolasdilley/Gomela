// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/v2fly/v2ray-core/blob//v2ray.go#L154
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_RequireFeatures1540 = [1] of {int};
	run RequireFeatures154(child_RequireFeatures1540);
	run receiver(child_RequireFeatures1540)
stop_process:skip
}

proctype RequireFeatures154(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RequireFeatures2670 = [1] of {int};
	Mutexdef v_access;
	run mutexMonitor(v_access);
	run RequireFeatures267(v_access,child_RequireFeatures2670);
	child_RequireFeatures2670?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype RequireFeatures267(Mutexdef s_access;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_callbackType_NumIn = -2; // opt var_callbackType_NumIn
	

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

proctype receiver(chan c) {
c?0
}

