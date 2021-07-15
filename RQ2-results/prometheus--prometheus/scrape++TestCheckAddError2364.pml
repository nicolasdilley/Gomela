
// https://github.com/prometheus/prometheus/blob/master/scrape/scrape_test.go#L2364
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCheckAddError23640 = [1] of {int};
	run TestCheckAddError2364(child_TestCheckAddError23640)
stop_process:skip
}

proctype TestCheckAddError2364(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkAddError14300 = [1] of {int};
	Mutexdef sl_forcedErrMtx;
	Mutexdef sl_cache_metaMtx;
	run mutexMonitor(sl_cache_metaMtx);
	run mutexMonitor(sl_forcedErrMtx);
	run checkAddError1430(sl_cache_metaMtx,sl_forcedErrMtx,child_checkAddError14300);
	child_checkAddError14300?0;
	stop_process: skip;
	child!0
}
proctype checkAddError1430(Mutexdef sl_cache_metaMtx;Mutexdef sl_forcedErrMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_trackStaleness8550 = [1] of {int};
	

	if
	:: true -> 
		

		if
		:: true -> 
			run trackStaleness855(sl_cache_metaMtx,child_trackStaleness8550);
			child_trackStaleness8550?0
		:: true;
		fi;
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		goto stop_process
	fi;
	stop_process: skip;
	child!0
}
proctype trackStaleness855(Mutexdef c_metaMtx;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

