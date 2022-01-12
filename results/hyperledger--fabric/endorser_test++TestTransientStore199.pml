// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//core/endorser/plugin_endorser_test.go#L199
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTransientStore1990 = [1] of {int};
	run TestTransientStore199(child_TestTransientStore1990);
	run receiver(child_TestTransientStore1990)
stop_process:skip
}

proctype TestTransientStore199(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_tearDown650 = [1] of {int};
	chan child_Persist701 = [1] of {int};
	Mutexdef transientStore_store_db_db_mutex;
	run mutexMonitor(transientStore_store_db_db_mutex);
	run Persist70(transientStore_store_db_db_mutex,child_Persist701);
	child_Persist701?0;
		defer1: skip;
	run tearDown65(transientStore_store_db_db_mutex,child_tearDown650);
	child_tearDown650?0;
	stop_process: skip;
	child!0
}
proctype tearDown65(Mutexdef s_store_db_db_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Persist70(Mutexdef s_store_db_db_mutex;chan child) {
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

