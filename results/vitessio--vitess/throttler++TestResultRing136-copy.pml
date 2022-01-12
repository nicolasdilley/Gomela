// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/throttler/result_test.go#L136
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestResultRing1360 = [1] of {int};
	run TestResultRing136(child_TestResultRing1360);
	run receiver(child_TestResultRing1360)
stop_process:skip
}

proctype TestResultRing136(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_latestValues1515 = [1] of {int};
	chan child_add1374 = [1] of {int};
	chan child_latestValues1513 = [1] of {int};
	chan child_add1372 = [1] of {int};
	chan child_latestValues1511 = [1] of {int};
	chan child_add1370 = [1] of {int};
	Mutexdef rr_mu;
	run mutexMonitor(rr_mu);
	run add137(rr_mu,child_add1370);
	child_add1370?0;
	run latestValues151(rr_mu,child_latestValues1511);
	child_latestValues1511?0;
	run add137(rr_mu,child_add1372);
	child_add1372?0;
	run latestValues151(rr_mu,child_latestValues1513);
	child_latestValues1513?0;
	run add137(rr_mu,child_add1374);
	child_add1374?0;
	run latestValues151(rr_mu,child_latestValues1515);
	child_latestValues1515?0;
	stop_process: skip;
	child!0
}
proctype add137(Mutexdef rr_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	rr_mu.Lock!false;
		defer1: skip;
	rr_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype latestValues151(Mutexdef rr_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_count = -2; // opt var_count
	rr_mu.Lock!false;
	goto defer1;
		defer1: skip;
	rr_mu.Unlock!false;
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

