// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//orderer/common/server/server_test.go#L149
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestDeliverNoChannel1490 = [1] of {int};
	run TestDeliverNoChannel149(child_TestDeliverNoChannel1490);
	run receiver(child_TestDeliverNoChannel1490)
stop_process:skip
}

proctype TestDeliverNoChannel149(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef r_joinBlockFileRepo_mu;
	Mutexdef r_clusterDialer_lock;
	Mutexdef r_lock;
	run mutexMonitor(r_lock);
	run mutexMonitor(r_clusterDialer_lock);
	run mutexMonitor(r_joinBlockFileRepo_mu);
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

