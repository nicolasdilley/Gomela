// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gravitational/teleport/blob//lib/reversetunnel/peer.go#L102
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_GetStatus1020 = [1] of {int};
	run GetStatus102(child_GetStatus1020);
	run receiver(child_GetStatus1020)
stop_process:skip
}

proctype GetStatus102(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetStatus2010 = [1] of {int};
	Mutexdef peer_mu;
	Mutexdef peer_log_Logger_mu_lock;
	run mutexMonitor(peer_log_Logger_mu_lock);
	run mutexMonitor(peer_mu);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run GetStatus201(peer_log_Logger_mu_lock,peer_mu,child_GetStatus2010);
	child_GetStatus2010?0;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetStatus201(Mutexdef s_log_Logger_mu_lock;Mutexdef s_mu;chan child) {
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

