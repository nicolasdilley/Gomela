// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/go-gorm/gorm/blob//schema/schema_test.go#L119
#define not_found_126  -2 // opt primaryFields line 13
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestParseSchemaWithAdvancedDataType1190 = [1] of {int};
	run TestParseSchemaWithAdvancedDataType119(child_TestParseSchemaWithAdvancedDataType1190);
	run receiver(child_TestParseSchemaWithAdvancedDataType1190)
stop_process:skip
}

proctype TestParseSchemaWithAdvancedDataType119(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkSchemaField381 = [1] of {int};
	chan child_checkSchemaField382 = [1] of {int};
	chan child_checkSchema130 = [1] of {int};
	Mutexdef user_cacheStore_mu;
	int var_fields = -2; // opt var_fields
	run mutexMonitor(user_cacheStore_mu);
	run checkSchema13(user_cacheStore_mu,not_found_126,child_checkSchema130);
	child_checkSchema130?0;
	

	if
	:: var_fields-1 != -3 -> 
				for(i : 0.. var_fields-1) {
			for10: skip;
			run checkSchemaField38(user_cacheStore_mu,child_checkSchemaField381);
			child_checkSchemaField381?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run checkSchemaField38(user_cacheStore_mu,child_checkSchemaField382);
			child_checkSchemaField382?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype checkSchema13(Mutexdef s_cacheStore_mu;int var_primaryFields;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_s_PrimaryFields = -2; // opt var_s_PrimaryFields
	stop_process: skip;
	child!0
}
proctype checkSchemaField38(Mutexdef s_cacheStore_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_s_PrimaryFields = -2; // opt var_s_PrimaryFields
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

