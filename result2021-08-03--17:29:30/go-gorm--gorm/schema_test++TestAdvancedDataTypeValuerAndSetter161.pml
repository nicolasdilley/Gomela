// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/go-gorm/gorm/blob/70e93e73d8c739a81e27b0cb73aa5513cafb63e0/schema/field_test.go#L161
#define not_found_189  -2 // opt values line 203
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAdvancedDataTypeValuerAndSetter1610 = [1] of {int};
	run TestAdvancedDataTypeValuerAndSetter161(child_TestAdvancedDataTypeValuerAndSetter1610);
	run receiver(child_TestAdvancedDataTypeValuerAndSetter1610)
stop_process:skip
}

proctype TestAdvancedDataTypeValuerAndSetter161(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_checkField2032 = [1] of {int};
	chan child_checkField2031 = [1] of {int};
	chan child_checkField2030 = [1] of {int};
	Mutexdef userSchema_cacheStore_mu;
	int var_newValues2 = -2; // opt var_newValues2
	int var_newValues = -2; // opt var_newValues
	run mutexMonitor(userSchema_cacheStore_mu);
	run checkField203(userSchema_cacheStore_mu,not_found_189,child_checkField2030);
	child_checkField2030?0;
	run checkField203(userSchema_cacheStore_mu,var_newValues,child_checkField2031);
	child_checkField2031?0;
	run checkField203(userSchema_cacheStore_mu,var_newValues2,child_checkField2032);
	child_checkField2032?0;
	stop_process: skip;
	child!0
}
proctype checkField203(Mutexdef s_cacheStore_mu;int var_values;chan child) {
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

proctype receiver(chan c) {
c?0
}
