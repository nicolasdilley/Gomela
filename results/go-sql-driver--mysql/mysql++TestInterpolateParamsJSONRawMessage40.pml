// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-sql-driver/mysql/blob//connection_test.go#L40
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestInterpolateParamsJSONRawMessage400 = [1] of {int};
	run TestInterpolateParamsJSONRawMessage40(child_TestInterpolateParamsJSONRawMessage400);
	run receiver(child_TestInterpolateParamsJSONRawMessage400)
stop_process:skip
}

proctype TestInterpolateParamsJSONRawMessage40(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_interpolateParams1980 = [1] of {int};
	Mutexdef mc_cfg_tls_mutex;
	run mutexMonitor(mc_cfg_tls_mutex);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run interpolateParams198(mc_cfg_tls_mutex,"SELECT ?",child_interpolateParams1980);
	child_interpolateParams1980?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype interpolateParams198(Mutexdef mc_cfg_tls_mutex;int var_query;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
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

