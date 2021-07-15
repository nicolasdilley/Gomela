#define relations11  -2

// https://github.com/go-gorm/gorm/blob/master/schema/relationship_test.go#L11
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_checkStructRelation110 = [1] of {int};
	run checkStructRelation11(relations11,child_checkStructRelation110)
stop_process:skip
}

proctype checkStructRelation11(int relations;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkSchemaRelation1230 = [1] of {int};
	chan child_checkSchemaRelation1231 = [1] of {int};
	Mutexdef s_cacheStore_mu;
	run mutexMonitor(s_cacheStore_mu);
	

	if
	:: true -> 
		

		if
		:: relations-1 != -3 -> 
						for(i : 0.. relations-1) {
				for10: skip;
				run checkSchemaRelation123(s_cacheStore_mu,child_checkSchemaRelation1230);
				child_checkSchemaRelation1230?0;
				for10_end: skip
			};
			for10_exit: skip
		:: else -> 
			do
			:: true -> 
				for11: skip;
				run checkSchemaRelation123(s_cacheStore_mu,child_checkSchemaRelation1231);
				child_checkSchemaRelation1231?0;
				for11_end: skip
			:: true -> 
				break
			od;
			for11_exit: skip
		fi
	fi;
	stop_process: skip;
	child!0
}
proctype checkSchemaRelation123(Mutexdef s_cacheStore_mu;chan child) {
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

