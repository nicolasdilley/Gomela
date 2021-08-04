// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/kubernetes/kubernetes/blob/0277cff2682d5a0d3c6fa2109f7f82e8db3f2ed8/pkg/registry/core/componentstatus/validator_test.go#L34
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestValidate340 = [1] of {int};
	run TestValidate34(child_TestValidate340);
	run receiver(child_TestValidate340)
stop_process:skip
}

proctype TestValidate34(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_DoServerCheck590 = [1] of {int};
	chan child_DoServerCheck591 = [1] of {int};
	Mutexdef s_Once_m;
	Mutexdef s_TLSConfig_mutex;
	int var_tests = -2; // opt var_tests
	run mutexMonitor(s_TLSConfig_mutex);
	run mutexMonitor(s_Once_m);
	

	if
	:: var_tests-1 != -3 -> 
				for(i : 0.. var_tests-1) {
			for10: skip;
			run DoServerCheck59(s_Once_m,s_TLSConfig_mutex,child_DoServerCheck590);
			child_DoServerCheck590?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run DoServerCheck59(s_Once_m,s_TLSConfig_mutex,child_DoServerCheck591);
			child_DoServerCheck591?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype DoServerCheck59(Mutexdef server_Once_m;Mutexdef server_TLSConfig_mutex;chan child) {
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
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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

