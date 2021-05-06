
// https://github.com/go-gorm/gorm/blob/master/schema/schema_test.go#L166
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNestedModel1660 = [1] of {int};
	run TestNestedModel166(child_TestNestedModel1660)
stop_process:skip
}

proctype TestNestedModel166(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkSchemaField380 = [1] of {int};
	chan child_checkSchemaField381 = [1] of {int};
	Mutexdef versionUser_cacheStore_mu;
	int fields = -2;
	run mutexMonitor(versionUser_cacheStore_mu);
	

	if
	:: fields-1 != -3 -> 
				for(i : 0.. fields-1) {
			for10: skip;
			run checkSchemaField38(versionUser_cacheStore_mu,child_checkSchemaField380);
			child_checkSchemaField380?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run checkSchemaField38(versionUser_cacheStore_mu,child_checkSchemaField381);
			child_checkSchemaField381?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype checkSchemaField38(Mutexdef s_cacheStore_mu;chan child) {
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

