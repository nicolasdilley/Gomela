
// https://github.com/grpc/grpc-go/blob/master/stress/grpc_testing/metrics_grpc.pb.go#L112
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child__MetricsService_GetAllGauges_Handler1120 = [1] of {int};
	run _MetricsService_GetAllGauges_Handler112(child__MetricsService_GetAllGauges_Handler1120)
stop_process:skip
}

proctype _MetricsService_GetAllGauges_Handler112(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef m_state_atomicMessageInfo_initMu;
	run mutexMonitor(m_state_atomicMessageInfo_initMu);
	

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

