// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/serviceregistration/consul/consul_service_registration_test.go#L358
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestConsul_serviceTags3580 = [1] of {int};
	run TestConsul_serviceTags358(child_TestConsul_serviceTags3580);
	run receiver(child_TestConsul_serviceTags3580)
stop_process:skip
}

proctype TestConsul_serviceTags358(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_fetchServiceTags5210 = [1] of {int};
	chan child_fetchServiceTags5211 = [1] of {int};
	Mutexdef c_serviceLock;
	int var_tests = -2; // opt var_tests
	run mutexMonitor(c_serviceLock);
	

	if
	:: var_tests-1 != -3 -> 
				for(i : 0.. var_tests-1) {
			for10: skip;
			run fetchServiceTags521(c_serviceLock,child_fetchServiceTags5210);
			child_fetchServiceTags5210?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run fetchServiceTags521(c_serviceLock,child_fetchServiceTags5211);
			child_fetchServiceTags5211?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype fetchServiceTags521(Mutexdef c_serviceLock;chan child) {
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

