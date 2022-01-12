// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/json2/marshal_test.go#L26
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMarshalPB260 = [1] of {int};
	run TestMarshalPB26(child_TestMarshalPB260);
	run receiver(child_TestMarshalPB260)
stop_process:skip
}

proctype TestMarshalPB26(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_MarshalPB310 = [1] of {int};
	Mutexdef col_state_atomicMessageInfo_initMu;
	run mutexMonitor(col_state_atomicMessageInfo_initMu);
	run MarshalPB31(col_state_atomicMessageInfo_initMu,child_MarshalPB310);
	child_MarshalPB310?0;
	stop_process: skip;
	child!0
}
proctype MarshalPB31(Mutexdef pb_state_atomicMessageInfo_initMu;chan child) {
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

