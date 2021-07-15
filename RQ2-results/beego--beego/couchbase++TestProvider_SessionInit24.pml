
// https://github.com/beego/beego/blob/master/server/web/session/couchbase/sess_couchbase_test.go#L24
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestProvider_SessionInit240 = [1] of {int};
	run TestProvider_SessionInit24(child_TestProvider_SessionInit240)
stop_process:skip
}

proctype TestProvider_SessionInit24(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SessionInit1421 = [1] of {int};
	chan child_SessionInit1420 = [1] of {int};
	Mutexdef cp_b_pool_client_tlsConfig_mutex;
	run mutexMonitor(cp_b_pool_client_tlsConfig_mutex);
	run SessionInit142(cp_b_pool_client_tlsConfig_mutex,child_SessionInit1420);
	child_SessionInit1420?0;
	run SessionInit142(cp_b_pool_client_tlsConfig_mutex,child_SessionInit1421);
	child_SessionInit1421?0;
	stop_process: skip;
	child!0
}
proctype SessionInit142(Mutexdef cp_b_pool_client_tlsConfig_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_initOldStyle1540 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		run initOldStyle154(cp_b_pool_client_tlsConfig_mutex,child_initOldStyle1540);
		child_initOldStyle1540?0;
		goto stop_process
	fi;
	stop_process: skip;
	child!0
}
proctype initOldStyle154(Mutexdef cp_b_pool_client_tlsConfig_mutex;chan child) {
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

