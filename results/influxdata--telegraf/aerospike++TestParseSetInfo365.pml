// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/aerospike/aerospike_test.go#L365
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestParseSetInfo3650 = [1] of {int};
	run TestParseSetInfo365(child_TestParseSetInfo3650);
	run receiver(child_TestParseSetInfo3650)
stop_process:skip
}

proctype TestParseSetInfo365(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_parseSetInfo3430 = [1] of {int};
	Mutexdef a_tlsConfig_mutex;
	run mutexMonitor(a_tlsConfig_mutex);
	run parseSetInfo343(a_tlsConfig_mutex,child_parseSetInfo3430);
	child_parseSetInfo3430?0;
	stop_process: skip;
	child!0
}
proctype parseSetInfo343(Mutexdef a_tlsConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_stat = -2; // opt var_stat
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

