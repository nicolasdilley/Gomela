
// https://github.com/grpc/grpc-go/blob/master/xds/internal/client/bootstrap/bootstrap.go#L289
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_updateNodeProto2890 = [1] of {int};
	run updateNodeProto289(child_updateNodeProto2890)
stop_process:skip
}

proctype updateNodeProto289(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Unmarshal480 = [1] of {int};
	Mutexdef v2_Locality_state_atomicMessageInfo_initMu;
	Mutexdef v2_Metadata_state_atomicMessageInfo_initMu;
	Mutexdef v2_state_atomicMessageInfo_initMu;
	Mutexdef v3_Locality_state_atomicMessageInfo_initMu;
	Mutexdef v3_Metadata_state_atomicMessageInfo_initMu;
	Mutexdef v3_state_atomicMessageInfo_initMu;
	

	if
	:: true -> 
		run mutexMonitor(v3_state_atomicMessageInfo_initMu);
		run mutexMonitor(v3_Metadata_state_atomicMessageInfo_initMu);
		run mutexMonitor(v3_Locality_state_atomicMessageInfo_initMu);
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(v2_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2_Metadata_state_atomicMessageInfo_initMu);
	run mutexMonitor(v2_Locality_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run Unmarshal48(v3_state_atomicMessageInfo_initMu,v3_Metadata_state_atomicMessageInfo_initMu,v3_Locality_state_atomicMessageInfo_initMu,child_Unmarshal480);
		child_Unmarshal480?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Unmarshal48(Mutexdef v_state_atomicMessageInfo_initMu;Mutexdef v_Metadata_state_atomicMessageInfo_initMu;Mutexdef v_Locality_state_atomicMessageInfo_initMu;chan child) {
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

