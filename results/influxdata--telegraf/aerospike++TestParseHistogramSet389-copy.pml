// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/aerospike/aerospike_test.go#L389
#define def_var_stats  -2 // opt stats line 404
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestParseHistogramSet3890 = [1] of {int};
	run TestParseHistogramSet389(child_TestParseHistogramSet3890);
	run receiver(child_TestParseHistogramSet3890)
stop_process:skip
}

proctype TestParseHistogramSet389(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_parseHistogram4040 = [1] of {int};
	int var_stats = def_var_stats;
	Mutexdef a_tlsConfig_mutex;
	run mutexMonitor(a_tlsConfig_mutex);
	run parseHistogram404(a_tlsConfig_mutex,var_stats,child_parseHistogram4040);
	child_parseHistogram4040?0;
	stop_process: skip;
	child!0
}
proctype parseHistogram404(Mutexdef a_tlsConfig_mutex;int var_stats;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_buckets = -2; // opt var_buckets
	int var_strings_Split = -2; // opt var_strings_Split
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

