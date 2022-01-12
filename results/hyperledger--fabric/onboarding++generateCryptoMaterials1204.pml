// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//orderer/common/onboarding/onboarding_test.go#L1204
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_generateCryptoMaterials12040 = [1] of {int};
	run generateCryptoMaterials1204(child_generateCryptoMaterials12040);
	run receiver(child_generateCryptoMaterials12040)
stop_process:skip
}

proctype generateCryptoMaterials1204(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef cryptogenProcess_lock;
	Mutexdef cryptogenProcess_Err_lock;
	Mutexdef cryptogenProcess_Out_lock;
	Mutexdef cryptogenProcess_Command_Process_sigMu;
	Mutexdef cmd_Process_sigMu;
	run mutexMonitor(cmd_Process_sigMu);
	run mutexMonitor(cryptogenProcess_Command_Process_sigMu);
	run mutexMonitor(cryptogenProcess_Out_lock);
	run mutexMonitor(cryptogenProcess_Err_lock);
	run mutexMonitor(cryptogenProcess_lock);
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

