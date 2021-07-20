// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/util/profile/profile.go#L38
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_ProfileReaderToDatums380 = [1] of {int};
	run ProfileReaderToDatums38(child_ProfileReaderToDatums380);
	run receiver(child_ProfileReaderToDatums380)
stop_process:skip
}

proctype ProfileReaderToDatums38(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_profileToDatums590 = [1] of {int};
	Mutexdef p_encodeMu;
	run mutexMonitor(p_encodeMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run profileToDatums59(p_encodeMu,child_profileToDatums590);
	child_profileToDatums590?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype profileToDatums59(Mutexdef p_encodeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newFlamegraphCollector1281 = [1] of {int};
	chan child_profileToFlamegraphNode460 = [1] of {int};
	run profileToFlamegraphNode46(p_encodeMu,child_profileToFlamegraphNode460);
	child_profileToFlamegraphNode460?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run newFlamegraphCollector128(p_encodeMu,child_newFlamegraphCollector1281);
	child_newFlamegraphCollector1281?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype profileToFlamegraphNode46(Mutexdef p_encodeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_p_Samplep_Sample = -2; // opt var_p_Samplep_Sample
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newFlamegraphCollector128(Mutexdef p_encodeMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_p_Locationp_Location = -2; // opt var_p_Locationp_Location
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

