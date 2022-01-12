// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob//metrics/meter_test.go#L24
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestMeterDecay240 = [1] of {int};
	run TestMeterDecay24(child_TestMeterDecay240);
	run receiver(child_TestMeterDecay240)
stop_process:skip
}

proctype TestMeterDecay24(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_RateMean2352 = [1] of {int};
	chan child_RateMean2351 = [1] of {int};
	chan child_Mark2090 = [1] of {int};
	Mutexdef m_lock;
	run mutexMonitor(m_lock);
	run Mark209(m_lock,child_Mark2090);
	child_Mark2090?0;
	run RateMean235(m_lock,child_RateMean2351);
	child_RateMean2351?0;
	run RateMean235(m_lock,child_RateMean2352);
	child_RateMean2352?0;
	stop_process: skip;
	child!0
}
proctype Mark209(Mutexdef m_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype RateMean235(Mutexdef m_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	m_lock.RLock!false;
	goto defer1;
		defer1: skip;
	m_lock.RUnlock!false;
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

