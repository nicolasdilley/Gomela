
// https://github.com/istio/istio/blob/master/security/pkg/nodeagent/cache/secretcache_test.go#L253
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRootCertificateExists2530 = [1] of {int};
	run TestRootCertificateExists253(child_TestRootCertificateExists2530)
stop_process:skip
}

proctype TestRootCertificateExists253(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_rootCertificateExist3660 = [1] of {int};
	chan child_rootCertificateExist3661 = [1] of {int};
	Mutexdef sc_configTrustBundleMutex;
	Mutexdef sc_outputMutex;
	Mutexdef sc_certMutex;
	Mutexdef sc_certWatcher_mu;
	Mutexdef sc_generateMutex;
	Mutexdef sc_cache_mu;
	int testCases = -2;
	run mutexMonitor(sc_cache_mu);
	run mutexMonitor(sc_generateMutex);
	run mutexMonitor(sc_certWatcher_mu);
	run mutexMonitor(sc_certMutex);
	run mutexMonitor(sc_outputMutex);
	run mutexMonitor(sc_configTrustBundleMutex);
	

	if
	:: testCases-1 != -3 -> 
				for(i : 0.. testCases-1) {
			for10: skip;
			run rootCertificateExist366(sc_cache_mu,sc_generateMutex,sc_certWatcher_mu,sc_certMutex,sc_outputMutex,sc_configTrustBundleMutex,child_rootCertificateExist3660);
			child_rootCertificateExist3660?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run rootCertificateExist366(sc_cache_mu,sc_generateMutex,sc_certWatcher_mu,sc_certMutex,sc_outputMutex,sc_configTrustBundleMutex,child_rootCertificateExist3661);
			child_rootCertificateExist3661?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype rootCertificateExist366(Mutexdef sc_cache_mu;Mutexdef sc_generateMutex;Mutexdef sc_certWatcher_mu;Mutexdef sc_certMutex;Mutexdef sc_outputMutex;Mutexdef sc_configTrustBundleMutex;chan child) {
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

