// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//orderer/common/cluster/service_test.go#L190
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestIngresStreamsMetrics1900 = [1] of {int};
	run TestIngresStreamsMetrics190(child_TestIngresStreamsMetrics1900);
	run receiver(child_TestIngresStreamsMetrics1900)
stop_process:skip
}

proctype TestIngresStreamsMetrics190(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SetArgsForCall912 = [1] of {int};
	chan child_SetArgsForCall911 = [1] of {int};
	chan child_initialize11710 = [1] of {int};
	Mutexdef testMetrics_msgDropCount_invocationsMutex;
	Mutexdef testMetrics_msgDropCount_withMutex;
	Mutexdef testMetrics_msgDropCount_addMutex;
	Mutexdef testMetrics_msgSendTime_invocationsMutex;
	Mutexdef testMetrics_msgSendTime_withMutex;
	Mutexdef testMetrics_msgSendTime_observeMutex;
	Mutexdef testMetrics_ingressStreamsCount_invocationsMutex;
	Mutexdef testMetrics_ingressStreamsCount_withMutex;
	Mutexdef testMetrics_ingressStreamsCount_setMutex;
	Mutexdef testMetrics_ingressStreamsCount_addMutex;
	Mutexdef testMetrics_egressWorkerSize_invocationsMutex;
	Mutexdef testMetrics_egressWorkerSize_withMutex;
	Mutexdef testMetrics_egressWorkerSize_setMutex;
	Mutexdef testMetrics_egressWorkerSize_addMutex;
	Mutexdef testMetrics_egressTLSConnCount_invocationsMutex;
	Mutexdef testMetrics_egressTLSConnCount_withMutex;
	Mutexdef testMetrics_egressTLSConnCount_setMutex;
	Mutexdef testMetrics_egressTLSConnCount_addMutex;
	Mutexdef testMetrics_egressStreamCount_invocationsMutex;
	Mutexdef testMetrics_egressStreamCount_withMutex;
	Mutexdef testMetrics_egressStreamCount_setMutex;
	Mutexdef testMetrics_egressStreamCount_addMutex;
	Mutexdef testMetrics_egressQueueCapacity_invocationsMutex;
	Mutexdef testMetrics_egressQueueCapacity_withMutex;
	Mutexdef testMetrics_egressQueueCapacity_setMutex;
	Mutexdef testMetrics_egressQueueCapacity_addMutex;
	Mutexdef testMetrics_egressQueueLength_invocationsMutex;
	Mutexdef testMetrics_egressQueueLength_withMutex;
	Mutexdef testMetrics_egressQueueLength_setMutex;
	Mutexdef testMetrics_egressQueueLength_addMutex;
	run mutexMonitor(testMetrics_egressQueueLength_addMutex);
	run mutexMonitor(testMetrics_egressQueueLength_setMutex);
	run mutexMonitor(testMetrics_egressQueueLength_withMutex);
	run mutexMonitor(testMetrics_egressQueueLength_invocationsMutex);
	run mutexMonitor(testMetrics_egressQueueCapacity_addMutex);
	run mutexMonitor(testMetrics_egressQueueCapacity_setMutex);
	run mutexMonitor(testMetrics_egressQueueCapacity_withMutex);
	run mutexMonitor(testMetrics_egressQueueCapacity_invocationsMutex);
	run mutexMonitor(testMetrics_egressStreamCount_addMutex);
	run mutexMonitor(testMetrics_egressStreamCount_setMutex);
	run mutexMonitor(testMetrics_egressStreamCount_withMutex);
	run mutexMonitor(testMetrics_egressStreamCount_invocationsMutex);
	run mutexMonitor(testMetrics_egressTLSConnCount_addMutex);
	run mutexMonitor(testMetrics_egressTLSConnCount_setMutex);
	run mutexMonitor(testMetrics_egressTLSConnCount_withMutex);
	run mutexMonitor(testMetrics_egressTLSConnCount_invocationsMutex);
	run mutexMonitor(testMetrics_egressWorkerSize_addMutex);
	run mutexMonitor(testMetrics_egressWorkerSize_setMutex);
	run mutexMonitor(testMetrics_egressWorkerSize_withMutex);
	run mutexMonitor(testMetrics_egressWorkerSize_invocationsMutex);
	run mutexMonitor(testMetrics_ingressStreamsCount_addMutex);
	run mutexMonitor(testMetrics_ingressStreamsCount_setMutex);
	run mutexMonitor(testMetrics_ingressStreamsCount_withMutex);
	run mutexMonitor(testMetrics_ingressStreamsCount_invocationsMutex);
	run mutexMonitor(testMetrics_msgSendTime_observeMutex);
	run mutexMonitor(testMetrics_msgSendTime_withMutex);
	run mutexMonitor(testMetrics_msgSendTime_invocationsMutex);
	run mutexMonitor(testMetrics_msgDropCount_addMutex);
	run mutexMonitor(testMetrics_msgDropCount_withMutex);
	run mutexMonitor(testMetrics_msgDropCount_invocationsMutex);
	run initialize1171(testMetrics_egressQueueCapacity_addMutex,testMetrics_egressQueueCapacity_invocationsMutex,testMetrics_egressQueueCapacity_setMutex,testMetrics_egressQueueCapacity_withMutex,testMetrics_egressQueueLength_addMutex,testMetrics_egressQueueLength_invocationsMutex,testMetrics_egressQueueLength_setMutex,testMetrics_egressQueueLength_withMutex,testMetrics_egressStreamCount_addMutex,testMetrics_egressStreamCount_invocationsMutex,testMetrics_egressStreamCount_setMutex,testMetrics_egressStreamCount_withMutex,testMetrics_egressTLSConnCount_addMutex,testMetrics_egressTLSConnCount_invocationsMutex,testMetrics_egressTLSConnCount_setMutex,testMetrics_egressTLSConnCount_withMutex,testMetrics_egressWorkerSize_addMutex,testMetrics_egressWorkerSize_invocationsMutex,testMetrics_egressWorkerSize_setMutex,testMetrics_egressWorkerSize_withMutex,testMetrics_ingressStreamsCount_addMutex,testMetrics_ingressStreamsCount_invocationsMutex,testMetrics_ingressStreamsCount_setMutex,testMetrics_ingressStreamsCount_withMutex,testMetrics_msgDropCount_addMutex,testMetrics_msgDropCount_invocationsMutex,testMetrics_msgDropCount_withMutex,testMetrics_msgSendTime_invocationsMutex,testMetrics_msgSendTime_observeMutex,testMetrics_msgSendTime_withMutex,child_initialize11710);
	child_initialize11710?0;
	run SetArgsForCall91(testMetrics_ingressStreamsCount_addMutex,testMetrics_ingressStreamsCount_invocationsMutex,testMetrics_ingressStreamsCount_setMutex,testMetrics_ingressStreamsCount_withMutex,child_SetArgsForCall911);
	child_SetArgsForCall911?0;
	run SetArgsForCall91(testMetrics_ingressStreamsCount_addMutex,testMetrics_ingressStreamsCount_invocationsMutex,testMetrics_ingressStreamsCount_setMutex,testMetrics_ingressStreamsCount_withMutex,child_SetArgsForCall912);
	child_SetArgsForCall912?0;
	stop_process: skip;
	child!0
}
proctype initialize1171(Mutexdef tm_egressQueueCapacity_addMutex;Mutexdef tm_egressQueueCapacity_invocationsMutex;Mutexdef tm_egressQueueCapacity_setMutex;Mutexdef tm_egressQueueCapacity_withMutex;Mutexdef tm_egressQueueLength_addMutex;Mutexdef tm_egressQueueLength_invocationsMutex;Mutexdef tm_egressQueueLength_setMutex;Mutexdef tm_egressQueueLength_withMutex;Mutexdef tm_egressStreamCount_addMutex;Mutexdef tm_egressStreamCount_invocationsMutex;Mutexdef tm_egressStreamCount_setMutex;Mutexdef tm_egressStreamCount_withMutex;Mutexdef tm_egressTLSConnCount_addMutex;Mutexdef tm_egressTLSConnCount_invocationsMutex;Mutexdef tm_egressTLSConnCount_setMutex;Mutexdef tm_egressTLSConnCount_withMutex;Mutexdef tm_egressWorkerSize_addMutex;Mutexdef tm_egressWorkerSize_invocationsMutex;Mutexdef tm_egressWorkerSize_setMutex;Mutexdef tm_egressWorkerSize_withMutex;Mutexdef tm_ingressStreamsCount_addMutex;Mutexdef tm_ingressStreamsCount_invocationsMutex;Mutexdef tm_ingressStreamsCount_setMutex;Mutexdef tm_ingressStreamsCount_withMutex;Mutexdef tm_msgDropCount_addMutex;Mutexdef tm_msgDropCount_invocationsMutex;Mutexdef tm_msgDropCount_withMutex;Mutexdef tm_msgSendTime_invocationsMutex;Mutexdef tm_msgSendTime_observeMutex;Mutexdef tm_msgSendTime_withMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_WithReturns997 = [1] of {int};
	chan child_WithReturns996 = [1] of {int};
	chan child_WithReturns1355 = [1] of {int};
	chan child_WithReturns1354 = [1] of {int};
	chan child_WithReturns1353 = [1] of {int};
	chan child_WithReturns1352 = [1] of {int};
	chan child_WithReturns1351 = [1] of {int};
	chan child_WithReturns1350 = [1] of {int};
	run WithReturns135(tm_egressQueueLength_addMutex,tm_egressQueueLength_invocationsMutex,tm_egressQueueLength_setMutex,tm_egressQueueLength_withMutex,child_WithReturns1350);
	child_WithReturns1350?0;
	run WithReturns135(tm_egressQueueCapacity_addMutex,tm_egressQueueCapacity_invocationsMutex,tm_egressQueueCapacity_setMutex,tm_egressQueueCapacity_withMutex,child_WithReturns1351);
	child_WithReturns1351?0;
	run WithReturns135(tm_egressStreamCount_addMutex,tm_egressStreamCount_invocationsMutex,tm_egressStreamCount_setMutex,tm_egressStreamCount_withMutex,child_WithReturns1352);
	child_WithReturns1352?0;
	run WithReturns135(tm_egressTLSConnCount_addMutex,tm_egressTLSConnCount_invocationsMutex,tm_egressTLSConnCount_setMutex,tm_egressTLSConnCount_withMutex,child_WithReturns1353);
	child_WithReturns1353?0;
	run WithReturns135(tm_egressWorkerSize_addMutex,tm_egressWorkerSize_invocationsMutex,tm_egressWorkerSize_setMutex,tm_egressWorkerSize_withMutex,child_WithReturns1354);
	child_WithReturns1354?0;
	run WithReturns135(tm_ingressStreamsCount_addMutex,tm_ingressStreamsCount_invocationsMutex,tm_ingressStreamsCount_setMutex,tm_ingressStreamsCount_withMutex,child_WithReturns1355);
	child_WithReturns1355?0;
	run WithReturns99(tm_msgSendTime_invocationsMutex,tm_msgSendTime_observeMutex,tm_msgSendTime_withMutex,child_WithReturns996);
	child_WithReturns996?0;
	run WithReturns99(tm_msgDropCount_addMutex,tm_msgDropCount_invocationsMutex,tm_msgDropCount_withMutex,child_WithReturns997);
	child_WithReturns997?0;
	stop_process: skip;
	child!0
}
proctype WithReturns135(Mutexdef fake_addMutex;Mutexdef fake_invocationsMutex;Mutexdef fake_setMutex;Mutexdef fake_withMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	fake_withMutex.Lock!false;
		defer1: skip;
	fake_withMutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype WithReturns99(Mutexdef fake_invocationsMutex;Mutexdef fake_observeMutex;Mutexdef fake_withMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	fake_withMutex.Lock!false;
		defer1: skip;
	fake_withMutex.Unlock!false;
	stop_process: skip;
	child!0
}
proctype SetArgsForCall91(Mutexdef fake_addMutex;Mutexdef fake_invocationsMutex;Mutexdef fake_setMutex;Mutexdef fake_withMutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	fake_setMutex.RLock!false;
	goto defer1;
		defer1: skip;
	fake_setMutex.RUnlock!false;
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

