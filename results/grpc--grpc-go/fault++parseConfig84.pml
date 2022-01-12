// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob//xds/internal/httpfilter/fault/fault.go#L84
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_parseConfig840 = [1] of {int};
	run parseConfig84(child_parseConfig840);
	run receiver(child_parseConfig840)
stop_process:skip
}

proctype parseConfig84(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef msg_ResponseRateLimit_state_atomicMessageInfo_initMu;
	Mutexdef msg_MaxActiveFaults_state_atomicMessageInfo_initMu;
	Mutexdef msg_Abort_state_atomicMessageInfo_initMu;
	Mutexdef msg_Delay_state_atomicMessageInfo_initMu;
	Mutexdef msg_state_atomicMessageInfo_initMu;
	Mutexdef any_state_atomicMessageInfo_initMu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(any_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(msg_state_atomicMessageInfo_initMu);
	run mutexMonitor(msg_Delay_state_atomicMessageInfo_initMu);
	run mutexMonitor(msg_Abort_state_atomicMessageInfo_initMu);
	run mutexMonitor(msg_MaxActiveFaults_state_atomicMessageInfo_initMu);
	run mutexMonitor(msg_ResponseRateLimit_state_atomicMessageInfo_initMu);
	

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

