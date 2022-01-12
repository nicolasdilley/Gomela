// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/protoutil/time_test.go#L29
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTimeFromProto290 = [1] of {int};
	run TestTimeFromProto29(child_TestTimeFromProto290);
	run receiver(child_TestTimeFromProto290)
stop_process:skip
}

proctype TestTimeFromProto29(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_TimeFromProto262 = [1] of {int};
	chan child_TimeFromProto261 = [1] of {int};
	chan child_TimeFromProto260 = [1] of {int};
	Mutexdef vtt_state_atomicMessageInfo_initMu;
	run mutexMonitor(vtt_state_atomicMessageInfo_initMu);
	run TimeFromProto26(vtt_state_atomicMessageInfo_initMu,child_TimeFromProto260);
	child_TimeFromProto260?0;
	run TimeFromProto26(vtt_state_atomicMessageInfo_initMu,child_TimeFromProto261);
	child_TimeFromProto261?0;
	run TimeFromProto26(vtt_state_atomicMessageInfo_initMu,child_TimeFromProto262);
	child_TimeFromProto262?0;
	stop_process: skip;
	child!0
}
proctype TimeFromProto26(Mutexdef tpb_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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

