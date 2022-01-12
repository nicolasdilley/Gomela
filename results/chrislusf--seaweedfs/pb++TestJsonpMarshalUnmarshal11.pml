// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/chrislusf/seaweedfs/blob//weed/pb/proto_read_write_test.go#L11
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestJsonpMarshalUnmarshal110 = [1] of {int};
	run TestJsonpMarshalUnmarshal11(child_TestJsonpMarshalUnmarshal110);
	run receiver(child_TestJsonpMarshalUnmarshal110)
stop_process:skip
}

proctype TestJsonpMarshalUnmarshal11(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef tv1_state_atomicMessageInfo_initMu;
	Mutexdef tv_state_atomicMessageInfo_initMu;
	run mutexMonitor(tv_state_atomicMessageInfo_initMu);
	run mutexMonitor(tv1_state_atomicMessageInfo_initMu);
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

