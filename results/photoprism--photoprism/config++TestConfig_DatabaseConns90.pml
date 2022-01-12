// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/db_test.go#L90
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_DatabaseConns900 = [1] of {int};
	run TestConfig_DatabaseConns90(child_TestConfig_DatabaseConns900);
	run receiver(child_TestConfig_DatabaseConns900)
stop_process:skip
}

proctype TestConfig_DatabaseConns90(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DatabaseConns1721 = [1] of {int};
	chan child_DatabaseConns1720 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run DatabaseConns172(c_db_values_mu,c_once_m,child_DatabaseConns1720);
	child_DatabaseConns1720?0;
	run DatabaseConns172(c_db_values_mu,c_once_m,child_DatabaseConns1721);
	child_DatabaseConns1721?0;
	stop_process: skip;
	child!0
}
proctype DatabaseConns172(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
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

