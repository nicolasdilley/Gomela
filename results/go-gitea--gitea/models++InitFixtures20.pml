
// https://github.com/go-gitea/gitea/blob/master/models/test_fixtures.go#L20
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_InitFixtures200 = [1] of {int};
	run InitFixtures20(child_InitFixtures200)
stop_process:skip
}

proctype InitFixtures20(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef e_db_reflectCacheMutex;
	Mutexdef e_tagParser_tableCache_mu;
	Mutexdef e_tagParser_cacherMgr_cacherLock;
	Mutexdef e_cacherMgr_cacherLock;
	run mutexMonitor(e_cacherMgr_cacherLock);
	run mutexMonitor(e_tagParser_cacherMgr_cacherLock);
	run mutexMonitor(e_tagParser_tableCache_mu);
	run mutexMonitor(e_db_reflectCacheMutex);
	

	if
	:: true;
	:: true;
	:: true;
	:: true;
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

