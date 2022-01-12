// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-sql-driver/mysql/blob//dsn_test.go#L307
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestParamsAreSorted3070 = [1] of {int};
	run TestParamsAreSorted307(child_TestParamsAreSorted3070);
	run receiver(child_TestParamsAreSorted3070)
stop_process:skip
}

proctype TestParamsAreSorted307(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_FormatDSN1680 = [1] of {int};
	Mutexdef cfg_tls_mutex;
	run mutexMonitor(cfg_tls_mutex);
	run FormatDSN168(cfg_tls_mutex,child_FormatDSN1680);
	child_FormatDSN1680?0;
	stop_process: skip;
	child!0
}
proctype FormatDSN168(Mutexdef cfg_tls_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_params = -2; // opt var_params
	int var_cfg_Params = -2; // opt var_cfg_Params
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

