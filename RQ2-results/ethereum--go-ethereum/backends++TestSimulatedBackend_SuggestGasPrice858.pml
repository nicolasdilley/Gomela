
// https://github.com/ethereum/go-ethereum/blob/master/accounts/abi/bind/backends/simulated_test.go#L858
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
	chan child_TestSimulatedBackend_SuggestGasPrice8580 = [1] of {int};
	run TestSimulatedBackend_SuggestGasPrice858(child_TestSimulatedBackend_SuggestGasPrice8580)
stop_process:skip
}

proctype TestSimulatedBackend_SuggestGasPrice858(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Close1010 = [1] of {int};
	chan child_SuggestGasPrice4301 = [1] of {int};
	Mutexdef sim_pendingState_snaps_lock;
	Mutexdef sim_pendingState_snaps_triedb_lock;
	Mutexdef sim_mu;
	Wgdef sim_blockchain_wg;
	Mutexdef sim_blockchain_futureBlocks_lock;
	Mutexdef sim_blockchain_txLookupCache_lock;
	Mutexdef sim_blockchain_blockCache_lock;
	Mutexdef sim_blockchain_receiptsCache_lock;
	Mutexdef sim_blockchain_bodyRLPCache_lock;
	Mutexdef sim_blockchain_bodyCache_lock;
	Mutexdef sim_blockchain_chainmu;
	Mutexdef sim_blockchain_scope_mu;
	Mutexdef sim_blockchain_blockProcFeed_mu;
	Mutexdef sim_blockchain_blockProcFeed_once_m;
	Mutexdef sim_blockchain_logsFeed_mu;
	Mutexdef sim_blockchain_logsFeed_once_m;
	Mutexdef sim_blockchain_chainHeadFeed_mu;
	Mutexdef sim_blockchain_chainHeadFeed_once_m;
	Mutexdef sim_blockchain_chainSideFeed_mu;
	Mutexdef sim_blockchain_chainSideFeed_once_m;
	Mutexdef sim_blockchain_chainFeed_mu;
	Mutexdef sim_blockchain_chainFeed_once_m;
	Mutexdef sim_blockchain_rmLogsFeed_mu;
	Mutexdef sim_blockchain_rmLogsFeed_once_m;
	Mutexdef sim_blockchain_hc_numberCache_lock;
	Mutexdef sim_blockchain_hc_tdCache_lock;
	Mutexdef sim_blockchain_hc_headerCache_lock;
	Mutexdef sim_blockchain_snaps_lock;
	Mutexdef sim_blockchain_snaps_triedb_lock;
	run mutexMonitor(sim_blockchain_snaps_triedb_lock);
	run mutexMonitor(sim_blockchain_snaps_lock);
	run mutexMonitor(sim_blockchain_hc_headerCache_lock);
	run mutexMonitor(sim_blockchain_hc_tdCache_lock);
	run mutexMonitor(sim_blockchain_hc_numberCache_lock);
	run mutexMonitor(sim_blockchain_rmLogsFeed_once_m);
	run mutexMonitor(sim_blockchain_rmLogsFeed_mu);
	run mutexMonitor(sim_blockchain_chainFeed_once_m);
	run mutexMonitor(sim_blockchain_chainFeed_mu);
	run mutexMonitor(sim_blockchain_chainSideFeed_once_m);
	run mutexMonitor(sim_blockchain_chainSideFeed_mu);
	run mutexMonitor(sim_blockchain_chainHeadFeed_once_m);
	run mutexMonitor(sim_blockchain_chainHeadFeed_mu);
	run mutexMonitor(sim_blockchain_logsFeed_once_m);
	run mutexMonitor(sim_blockchain_logsFeed_mu);
	run mutexMonitor(sim_blockchain_blockProcFeed_once_m);
	run mutexMonitor(sim_blockchain_blockProcFeed_mu);
	run mutexMonitor(sim_blockchain_scope_mu);
	run mutexMonitor(sim_blockchain_chainmu);
	run mutexMonitor(sim_blockchain_bodyCache_lock);
	run mutexMonitor(sim_blockchain_bodyRLPCache_lock);
	run mutexMonitor(sim_blockchain_receiptsCache_lock);
	run mutexMonitor(sim_blockchain_blockCache_lock);
	run mutexMonitor(sim_blockchain_txLookupCache_lock);
	run mutexMonitor(sim_blockchain_futureBlocks_lock);
	run wgMonitor(sim_blockchain_wg);
	run mutexMonitor(sim_mu);
	run mutexMonitor(sim_pendingState_snaps_triedb_lock);
	run mutexMonitor(sim_pendingState_snaps_lock);
	run SuggestGasPrice430(sim_blockchain_wg,sim_blockchain_snaps_triedb_lock,sim_blockchain_snaps_lock,sim_blockchain_hc_headerCache_lock,sim_blockchain_hc_tdCache_lock,sim_blockchain_hc_numberCache_lock,sim_blockchain_rmLogsFeed_once_m,sim_blockchain_rmLogsFeed_mu,sim_blockchain_chainFeed_once_m,sim_blockchain_chainFeed_mu,sim_blockchain_chainSideFeed_once_m,sim_blockchain_chainSideFeed_mu,sim_blockchain_chainHeadFeed_once_m,sim_blockchain_chainHeadFeed_mu,sim_blockchain_logsFeed_once_m,sim_blockchain_logsFeed_mu,sim_blockchain_blockProcFeed_once_m,sim_blockchain_blockProcFeed_mu,sim_blockchain_scope_mu,sim_blockchain_chainmu,sim_blockchain_bodyCache_lock,sim_blockchain_bodyRLPCache_lock,sim_blockchain_receiptsCache_lock,sim_blockchain_blockCache_lock,sim_blockchain_txLookupCache_lock,sim_blockchain_futureBlocks_lock,sim_mu,sim_pendingState_snaps_triedb_lock,sim_pendingState_snaps_lock,child_SuggestGasPrice4301);
	child_SuggestGasPrice4301?0;
	stop_process: skip;
		run Close101(sim_blockchain_wg,sim_blockchain_snaps_triedb_lock,sim_blockchain_snaps_lock,sim_blockchain_hc_headerCache_lock,sim_blockchain_hc_tdCache_lock,sim_blockchain_hc_numberCache_lock,sim_blockchain_rmLogsFeed_once_m,sim_blockchain_rmLogsFeed_mu,sim_blockchain_chainFeed_once_m,sim_blockchain_chainFeed_mu,sim_blockchain_chainSideFeed_once_m,sim_blockchain_chainSideFeed_mu,sim_blockchain_chainHeadFeed_once_m,sim_blockchain_chainHeadFeed_mu,sim_blockchain_logsFeed_once_m,sim_blockchain_logsFeed_mu,sim_blockchain_blockProcFeed_once_m,sim_blockchain_blockProcFeed_mu,sim_blockchain_scope_mu,sim_blockchain_chainmu,sim_blockchain_bodyCache_lock,sim_blockchain_bodyRLPCache_lock,sim_blockchain_receiptsCache_lock,sim_blockchain_blockCache_lock,sim_blockchain_txLookupCache_lock,sim_blockchain_futureBlocks_lock,sim_mu,sim_pendingState_snaps_triedb_lock,sim_pendingState_snaps_lock,child_Close1010);
	child_Close1010?0;
	child!0
}
proctype Close101(Wgdef b_blockchain_wg;Mutexdef b_blockchain_snaps_triedb_lock;Mutexdef b_blockchain_snaps_lock;Mutexdef b_blockchain_hc_headerCache_lock;Mutexdef b_blockchain_hc_tdCache_lock;Mutexdef b_blockchain_hc_numberCache_lock;Mutexdef b_blockchain_rmLogsFeed_once_m;Mutexdef b_blockchain_rmLogsFeed_mu;Mutexdef b_blockchain_chainFeed_once_m;Mutexdef b_blockchain_chainFeed_mu;Mutexdef b_blockchain_chainSideFeed_once_m;Mutexdef b_blockchain_chainSideFeed_mu;Mutexdef b_blockchain_chainHeadFeed_once_m;Mutexdef b_blockchain_chainHeadFeed_mu;Mutexdef b_blockchain_logsFeed_once_m;Mutexdef b_blockchain_logsFeed_mu;Mutexdef b_blockchain_blockProcFeed_once_m;Mutexdef b_blockchain_blockProcFeed_mu;Mutexdef b_blockchain_scope_mu;Mutexdef b_blockchain_chainmu;Mutexdef b_blockchain_bodyCache_lock;Mutexdef b_blockchain_bodyRLPCache_lock;Mutexdef b_blockchain_receiptsCache_lock;Mutexdef b_blockchain_blockCache_lock;Mutexdef b_blockchain_txLookupCache_lock;Mutexdef b_blockchain_futureBlocks_lock;Mutexdef b_mu;Mutexdef b_pendingState_snaps_triedb_lock;Mutexdef b_pendingState_snaps_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype SuggestGasPrice430(Wgdef b_blockchain_wg;Mutexdef b_blockchain_snaps_triedb_lock;Mutexdef b_blockchain_snaps_lock;Mutexdef b_blockchain_hc_headerCache_lock;Mutexdef b_blockchain_hc_tdCache_lock;Mutexdef b_blockchain_hc_numberCache_lock;Mutexdef b_blockchain_rmLogsFeed_once_m;Mutexdef b_blockchain_rmLogsFeed_mu;Mutexdef b_blockchain_chainFeed_once_m;Mutexdef b_blockchain_chainFeed_mu;Mutexdef b_blockchain_chainSideFeed_once_m;Mutexdef b_blockchain_chainSideFeed_mu;Mutexdef b_blockchain_chainHeadFeed_once_m;Mutexdef b_blockchain_chainHeadFeed_mu;Mutexdef b_blockchain_logsFeed_once_m;Mutexdef b_blockchain_logsFeed_mu;Mutexdef b_blockchain_blockProcFeed_once_m;Mutexdef b_blockchain_blockProcFeed_mu;Mutexdef b_blockchain_scope_mu;Mutexdef b_blockchain_chainmu;Mutexdef b_blockchain_bodyCache_lock;Mutexdef b_blockchain_bodyRLPCache_lock;Mutexdef b_blockchain_receiptsCache_lock;Mutexdef b_blockchain_blockCache_lock;Mutexdef b_blockchain_txLookupCache_lock;Mutexdef b_blockchain_futureBlocks_lock;Mutexdef b_mu;Mutexdef b_pendingState_snaps_triedb_lock;Mutexdef b_pendingState_snaps_lock;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
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

