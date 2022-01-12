// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/influxdata/telegraf/blob//plugins/inputs/sqlserver/sqlserver_test.go#L227
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSqlServer_MultipleInit2270 = [1] of {int};
	run TestSqlServer_MultipleInit227(child_TestSqlServer_MultipleInit2270);
	run receiver(child_TestSqlServer_MultipleInit2270)
stop_process:skip
}

proctype TestSqlServer_MultipleInit227(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Stop3423 = [1] of {int};
	chan child_Stop3422 = [1] of {int};
	chan child_initQueries1521 = [1] of {int};
	chan child_initQueries1520 = [1] of {int};
	Mutexdef s2_muCacheLock;
	Mutexdef s_muCacheLock;
	run mutexMonitor(s_muCacheLock);
	run mutexMonitor(s2_muCacheLock);
	run initQueries152(s_muCacheLock,child_initQueries1520);
	child_initQueries1520?0;
	run initQueries152(s2_muCacheLock,child_initQueries1521);
	child_initQueries1521?0;
	run Stop342(s_muCacheLock,child_Stop3422);
	child_Stop3422?0;
	run Stop342(s2_muCacheLock,child_Stop3423);
	child_Stop3423?0;
	stop_process: skip;
	child!0
}
proctype initQueries152(Mutexdef s_muCacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_queries = -2; // opt var_queries
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Stop342(Mutexdef s_muCacheLock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_s_pools = -2; // opt var_s_pools
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

