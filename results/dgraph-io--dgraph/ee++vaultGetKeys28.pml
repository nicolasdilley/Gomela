
// https://github.com/dgraph-io/dgraph/blob/master/ee/vault_ee.go#L28
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_vaultGetKeys280 = [1] of {int};
	run vaultGetKeys28(child_vaultGetKeys280)
stop_process:skip
}

proctype vaultGetKeys28(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_vaultGetKvStore750 = [1] of {int};
	Mutexdef client_config_Limiter_mu;
	Mutexdef client_config_modifyLock;
	Mutexdef client_modifyLock;
	

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
	run mutexMonitor(client_modifyLock);
	run mutexMonitor(client_config_modifyLock);
	run mutexMonitor(client_config_Limiter_mu);
	run vaultGetKvStore75(client_modifyLock,client_config_modifyLock,client_config_Limiter_mu,child_vaultGetKvStore750);
	child_vaultGetKvStore750?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype vaultGetKvStore75(Mutexdef client_modifyLock;Mutexdef client_config_modifyLock;Mutexdef client_config_Limiter_mu;chan child) {
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

