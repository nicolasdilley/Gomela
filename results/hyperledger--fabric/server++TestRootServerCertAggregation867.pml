// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/hyperledger/fabric/blob//orderer/common/server/main_test.go#L867
#define not_found_886  -2 // opt localClusterRootCAs line 1020
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestRootServerCertAggregation8670 = [1] of {int};
	run TestRootServerCertAggregation867(child_TestRootServerCertAggregation8670);
	run receiver(child_TestRootServerCertAggregation8670)
stop_process:skip
}

proctype TestRootServerCertAggregation867(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_updateClusterDialer10180 = [1] of {int};
	Mutexdef predDialer_lock;
	run mutexMonitor(predDialer_lock);
	run updateClusterDialer1018(predDialer_lock,not_found_886,child_updateClusterDialer10180);
	child_updateClusterDialer10180?0;
	stop_process: skip;
	child!0
}
proctype updateClusterDialer1018(Mutexdef clusterDialer_lock;int var_localClusterRootCAs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_UpdateRootCAs1380 = [1] of {int};
	int var_clusterRootCAs = -2; // opt var_clusterRootCAs
	int var_orgRootCAs = -2; // opt var_orgRootCAs
	int var_mgr_ordererRootCAsByChain = -2; // opt var_mgr_ordererRootCAsByChain
	run UpdateRootCAs138(clusterDialer_lock,child_UpdateRootCAs1380);
	child_UpdateRootCAs1380?0;
	stop_process: skip;
	child!0
}
proctype UpdateRootCAs138(Mutexdef dialer_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	dialer_lock.Lock!false;
		defer1: skip;
	dialer_lock.Unlock!false;
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

