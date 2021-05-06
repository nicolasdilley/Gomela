
// https://github.com/ethereum/go-ethereum/blob/master/eth/gasprice/gasprice_test.go#L58
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
	chan child_newTestBackend580 = [1] of {int};
	run newTestBackend58(child_newTestBackend580)
stop_process:skip
}

proctype newTestBackend58(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef chain_wg;
	Mutexdef chain_futureBlocks_lock;
	Mutexdef chain_txLookupCache_lock;
	Mutexdef chain_blockCache_lock;
	Mutexdef chain_receiptsCache_lock;
	Mutexdef chain_bodyRLPCache_lock;
	Mutexdef chain_bodyCache_lock;
	Mutexdef chain_chainmu;
	Mutexdef chain_scope_mu;
	Mutexdef chain_blockProcFeed_mu;
	Mutexdef chain_blockProcFeed_once_m;
	Mutexdef chain_logsFeed_mu;
	Mutexdef chain_logsFeed_once_m;
	Mutexdef chain_chainHeadFeed_mu;
	Mutexdef chain_chainHeadFeed_once_m;
	Mutexdef chain_chainSideFeed_mu;
	Mutexdef chain_chainSideFeed_once_m;
	Mutexdef chain_chainFeed_mu;
	Mutexdef chain_chainFeed_once_m;
	Mutexdef chain_rmLogsFeed_mu;
	Mutexdef chain_rmLogsFeed_once_m;
	Mutexdef chain_hc_numberCache_lock;
	Mutexdef chain_hc_tdCache_lock;
	Mutexdef chain_hc_headerCache_lock;
	Mutexdef chain_snaps_lock;
	Mutexdef chain_snaps_triedb_lock;
	Mutexdef engine_closeOnce_m;
	Mutexdef engine_lock;
	Wgdef engine_remote_reqWG;
	Mutexdef engine_datasets_mu;
	Mutexdef engine_caches_mu;
	run mutexMonitor(engine_caches_mu);
	run mutexMonitor(engine_datasets_mu);
	run wgMonitor(engine_remote_reqWG);
	run mutexMonitor(engine_lock);
	run mutexMonitor(engine_closeOnce_m);
	run mutexMonitor(chain_snaps_triedb_lock);
	run mutexMonitor(chain_snaps_lock);
	run mutexMonitor(chain_hc_headerCache_lock);
	run mutexMonitor(chain_hc_tdCache_lock);
	run mutexMonitor(chain_hc_numberCache_lock);
	run mutexMonitor(chain_rmLogsFeed_once_m);
	run mutexMonitor(chain_rmLogsFeed_mu);
	run mutexMonitor(chain_chainFeed_once_m);
	run mutexMonitor(chain_chainFeed_mu);
	run mutexMonitor(chain_chainSideFeed_once_m);
	run mutexMonitor(chain_chainSideFeed_mu);
	run mutexMonitor(chain_chainHeadFeed_once_m);
	run mutexMonitor(chain_chainHeadFeed_mu);
	run mutexMonitor(chain_logsFeed_once_m);
	run mutexMonitor(chain_logsFeed_mu);
	run mutexMonitor(chain_blockProcFeed_once_m);
	run mutexMonitor(chain_blockProcFeed_mu);
	run mutexMonitor(chain_scope_mu);
	run mutexMonitor(chain_chainmu);
	run mutexMonitor(chain_bodyCache_lock);
	run mutexMonitor(chain_bodyRLPCache_lock);
	run mutexMonitor(chain_receiptsCache_lock);
	run mutexMonitor(chain_blockCache_lock);
	run mutexMonitor(chain_txLookupCache_lock);
	run mutexMonitor(chain_futureBlocks_lock);
	run wgMonitor(chain_wg);
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

