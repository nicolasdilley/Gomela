// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc-ecosystem/grpc-gateway/blob//examples/internal/integration/integration_test.go#L91
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEchoPatch910 = [1] of {int};
	run TestEchoPatch91(child_TestEchoPatch910);
	run receiver(child_TestEchoPatch910)
stop_process:skip
}

proctype TestEchoPatch91(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef received_UpdateMask_state_atomicMessageInfo_initMu;
	Mutexdef received_Body_state_atomicMessageInfo_initMu;
	Mutexdef received_state_atomicMessageInfo_initMu;
	Mutexdef sent_ValueField_state_atomicMessageInfo_initMu;
	Mutexdef sent_StructField_state_atomicMessageInfo_initMu;
	Mutexdef sent_state_atomicMessageInfo_initMu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(sent_state_atomicMessageInfo_initMu);
	run mutexMonitor(sent_StructField_state_atomicMessageInfo_initMu);
	run mutexMonitor(sent_ValueField_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(received_state_atomicMessageInfo_initMu);
	run mutexMonitor(received_Body_state_atomicMessageInfo_initMu);
	run mutexMonitor(received_UpdateMask_state_atomicMessageInfo_initMu);
	

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

