// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/ethereum/go-ethereum/blob/b8040a430e34117f121c67e8deee4a5e889e8372/accounts/abi/bind/backends/simulated_test.go#L211
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}
typedef Mutexdef {
	chan Lock = [0] of {bool};
	chan Unlock = [0] of {bool};
	chan RLock = [0] of {bool};
	chan RUnlock = [0] of {bool};
	int Counter = 0;}



init { 
	chan child_TestSimulatedBackend_BlockByHash2110 = [1] of {int};
	run TestSimulatedBackend_BlockByHash211(child_TestSimulatedBackend_BlockByHash2110);
	run receiver(child_TestSimulatedBackend_BlockByHash2110)
stop_process:skip
}

proctype TestSimulatedBackend_BlockByHash211(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1010 = [1] of {int};
	chan child_BlockByHash2272 = [1] of {int};
	chan child_BlockByNumber2451 = [1] of {int};
	Mutexdef sim_mu;
	Wgdef sim_blockchain_wg;
	Mutexdef sim_blockchain_chainmu;
	run mutexMonitor(sim_blockchain_chainmu);
	run wgMonitor(sim_blockchain_wg);
	run mutexMonitor(sim_mu);
	run BlockByNumber245(sim_blockchain_wg,sim_blockchain_chainmu,sim_mu,child_BlockByNumber2451);
	child_BlockByNumber2451?0;
	run BlockByHash227(sim_blockchain_wg,sim_blockchain_chainmu,sim_mu,child_BlockByHash2272);
	child_BlockByHash2272?0;
		defer1: skip;
	run Close101(sim_blockchain_wg,sim_blockchain_chainmu,sim_mu,child_Close1010);
	child_Close1010?0;
	stop_process: skip;
	child!0
}
proctype Close101(Wgdef b_blockchain_wg;Mutexdef b_blockchain_chainmu;Mutexdef b_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype BlockByNumber245(Wgdef b_blockchain_wg;Mutexdef b_blockchain_chainmu;Mutexdef b_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_blockByNumberNoLock2541 = [1] of {int};
	b_mu.Lock!false;
	run blockByNumberNoLock254(b_blockchain_wg,b_blockchain_chainmu,b_mu,child_blockByNumberNoLock2541);
	child_blockByNumberNoLock2541?0;
	goto defer1;
		defer1: skip;
	b_mu.Unlock!false;
	stop_process: skip;
	child!0
}
proctype blockByNumberNoLock254(Wgdef b_blockchain_wg;Mutexdef b_blockchain_chainmu;Mutexdef b_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype BlockByHash227(Wgdef b_blockchain_wg;Mutexdef b_blockchain_chainmu;Mutexdef b_mu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	b_mu.Lock!false;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	b_mu.Unlock!false;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

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

