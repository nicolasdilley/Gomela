// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/v2fly/v2ray-core/blob//common/net/port_test.go#L9
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestPortRangeContains90 = [1] of {int};
	run TestPortRangeContains9(child_TestPortRangeContains90);
	run receiver(child_TestPortRangeContains90)
stop_process:skip
}

proctype TestPortRangeContains9(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Contains570 = [1] of {int};
	Mutexdef portRange_state_atomicMessageInfo_initMu;
	run mutexMonitor(portRange_state_atomicMessageInfo_initMu);
	run Contains57(portRange_state_atomicMessageInfo_initMu,child_Contains570);
	child_Contains570?0;
	stop_process: skip;
	child!0
}
proctype Contains57(Mutexdef p_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ToPort521 = [1] of {int};
	chan child_FromPort470 = [1] of {int};
	run FromPort47(p_state_atomicMessageInfo_initMu,child_FromPort470);
	child_FromPort470?0;
	run ToPort52(p_state_atomicMessageInfo_initMu,child_ToPort521);
	child_ToPort521?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype FromPort47(Mutexdef p_state_atomicMessageInfo_initMu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype ToPort52(Mutexdef p_state_atomicMessageInfo_initMu;chan child) {
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

proctype receiver(chan c) {
c?0
}

