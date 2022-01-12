// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/photoprism/photoprism/blob//internal/config/config_test.go#L312
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConfig_StaticUri3120 = [1] of {int};
	run TestConfig_StaticUri312(child_TestConfig_StaticUri3120);
	run receiver(child_TestConfig_StaticUri3120)
stop_process:skip
}

proctype TestConfig_StaticUri312(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_StaticUri2943 = [1] of {int};
	chan child_StaticUri2942 = [1] of {int};
	chan child_StaticUri2941 = [1] of {int};
	chan child_StaticUri2940 = [1] of {int};
	Mutexdef c_db_values_mu;
	Mutexdef c_once_m;
	run mutexMonitor(c_once_m);
	run mutexMonitor(c_db_values_mu);
	run StaticUri294(c_db_values_mu,c_once_m,child_StaticUri2940);
	child_StaticUri2940?0;
	run StaticUri294(c_db_values_mu,c_once_m,child_StaticUri2941);
	child_StaticUri2941?0;
	run StaticUri294(c_db_values_mu,c_once_m,child_StaticUri2942);
	child_StaticUri2942?0;
	run StaticUri294(c_db_values_mu,c_once_m,child_StaticUri2943);
	child_StaticUri2943?0;
	stop_process: skip;
	child!0
}
proctype StaticUri294(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CdnUrl2840 = [1] of {int};
	run CdnUrl284(c_db_values_mu,c_once_m,child_CdnUrl2840);
	child_CdnUrl2840?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype CdnUrl284(Mutexdef c_db_values_mu;Mutexdef c_once_m;chan child) {
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

