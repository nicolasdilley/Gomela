// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/minio/minio/blob/e948e7cdf65028f7a8545d1a05c2baea75198bd0/pkg/certs/certs_test.go#L46
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestNewManager460 = [1] of {int};
	run TestNewManager46(child_TestNewManager460);
	run receiver(child_TestNewManager460)
stop_process:skip
}

proctype TestNewManager46(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetCertificate2520 = [1] of {int};
	Mutexdef hello_config_mutex;
	Mutexdef c_lock;
	run mutexMonitor(c_lock);
	run mutexMonitor(hello_config_mutex);
	run GetCertificate252(c_lock,hello_config_mutex,child_GetCertificate2520);
	child_GetCertificate2520?0;
	stop_process: skip;
	child!0
}
proctype GetCertificate252(Mutexdef m_lock;Mutexdef hello_config_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_m_certificates = -2; // opt var_m_certificates
	m_lock.RLock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	m_lock.RUnlock!false;
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

