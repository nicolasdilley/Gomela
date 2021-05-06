
// https://github.com/rclone/rclone/blob/master/backend/crypt/cipher_test.go#L681
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_testEncryptDecrypt6810 = [1] of {int};
	run testEncryptDecrypt681(child_testEncryptDecrypt6810)
stop_process:skip
}

proctype testEncryptDecrypt681(chan child) {
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

