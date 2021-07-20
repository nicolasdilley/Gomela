// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/p2p/dnsdisc/client_test.go#L43
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestClientSyncTree430 = [1] of {int};
	run TestClientSyncTree43(child_TestClientSyncTree430);
	run receiver(child_TestClientSyncTree430)
stop_process:skip
}

proctype TestClientSyncTree43(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_SyncTree1120 = [1] of {int};
	Mutexdef c_singleflight_mu;
	Mutexdef c_ratelimit_mu;
	Mutexdef c_entries_lock;
	run mutexMonitor(c_entries_lock);
	run mutexMonitor(c_ratelimit_mu);
	run mutexMonitor(c_singleflight_mu);
	run SyncTree112(c_entries_lock,c_ratelimit_mu,c_singleflight_mu,child_SyncTree1120);
	child_SyncTree1120?0;
	stop_process: skip;
	child!0
}
proctype SyncTree112(Mutexdef c_entries_lock;Mutexdef c_ratelimit_mu;Mutexdef c_singleflight_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_newClientTree500 = [1] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run newClientTree50(c_entries_lock,c_ratelimit_mu,c_singleflight_mu,child_newClientTree500);
	child_newClientTree500?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype newClientTree50(Mutexdef c_entries_lock;Mutexdef c_ratelimit_mu;Mutexdef c_singleflight_mu;chan child) {
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

