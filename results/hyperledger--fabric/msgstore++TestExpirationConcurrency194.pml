// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//gossip/gossip/msgstore/msgs_test.go#L194
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestExpirationConcurrency1940 = [1] of {int};
	run TestExpirationConcurrency194(child_TestExpirationConcurrency1940);
	run receiver(child_TestExpirationConcurrency1940)
stop_process:skip
}

proctype TestExpirationConcurrency194(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Mutexdef lock;
	run mutexMonitor(lock);
	lock.Lock!false;
	lock.Unlock!false;
	lock.Lock!false;
	lock.Unlock!false;
	lock.Lock!false;
	lock.Unlock!false;
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

