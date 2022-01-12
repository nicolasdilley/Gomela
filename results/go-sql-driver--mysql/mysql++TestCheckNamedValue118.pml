// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-sql-driver/mysql/blob//connection_test.go#L118
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCheckNamedValue1180 = [1] of {int};
	run TestCheckNamedValue118(child_TestCheckNamedValue1180);
	run receiver(child_TestCheckNamedValue1180)
stop_process:skip
}

proctype TestCheckNamedValue118(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CheckNamedValue6310 = [1] of {int};
	Mutexdef x_cfg_tls_mutex;
	run mutexMonitor(x_cfg_tls_mutex);
	run CheckNamedValue631(x_cfg_tls_mutex,child_CheckNamedValue6310);
	child_CheckNamedValue6310?0;
	stop_process: skip;
	child!0
}
proctype CheckNamedValue631(Mutexdef mc_cfg_tls_mutex;chan child) {
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

