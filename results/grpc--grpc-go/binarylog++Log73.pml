
// https://github.com/grpc/grpc-go/blob/master/internal/binarylog/method_logger.go#L73
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Log730 = [1] of {int};
	run Log73(child_Log730)
stop_process:skip
}

proctype Log73(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef timestamp_state_atomicMessageInfo_initMu;
	Mutexdef m_Peer_state_atomicMessageInfo_initMu;
	Mutexdef m_Timestamp_state_atomicMessageInfo_initMu;
	Mutexdef m_state_atomicMessageInfo_initMu;
	run mutexMonitor(m_state_atomicMessageInfo_initMu);
	run mutexMonitor(m_Timestamp_state_atomicMessageInfo_initMu);
	run mutexMonitor(m_Peer_state_atomicMessageInfo_initMu);
	run mutexMonitor(timestamp_state_atomicMessageInfo_initMu);
	

	if
	:: true;
	:: true;
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

