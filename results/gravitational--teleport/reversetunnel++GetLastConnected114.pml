// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gravitational/teleport/blob//lib/reversetunnel/peer.go#L114
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_GetLastConnected1140 = [1] of {int};
	run GetLastConnected114(child_GetLastConnected1140);
	run receiver(child_GetLastConnected1140)
stop_process:skip
}

proctype GetLastConnected114(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetLastConnected2130 = [1] of {int};
	Mutexdef peer_mu;
	Mutexdef peer_log_Logger_mu_lock;
	run mutexMonitor(peer_log_Logger_mu_lock);
	run mutexMonitor(peer_mu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run GetLastConnected213(peer_log_Logger_mu_lock,peer_mu,child_GetLastConnected2130);
	child_GetLastConnected2130?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetLastConnected213(Mutexdef s_log_Logger_mu_lock;Mutexdef s_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	s_mu.Lock!false;
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

