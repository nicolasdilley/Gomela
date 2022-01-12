// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//internal/peer/channel/create_test.go#L267
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestCreateChainWithWaitSuccess2670 = [1] of {int};
	run TestCreateChainWithWaitSuccess267(child_TestCreateChainWithWaitSuccess2670);
	run receiver(child_TestCreateChainWithWaitSuccess2670)
stop_process:skip
}

proctype TestCreateChainWithWaitSuccess267(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Shutdown700 = [1] of {int};
	Mutexdef fakeOrderer_t_context_mu;
	Mutexdef fakeOrderer_t_context_match_mu;
	run mutexMonitor(fakeOrderer_t_context_match_mu);
	run mutexMonitor(fakeOrderer_t_context_mu);
		defer1: skip;
	run Shutdown70(fakeOrderer_t_context_match_mu,fakeOrderer_t_context_mu,child_Shutdown700);
	child_Shutdown700?0;
	stop_process: skip;
	child!0
}
proctype Shutdown70(Mutexdef o_t_context_match_mu;Mutexdef o_t_context_mu;chan child) {
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

