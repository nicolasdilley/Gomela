// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//gossip/metrics/metrics_test.go#L16
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMetrics160 = [1] of {int};
	run TestMetrics16(child_TestMetrics160);
	run receiver(child_TestMetrics160)
stop_process:skip
}

proctype TestMetrics16(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_NewGossipMetrics203 = [1] of {int};
	chan child_NewHistogramReturns2052 = [1] of {int};
	chan child_NewGaugeReturns1451 = [1] of {int};
	chan child_NewCounterReturns850 = [1] of {int};
	Mutexdef histogram_invocationsMutex;
	Mutexdef histogram_withMutex;
	Mutexdef histogram_observeMutex;
	Mutexdef gauge_invocationsMutex;
	Mutexdef gauge_withMutex;
	Mutexdef gauge_setMutex;
	Mutexdef gauge_addMutex;
	Mutexdef counter_invocationsMutex;
	Mutexdef counter_withMutex;
	Mutexdef counter_addMutex;
	Mutexdef provider_invocationsMutex;
	Mutexdef provider_newHistogramMutex;
	Mutexdef provider_newGaugeMutex;
	Mutexdef provider_newCounterMutex;
	run mutexMonitor(provider_newCounterMutex);
	run mutexMonitor(provider_newGaugeMutex);
	run mutexMonitor(provider_newHistogramMutex);
	run mutexMonitor(provider_invocationsMutex);
	run mutexMonitor(counter_addMutex);
	run mutexMonitor(counter_withMutex);
	run mutexMonitor(counter_invocationsMutex);
	run mutexMonitor(gauge_addMutex);
	run mutexMonitor(gauge_setMutex);
	run mutexMonitor(gauge_withMutex);
	run mutexMonitor(gauge_invocationsMutex);
	run mutexMonitor(histogram_observeMutex);
	run mutexMonitor(histogram_withMutex);
	run mutexMonitor(histogram_invocationsMutex);
	run NewCounterReturns85(provider_invocationsMutex,provider_newCounterMutex,provider_newGaugeMutex,provider_newHistogramMutex,counter_addMutex,counter_invocationsMutex,counter_withMutex,child_NewCounterReturns850);
	child_NewCounterReturns850?0;
	run NewGaugeReturns145(provider_invocationsMutex,provider_newCounterMutex,provider_newGaugeMutex,provider_newHistogramMutex,gauge_addMutex,gauge_invocationsMutex,gauge_setMutex,gauge_withMutex,child_NewGaugeReturns1451);
	child_NewGaugeReturns1451?0;
	run NewHistogramReturns205(provider_invocationsMutex,provider_newCounterMutex,provider_newGaugeMutex,provider_newHistogramMutex,histogram_invocationsMutex,histogram_observeMutex,histogram_withMutex,child_NewHistogramReturns2052);
	child_NewHistogramReturns2052?0;
	run NewGossipMetrics20(provider_invocationsMutex,provider_newCounterMutex,provider_newGaugeMutex,provider_newHistogramMutex,child_NewGossipMetrics203);
	child_NewGossipMetrics203?0;
	stop_process: skip;
	child!0
}
proctype NewCounterReturns85(Mutexdef fake_invocationsMutex;Mutexdef fake_newCounterMutex;Mutexdef fake_newGaugeMutex;Mutexdef fake_newHistogramMutex;Mutexdef result1_addMutex;Mutexdef result1_invocationsMutex;Mutexdef result1_withMutex;chan child) {
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
proctype NewGaugeReturns145(Mutexdef fake_invocationsMutex;Mutexdef fake_newCounterMutex;Mutexdef fake_newGaugeMutex;Mutexdef fake_newHistogramMutex;Mutexdef result1_addMutex;Mutexdef result1_invocationsMutex;Mutexdef result1_setMutex;Mutexdef result1_withMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	fake_newGaugeMutex.Lock!false;
		defer1: skip;
	fake_newGaugeMutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype NewHistogramReturns205(Mutexdef fake_invocationsMutex;Mutexdef fake_newCounterMutex;Mutexdef fake_newGaugeMutex;Mutexdef fake_newHistogramMutex;Mutexdef result1_invocationsMutex;Mutexdef result1_observeMutex;Mutexdef result1_withMutex;chan child) {
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
proctype NewGossipMetrics20(Mutexdef p_invocationsMutex;Mutexdef p_newCounterMutex;Mutexdef p_newGaugeMutex;Mutexdef p_newHistogramMutex;chan child) {
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

