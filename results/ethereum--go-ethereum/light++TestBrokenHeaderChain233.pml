
// https://github.com/ethereum/go-ethereum/blob/master/light/lightchain_test.go#L233
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
	chan child_TestBrokenHeaderChain2330 = [1] of {int};
	run TestBrokenHeaderChain233(child_TestBrokenHeaderChain2330)
stop_process:skip
}

proctype TestBrokenHeaderChain233(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_testHeaderChainImport1190 = [1] of {int};
	Wgdef LightChain_wg;
	Mutexdef LightChain_chainmu;
	Mutexdef LightChain_blockCache_lock;
	Mutexdef LightChain_bodyRLPCache_lock;
	Mutexdef LightChain_bodyCache_lock;
	Mutexdef LightChain_scope_mu;
	Mutexdef LightChain_chainHeadFeed_mu;
	Mutexdef LightChain_chainHeadFeed_once_m;
	Mutexdef LightChain_chainSideFeed_mu;
	Mutexdef LightChain_chainSideFeed_once_m;
	Mutexdef LightChain_chainFeed_mu;
	Mutexdef LightChain_chainFeed_once_m;
	Mutexdef LightChain_hc_numberCache_lock;
	Mutexdef LightChain_hc_tdCache_lock;
	Mutexdef LightChain_hc_headerCache_lock;
	int chain=0;
	run mutexMonitor(LightChain_hc_headerCache_lock);
	run mutexMonitor(LightChain_hc_tdCache_lock);
	run mutexMonitor(LightChain_hc_numberCache_lock);
	run mutexMonitor(LightChain_chainFeed_once_m);
	run mutexMonitor(LightChain_chainFeed_mu);
	run mutexMonitor(LightChain_chainSideFeed_once_m);
	run mutexMonitor(LightChain_chainSideFeed_mu);
	run mutexMonitor(LightChain_chainHeadFeed_once_m);
	run mutexMonitor(LightChain_chainHeadFeed_mu);
	run mutexMonitor(LightChain_scope_mu);
	run mutexMonitor(LightChain_bodyCache_lock);
	run mutexMonitor(LightChain_bodyRLPCache_lock);
	run mutexMonitor(LightChain_blockCache_lock);
	run mutexMonitor(LightChain_chainmu);
	run wgMonitor(LightChain_wg);
	run testHeaderChainImport119(LightChain_wg,LightChain_hc_headerCache_lock,LightChain_hc_tdCache_lock,LightChain_hc_numberCache_lock,LightChain_chainFeed_once_m,LightChain_chainFeed_mu,LightChain_chainSideFeed_once_m,LightChain_chainSideFeed_mu,LightChain_chainHeadFeed_once_m,LightChain_chainHeadFeed_mu,LightChain_scope_mu,LightChain_bodyCache_lock,LightChain_bodyRLPCache_lock,LightChain_blockCache_lock,LightChain_chainmu,chain,child_testHeaderChainImport1190);
	child_testHeaderChainImport1190?0;
	stop_process: skip;
	child!0
}
proctype testHeaderChainImport119(Wgdef lightchain_wg;Mutexdef lightchain_hc_headerCache_lock;Mutexdef lightchain_hc_tdCache_lock;Mutexdef lightchain_hc_numberCache_lock;Mutexdef lightchain_chainFeed_once_m;Mutexdef lightchain_chainFeed_mu;Mutexdef lightchain_chainSideFeed_once_m;Mutexdef lightchain_chainSideFeed_mu;Mutexdef lightchain_chainHeadFeed_once_m;Mutexdef lightchain_chainHeadFeed_mu;Mutexdef lightchain_scope_mu;Mutexdef lightchain_bodyCache_lock;Mutexdef lightchain_bodyRLPCache_lock;Mutexdef lightchain_blockCache_lock;Mutexdef lightchain_chainmu;int chain;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetTdByHash4350 = [1] of {int};
	chan child_GetTdByHash4351 = [1] of {int};
	

	if
	:: chain-1 != -3 -> 
				for(i : 0.. chain-1) {
			for10: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			lightchain_chainmu.Lock!false;
			run GetTdByHash435(lightchain_wg,lightchain_hc_headerCache_lock,lightchain_hc_tdCache_lock,lightchain_hc_numberCache_lock,lightchain_chainFeed_once_m,lightchain_chainFeed_mu,lightchain_chainSideFeed_once_m,lightchain_chainSideFeed_mu,lightchain_chainHeadFeed_once_m,lightchain_chainHeadFeed_mu,lightchain_scope_mu,lightchain_bodyCache_lock,lightchain_bodyRLPCache_lock,lightchain_blockCache_lock,lightchain_chainmu,child_GetTdByHash4350);
			child_GetTdByHash4350?0;
			lightchain_chainmu.Unlock!false;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			lightchain_chainmu.Lock!false;
			run GetTdByHash435(lightchain_wg,lightchain_hc_headerCache_lock,lightchain_hc_tdCache_lock,lightchain_hc_numberCache_lock,lightchain_chainFeed_once_m,lightchain_chainFeed_mu,lightchain_chainSideFeed_once_m,lightchain_chainSideFeed_mu,lightchain_chainHeadFeed_once_m,lightchain_chainHeadFeed_mu,lightchain_scope_mu,lightchain_bodyCache_lock,lightchain_bodyRLPCache_lock,lightchain_blockCache_lock,lightchain_chainmu,child_GetTdByHash4351);
			child_GetTdByHash4351?0;
			lightchain_chainmu.Unlock!false;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype GetTdByHash435(Wgdef lc_wg;Mutexdef lc_hc_headerCache_lock;Mutexdef lc_hc_tdCache_lock;Mutexdef lc_hc_numberCache_lock;Mutexdef lc_chainFeed_once_m;Mutexdef lc_chainFeed_mu;Mutexdef lc_chainSideFeed_once_m;Mutexdef lc_chainSideFeed_mu;Mutexdef lc_chainHeadFeed_once_m;Mutexdef lc_chainHeadFeed_mu;Mutexdef lc_scope_mu;Mutexdef lc_bodyCache_lock;Mutexdef lc_bodyRLPCache_lock;Mutexdef lc_blockCache_lock;Mutexdef lc_chainmu;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_GetTdByHash4350 = [1] of {int};
	run GetTdByHash435(lc_hc_headerCache_lock,lc_hc_tdCache_lock,lc_hc_numberCache_lock,child_GetTdByHash4350);
	child_GetTdByHash4350?0;
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


