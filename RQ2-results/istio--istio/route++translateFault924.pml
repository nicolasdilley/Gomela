
// https://github.com/istio/istio/blob/master/pilot/pkg/networking/core/v1alpha3/route/route.go#L924
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_translateFault9240 = [1] of {int};
	run translateFault924(child_translateFault9240)
stop_process:skip
}

proctype translateFault924(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef out_ResponseRateLimit_Percentage_state_atomicMessageInfo_initMu;
	Mutexdef out_ResponseRateLimit_state_atomicMessageInfo_initMu;
	Mutexdef out_MaxActiveFaults_state_atomicMessageInfo_initMu;
	Mutexdef out_Abort_Percentage_state_atomicMessageInfo_initMu;
	Mutexdef out_Abort_state_atomicMessageInfo_initMu;
	Mutexdef out_Delay_Percentage_state_atomicMessageInfo_initMu;
	Mutexdef out_Delay_state_atomicMessageInfo_initMu;
	Mutexdef out_state_atomicMessageInfo_initMu;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run mutexMonitor(out_state_atomicMessageInfo_initMu);
	run mutexMonitor(out_Delay_state_atomicMessageInfo_initMu);
	run mutexMonitor(out_Delay_Percentage_state_atomicMessageInfo_initMu);
	run mutexMonitor(out_Abort_state_atomicMessageInfo_initMu);
	run mutexMonitor(out_Abort_Percentage_state_atomicMessageInfo_initMu);
	run mutexMonitor(out_MaxActiveFaults_state_atomicMessageInfo_initMu);
	run mutexMonitor(out_ResponseRateLimit_state_atomicMessageInfo_initMu);
	run mutexMonitor(out_ResponseRateLimit_Percentage_state_atomicMessageInfo_initMu);
	

	if
	:: true -> 
		

		if
		:: true;
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true;
		:: true;
		fi
	:: true;
	fi;
	

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

