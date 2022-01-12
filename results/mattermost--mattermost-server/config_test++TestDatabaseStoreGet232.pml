// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/mattermost/mattermost-server/blob//config/database_test.go#L232
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDatabaseStoreGet2320 = [1] of {int};
	run TestDatabaseStoreGet232(child_TestDatabaseStoreGet2320);
	run receiver(child_TestDatabaseStoreGet2320)
stop_process:skip
}

proctype TestDatabaseStoreGet232(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close3500 = [1] of {int};
	chan child_Get1292 = [1] of {int};
	chan child_Get1291 = [1] of {int};
	Mutexdef ds_configLock;
	run mutexMonitor(ds_configLock);
	run Get129(ds_configLock,child_Get1291);
	child_Get1291?0;
	run Get129(ds_configLock,child_Get1292);
	child_Get1292?0;
		defer1: skip;
	run Close350(ds_configLock,child_Close3500);
	child_Close3500?0;
	stop_process: skip;
	child!0
}
proctype Close350(Mutexdef s_configLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_configLock.Lock!false;
	goto defer1;
		defer1: skip;
	s_configLock.Unlock!false;
	stop_process: skip;
	child!0
}
proctype Get129(Mutexdef s_configLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_configLock.RLock!false;
	goto defer1;
		defer1: skip;
	s_configLock.RUnlock!false;
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

