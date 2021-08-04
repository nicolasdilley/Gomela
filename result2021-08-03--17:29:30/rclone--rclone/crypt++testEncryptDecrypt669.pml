// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/rclone/rclone/blob/a223b78872dc7a8713ca2aa4596ae3e30c173cdd/backend/crypt/cipher_test.go#L669
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testEncryptDecrypt6690 = [1] of {int};
	run testEncryptDecrypt669(child_testEncryptDecrypt6690);
	run receiver(child_testEncryptDecrypt6690)
stop_process:skip
}

proctype testEncryptDecrypt669(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef decrypted_mu;
	Mutexdef encrypted_mu;
	run mutexMonitor(encrypted_mu);
	run mutexMonitor(decrypted_mu);
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

