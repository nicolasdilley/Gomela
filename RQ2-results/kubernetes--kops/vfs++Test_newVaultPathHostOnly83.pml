
// https://github.com/kubernetes/kops/blob/master/util/pkg/vfs/vaultfs_test.go#L83
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_Test_newVaultPathHostOnly830 = [1] of {int};
	run Test_newVaultPathHostOnly83(child_Test_newVaultPathHostOnly830)
stop_process:skip
}

proctype Test_newVaultPathHostOnly83(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef __vaultClient_config_Limiter_mu;
	Mutexdef __vaultClient_config_modifyLock;
	Mutexdef __vaultClient_modifyLock;
	run mutexMonitor(__vaultClient_modifyLock);
	run mutexMonitor(__vaultClient_config_modifyLock);
	run mutexMonitor(__vaultClient_config_Limiter_mu);
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

