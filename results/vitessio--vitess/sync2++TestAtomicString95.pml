// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/sync2/atomic_test.go#L95
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAtomicString950 = [1] of {int};
	run TestAtomicString95(child_TestAtomicString950);
	run receiver(child_TestAtomicString950)
stop_process:skip
}

proctype TestAtomicString95(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Get1966 = [1] of {int};
	chan child_CompareAndSwap2045 = [1] of {int};
	chan child_Get1964 = [1] of {int};
	chan child_CompareAndSwap2043 = [1] of {int};
	chan child_Get1962 = [1] of {int};
	chan child_Set1891 = [1] of {int};
	chan child_Get1960 = [1] of {int};
	Mutexdef s_mu;
	run mutexMonitor(s_mu);
	run Get196(s_mu,child_Get1960);
	child_Get1960?0;
	run Set189(s_mu,child_Set1891);
	child_Set1891?0;
	run Get196(s_mu,child_Get1962);
	child_Get1962?0;
	run CompareAndSwap204(s_mu,child_CompareAndSwap2043);
	child_CompareAndSwap2043?0;
	run Get196(s_mu,child_Get1964);
	child_Get1964?0;
	run CompareAndSwap204(s_mu,child_CompareAndSwap2045);
	child_CompareAndSwap2045?0;
	run Get196(s_mu,child_Get1966);
	child_Get1966?0;
	stop_process: skip;
	child!0
}
proctype Get196(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.Lock!false;
	s_mu.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Set189(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.Lock!false;
	s_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype CompareAndSwap204(Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	s_mu.Unlock!false;
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

