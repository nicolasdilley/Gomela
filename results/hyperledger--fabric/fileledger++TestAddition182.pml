// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//common/ledger/blockledger/fileledger/impl_test.go#L182
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestAddition1820 = [1] of {int};
	run TestAddition182(child_TestAddition1820);
	run receiver(child_TestAddition1820)
stop_process:skip
}

proctype TestAddition182(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_tearDown550 = [1] of {int};
	Mutexdef tev_t_context_mu;
	Mutexdef tev_t_context_match_mu;
	run mutexMonitor(tev_t_context_match_mu);
	run mutexMonitor(tev_t_context_mu);
		defer1: skip;
	run tearDown55(tev_t_context_match_mu,tev_t_context_mu,child_tearDown550);
	child_tearDown550?0;
	stop_process: skip;
	child!0
}
proctype tearDown55(Mutexdef tev_t_context_match_mu;Mutexdef tev_t_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_shutDown630 = [1] of {int};
	run shutDown63(tev_t_context_match_mu,tev_t_context_mu,child_shutDown630);
	child_shutDown630?0;
	stop_process: skip;
	child!0
}
proctype shutDown63(Mutexdef tev_t_context_match_mu;Mutexdef tev_t_context_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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

