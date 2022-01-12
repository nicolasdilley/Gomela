// num_comm_params=3
// num_mand_comm_params=0
// num_opt_comm_params=3

// git_link=https://github.com/cloudreve/Cloudreve/blob//pkg/cache/memo_test.go#L120
#define not_found_124  -2 // opt values line 99
#define not_found_132  -2 // opt keys line 107
#define not_found_134  -2 // opt keys line 83
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMemoStore_Delete1200 = [1] of {int};
	run TestMemoStore_Delete120(child_TestMemoStore_Delete1200);
	run receiver(child_TestMemoStore_Delete1200)
stop_process:skip
}

proctype TestMemoStore_Delete120(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Gets832 = [1] of {int};
	chan child_Delete1071 = [1] of {int};
	chan child_Sets990 = [1] of {int};
	Mutexdef store_Store_mu;
	run mutexMonitor(store_Store_mu);
	run Sets99(store_Store_mu,not_found_124,child_Sets990);
	child_Sets990?0;
	run Delete107(store_Store_mu,not_found_132,child_Delete1071);
	child_Delete1071?0;
	run Gets83(store_Store_mu,not_found_134,child_Gets832);
	child_Gets832?0;
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
proctype Delete107(Mutexdef store_Store_mu;int var_keys;chan child) {
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

