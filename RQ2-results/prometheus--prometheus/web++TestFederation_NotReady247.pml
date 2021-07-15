
// https://github.com/prometheus/prometheus/blob/master/web/federate_test.go#L247
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestFederation_NotReady2470 = [1] of {int};
	run TestFederation_NotReady247(child_TestFederation_NotReady2470)
stop_process:skip
}

proctype TestFederation_NotReady247(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef h_mtx;
	Mutexdef h_options_Notifier_mtx;
	Mutexdef h_options_RuleManager_mtx;
	Mutexdef h_options_ScrapeManager_mtxScrape;
	Mutexdef h_options_QueryEngine_queryLoggerLock;
	Mutexdef h_quitOnce_m;
	Mutexdef h_apiV1_QueryEngine_queryLoggerLock;
	Mutexdef h_notifier_mtx;
	Mutexdef h_queryEngine_queryLoggerLock;
	Mutexdef h_ruleManager_mtx;
	Mutexdef h_scrapeManager_mtxScrape;
	run mutexMonitor(h_scrapeManager_mtxScrape);
	run mutexMonitor(h_ruleManager_mtx);
	run mutexMonitor(h_queryEngine_queryLoggerLock);
	run mutexMonitor(h_notifier_mtx);
	run mutexMonitor(h_apiV1_QueryEngine_queryLoggerLock);
	run mutexMonitor(h_quitOnce_m);
	run mutexMonitor(h_options_QueryEngine_queryLoggerLock);
	run mutexMonitor(h_options_ScrapeManager_mtxScrape);
	run mutexMonitor(h_options_RuleManager_mtx);
	run mutexMonitor(h_options_Notifier_mtx);
	run mutexMonitor(h_mtx);
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

