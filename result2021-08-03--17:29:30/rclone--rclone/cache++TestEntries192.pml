// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/rclone/rclone/blob/a223b78872dc7a8713ca2aa4596ae3e30c173cdd/lib/cache/cache_test.go#L192
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestEntries1920 = [1] of {int};
	run TestEntries192(child_TestEntries1920);
	run receiver(child_TestEntries1920)
stop_process:skip
}

proctype TestEntries192(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Entries1724 = [1] of {int};
	chan child_Clear1633 = [1] of {int};
	chan child_Entries1722 = [1] of {int};
	chan child_Get561 = [1] of {int};
	chan child_Entries1720 = [1] of {int};
	Mutexdef c_mu;
	run mutexMonitor(c_mu);
	run Entries172(c_mu,child_Entries1720);
	child_Entries1720?0;
	run Get56(c_mu,child_Get561);
	child_Get561?0;
	run Entries172(c_mu,child_Entries1722);
	child_Entries1722?0;
	run Clear163(c_mu,child_Clear1633);
	child_Clear1633?0;
	run Entries172(c_mu,child_Entries1724);
	child_Entries1724?0;
	stop_process: skip;
	child!0
}
proctype Entries172(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_mu.Lock!false;
	c_mu.Unlock!false;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Get56(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_used461 = [1] of {int};
	c_mu.Lock!false;
	

	if
	:: true -> 
		c_mu.Unlock!false;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		c_mu.Lock!false
	:: true;
	fi;
	run used46(c_mu,child_used461);
	child_used461?0;
	goto defer1;
		defer1: skip;
	c_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype used46(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype Clear163(Mutexdef c_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_c_cache = -2; // opt var_c_cache
	c_mu.Lock!false;
	c_mu.Unlock!false;
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

