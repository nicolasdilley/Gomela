// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/endorser/metrics_test.go#L16
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNewMetrics160 = [1] of {int};
	run TestNewMetrics16(child_TestNewMetrics160);
	run receiver(child_TestNewMetrics160)
stop_process:skip
}

proctype TestNewMetrics16(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewMetrics912 = [1] of {int};
	chan child_NewCounterReturns851 = [1] of {int};
	chan child_NewHistogramReturns2050 = [1] of {int};
	Mutexdef provider_invocationsMutex;
	Mutexdef provider_newHistogramMutex;
	Mutexdef provider_newGaugeMutex;
	Mutexdef provider_newCounterMutex;
	run mutexMonitor(provider_newCounterMutex);
	run mutexMonitor(provider_newGaugeMutex);
	run mutexMonitor(provider_newHistogramMutex);
	run mutexMonitor(provider_invocationsMutex);
	run NewHistogramReturns205(provider_invocationsMutex,provider_newCounterMutex,provider_newGaugeMutex,provider_newHistogramMutex,child_NewHistogramReturns2050);
	child_NewHistogramReturns2050?0;
	run NewCounterReturns85(provider_invocationsMutex,provider_newCounterMutex,provider_newGaugeMutex,provider_newHistogramMutex,child_NewCounterReturns851);
	child_NewCounterReturns851?0;
	run NewMetrics91(provider_invocationsMutex,provider_newCounterMutex,provider_newGaugeMutex,provider_newHistogramMutex,child_NewMetrics912);
	child_NewMetrics912?0;
	stop_process: skip;
	child!0
}
proctype NewHistogramReturns205(Mutexdef fake_invocationsMutex;Mutexdef fake_newCounterMutex;Mutexdef fake_newGaugeMutex;Mutexdef fake_newHistogramMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	fake_newHistogramMutex.Lock!false;
		defer1: skip;
	fake_newHistogramMutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype NewCounterReturns85(Mutexdef fake_invocationsMutex;Mutexdef fake_newCounterMutex;Mutexdef fake_newGaugeMutex;Mutexdef fake_newHistogramMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	fake_newCounterMutex.Lock!false;
		defer1: skip;
	fake_newCounterMutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype NewMetrics91(Mutexdef p_invocationsMutex;Mutexdef p_newCounterMutex;Mutexdef p_newGaugeMutex;Mutexdef p_newHistogramMutex;chan child) {
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

