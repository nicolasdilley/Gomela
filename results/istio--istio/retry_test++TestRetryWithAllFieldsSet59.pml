// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob//pilot/pkg/networking/core/v1alpha3/route/retry/retry_test.go#L59
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRetryWithAllFieldsSet590 = [1] of {int};
	run TestRetryWithAllFieldsSet59(child_TestRetryWithAllFieldsSet590);
	run receiver(child_TestRetryWithAllFieldsSet590)
stop_process:skip
}

proctype TestRetryWithAllFieldsSet59(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef policy_RateLimitedRetryBackOff_state_atomicMessageInfo_initMu;
	Mutexdef policy_RetryBackOff_state_atomicMessageInfo_initMu;
	Mutexdef policy_RetryPriority_state_atomicMessageInfo_initMu;
	Mutexdef policy_PerTryTimeout_state_atomicMessageInfo_initMu;
	Mutexdef policy_NumRetries_state_atomicMessageInfo_initMu;
	Mutexdef policy_state_atomicMessageInfo_initMu;
	run mutexMonitor(policy_state_atomicMessageInfo_initMu);
	run mutexMonitor(policy_NumRetries_state_atomicMessageInfo_initMu);
	run mutexMonitor(policy_PerTryTimeout_state_atomicMessageInfo_initMu);
	run mutexMonitor(policy_RetryPriority_state_atomicMessageInfo_initMu);
	run mutexMonitor(policy_RetryBackOff_state_atomicMessageInfo_initMu);
	run mutexMonitor(policy_RateLimitedRetryBackOff_state_atomicMessageInfo_initMu);
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

