
// https://github.com/grpc/grpc-go/blob/master/xds/internal/httpfilter/fault/fault.go#L109
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_BuildClientInterceptor1090 = [1] of {int};
	run BuildClientInterceptor109(child_BuildClientInterceptor1090)
stop_process:skip
}

proctype BuildClientInterceptor109(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef c_config_ResponseRateLimit_Percentage_state_atomicMessageInfo_initMu;
	Mutexdef c_config_ResponseRateLimit_state_atomicMessageInfo_initMu;
	Mutexdef c_config_MaxActiveFaults_state_atomicMessageInfo_initMu;
	Mutexdef c_config_Abort_Percentage_state_atomicMessageInfo_initMu;
	Mutexdef c_config_Abort_state_atomicMessageInfo_initMu;
	Mutexdef c_config_Delay_Percentage_state_atomicMessageInfo_initMu;
	Mutexdef c_config_Delay_state_atomicMessageInfo_initMu;
	Mutexdef c_config_state_atomicMessageInfo_initMu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(c_config_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_config_Delay_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_config_Delay_Percentage_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_config_Abort_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_config_Abort_Percentage_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_config_MaxActiveFaults_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_config_ResponseRateLimit_state_atomicMessageInfo_initMu);
	run mutexMonitor(c_config_ResponseRateLimit_Percentage_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

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

