// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/cloudreve/Cloudreve/blob//pkg/cache/memo_test.go#L98
#define not_found_102  -2 // opt values line 99
#define not_found_110  -2 // opt keys line 83
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMemoStore_Sets980 = [1] of {int};
	run TestMemoStore_Sets98(child_TestMemoStore_Sets980);
	run receiver(child_TestMemoStore_Sets980)
stop_process:skip
}

proctype TestMemoStore_Sets98(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Gets831 = [1] of {int};
	chan child_Sets990 = [1] of {int};
	Mutexdef store_Store_mu;
	run mutexMonitor(store_Store_mu);
	run Sets99(store_Store_mu,not_found_102,child_Sets990);
	child_Sets990?0;
	run Gets83(store_Store_mu,not_found_110,child_Gets831);
	child_Gets831?0;
	stop_process: skip;
	child!0
}
proctype Sets99(Mutexdef store_Store_mu;int var_values;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Gets83(Mutexdef store_Store_mu;int var_keys;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

proctype receiver(chan c) {
c?0
}

