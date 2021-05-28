// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/go-gorm/gorm/blob/70e93e73d8c739a81e27b0cb73aa5513cafb63e0/schema/field_test.go#L240
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestParseFieldWithPermission2400 = [1] of {int};
	run TestParseFieldWithPermission240(child_TestParseFieldWithPermission2400);
	run receiver(child_TestParseFieldWithPermission2400)
stop_process:skip
}

proctype TestParseFieldWithPermission240(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkSchemaField380 = [1] of {int};
	chan child_checkSchemaField381 = [1] of {int};
	Mutexdef user_cacheStore_mu;
	int fields = -2; // opt fields
	run mutexMonitor(user_cacheStore_mu);
	

	if
	:: fields-1 != -3 -> 
				for(i : 0.. fields-1) {
			for10: skip;
			run checkSchemaField38(user_cacheStore_mu,child_checkSchemaField380);
			child_checkSchemaField380?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run checkSchemaField38(user_cacheStore_mu,child_checkSchemaField381);
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
	int s_PrimaryFields = -2; // opt s_PrimaryFields
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

