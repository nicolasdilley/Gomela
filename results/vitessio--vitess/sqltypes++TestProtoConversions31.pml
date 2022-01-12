// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/sqltypes/bind_variables_test.go#L31
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestProtoConversions310 = [1] of {int};
	run TestProtoConversions31(child_TestProtoConversions310);
	run receiver(child_TestProtoConversions310)
stop_process:skip
}

proctype TestProtoConversions31(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_ProtoToValue470 = [1] of {int};
	Mutexdef want_state_atomicMessageInfo_initMu;
	Mutexdef got_state_atomicMessageInfo_initMu;
	run mutexMonitor(got_state_atomicMessageInfo_initMu);
	run mutexMonitor(want_state_atomicMessageInfo_initMu);
	run ProtoToValue47(got_state_atomicMessageInfo_initMu,child_ProtoToValue470);
	child_ProtoToValue470?0;
	stop_process: skip;
	child!0
}
proctype ProtoToValue47(Mutexdef v_state_atomicMessageInfo_initMu;chan child) {
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

