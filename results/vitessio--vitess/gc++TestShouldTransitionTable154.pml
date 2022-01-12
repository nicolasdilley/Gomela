// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/vitessio/vitess/blob//go/vt/vttablet/tabletserver/gc/tablegc_test.go#L154
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
	chan child_TestShouldTransitionTable1540 = [1] of {int};
	run TestShouldTransitionTable154(child_TestShouldTransitionTable1540);
	run receiver(child_TestShouldTransitionTable1540)
stop_process:skip
}

proctype TestShouldTransitionTable154(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_shouldTransitionTable3270 = [1] of {int};
	chan child_shouldTransitionTable3271 = [1] of {int};
	Mutexdef collector_purgeMutex;
	Mutexdef collector_initMutex;
	Mutexdef collector_ts_mu;
	Mutexdef collector_pool_dbaPool_connections_reopenMutex;
	Wgdef collector_pool_dbaPool_connections_refreshWg;
	Mutexdef collector_pool_dbaPool_mu;
	Mutexdef collector_pool_connections_reopenMutex;
	Wgdef collector_pool_connections_refreshWg;
	Mutexdef collector_pool_connections_idleTimer_mu;
	Mutexdef collector_pool_mu;
	Mutexdef collector_throttlerClient_throttler_throttledAppsMutex;
	Mutexdef collector_throttlerClient_throttler_initMutex;
	Mutexdef collector_throttlerClient_throttler_ts_mu;
	Mutexdef collector_throttlerClient_throttler_pool_mu;
	int var_tt = -2; // opt var_tt
	run mutexMonitor(collector_throttlerClient_throttler_pool_mu);
	run mutexMonitor(collector_throttlerClient_throttler_ts_mu);
	run mutexMonitor(collector_throttlerClient_throttler_initMutex);
	run mutexMonitor(collector_throttlerClient_throttler_throttledAppsMutex);
	run mutexMonitor(collector_pool_mu);
	run mutexMonitor(collector_pool_connections_idleTimer_mu);
	run wgMonitor(collector_pool_connections_refreshWg);
	run mutexMonitor(collector_pool_connections_reopenMutex);
	run mutexMonitor(collector_pool_dbaPool_mu);
	run wgMonitor(collector_pool_dbaPool_connections_refreshWg);
	run mutexMonitor(collector_pool_dbaPool_connections_reopenMutex);
	run mutexMonitor(collector_ts_mu);
	run mutexMonitor(collector_initMutex);
	run mutexMonitor(collector_purgeMutex);
	

	if
	:: var_tt-1 != -3 -> 
				for(i : 0.. var_tt-1) {
			for10: skip;
			run shouldTransitionTable327(collector_pool_connections_refreshWg,collector_pool_dbaPool_connections_refreshWg,collector_initMutex,collector_pool_connections_idleTimer_mu,collector_pool_connections_reopenMutex,collector_pool_dbaPool_connections_reopenMutex,collector_pool_dbaPool_mu,collector_pool_mu,collector_purgeMutex,collector_throttlerClient_throttler_initMutex,collector_throttlerClient_throttler_pool_mu,collector_throttlerClient_throttler_throttledAppsMutex,collector_throttlerClient_throttler_ts_mu,collector_ts_mu,child_shouldTransitionTable3270);
			child_shouldTransitionTable3270?0;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			run shouldTransitionTable327(collector_pool_connections_refreshWg,collector_pool_dbaPool_connections_refreshWg,collector_initMutex,collector_pool_connections_idleTimer_mu,collector_pool_connections_reopenMutex,collector_pool_dbaPool_connections_reopenMutex,collector_pool_dbaPool_mu,collector_pool_mu,collector_purgeMutex,collector_throttlerClient_throttler_initMutex,collector_throttlerClient_throttler_pool_mu,collector_throttlerClient_throttler_throttledAppsMutex,collector_throttlerClient_throttler_ts_mu,collector_ts_mu,child_shouldTransitionTable3271);
			child_shouldTransitionTable3271?0;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	stop_process: skip;
	child!0
}
proctype shouldTransitionTable327(Wgdef collector_pool_connections_refreshWg;Wgdef collector_pool_dbaPool_connections_refreshWg;Mutexdef collector_initMutex;Mutexdef collector_pool_connections_idleTimer_mu;Mutexdef collector_pool_connections_reopenMutex;Mutexdef collector_pool_dbaPool_connections_reopenMutex;Mutexdef collector_pool_dbaPool_mu;Mutexdef collector_pool_mu;Mutexdef collector_purgeMutex;Mutexdef collector_throttlerClient_throttler_initMutex;Mutexdef collector_throttlerClient_throttler_pool_mu;Mutexdef collector_throttlerClient_throttler_throttledAppsMutex;Mutexdef collector_throttlerClient_throttler_ts_mu;Mutexdef collector_ts_mu;chan child) {
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
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
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

proctype receiver(chan c) {
c?0
}

