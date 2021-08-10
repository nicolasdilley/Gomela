// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/p2p/discover/v5wire/encoding_test.go#L286
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestTestVectorsV52860 = [1] of {int};
	run TestTestVectorsV5286(child_TestTestVectorsV52860);
	run receiver(child_TestTestVectorsV52860)
stop_process:skip
}

proctype TestTestVectorsV5286(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_close5060 = [1] of {int};
	Mutexdef net_clock_mu;
	int var_tests = -2; // opt var_tests
	run mutexMonitor(net_clock_mu);
	run close506(net_clock_mu,child_close5060);
	child_close5060?0;
	stop_process: skip;
	child!0
}
proctype close506(Mutexdef t_clock_mu;chan child) {
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

