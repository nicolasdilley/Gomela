// num_comm_params=2
// num_mand_comm_params=0
// num_opt_comm_params=2

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/crypto/tls/tls_test.go#L1170
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestBuildNameToCertificate_doesntModifyCertificates11700 = [1] of {int};
	run TestBuildNameToCertificate_doesntModifyCertificates1170(child_TestBuildNameToCertificate_doesntModifyCertificates11700);
	run receiver(child_TestBuildNameToCertificate_doesntModifyCertificates11700)
stop_process:skip
}

proctype TestBuildNameToCertificate_doesntModifyCertificates1170(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_BuildNameToCertificate12780 = [1] of {int};
	Mutexdef config_mutex;
	run mutexMonitor(config_mutex);
	run BuildNameToCertificate1278(config_mutex,child_BuildNameToCertificate12780);
	child_BuildNameToCertificate12780?0;
	stop_process: skip;
	child!0
}
proctype BuildNameToCertificate1278(Mutexdef c_mutex;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_x509Cert_DNSNamesx509Cert_DNSNames = -2; // opt var_x509Cert_DNSNamesx509Cert_DNSNames
	int var_c_Certificatesc_Certificates = -2; // opt var_c_Certificatesc_Certificates
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

