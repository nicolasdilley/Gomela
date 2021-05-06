
// https://github.com/prometheus/prometheus/blob/master/scrape/scrape_test.go#L55
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNewScrapePool550 = [1] of {int};
	run TestNewScrapePool55(child_TestNewScrapePool550)
stop_process:skip
}

proctype TestNewScrapePool55(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef sp_targetMtx;
	Mutexdef sp_mtx;
	run mutexMonitor(sp_mtx);
	run mutexMonitor(sp_targetMtx);
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

